import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/repositories/user_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/common/return_arrow.dart';

class SetAliasScreen extends StatefulWidget {
  const SetAliasScreen({super.key});

  @override
  State<SetAliasScreen> createState() => _SetAliasScreenState();
}

class _SetAliasScreenState extends State<SetAliasScreen> {
  final _userRepository = UserRepository();
  final _controller = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadAlias();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadAlias() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final user = await _userRepository.getUser(uid);
    if (!mounted) return;
    _controller.text = user?.alias ?? '';
  }

  Future<void> _save() async {
    final alias = _controller.text.trim();
    if (alias.isEmpty) return;
    setState(() => _loading = true);
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _userRepository.updateProfile(uid, alias: alias);
    if (mounted) {
      setState(() => _loading = false);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          ReturnArrow(customRoute: '/profile'),
          const SizedBox(width: 12),
          const Text(
            'Cambiar alias',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.bgSecondary,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          BorderedContainer(
            borderWidth: 2,
            borderColor: AppColors.borderAccent,
            backgroundColor: AppColors.bgPrimary,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                autofocus: true,
                cursorColor: AppColors.textPrimary,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Tu alias',
                  hintStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _loading
              ? const Center(child: CircularProgressIndicator())
              : CustomButton(
                  label: 'Guardar',
                  fontSize: 18,
                  onPressed: _save,
                ),
        ],
      ),
    );
  }
}