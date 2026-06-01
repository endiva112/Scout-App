import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/repositories/user_repository.dart';
import 'package:scout_app/theme/app_colors.dart';

class LocationContainer extends StatefulWidget {
  const LocationContainer({super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  final _userRepository = UserRepository();
  final _paisController   = TextEditingController();
  final _regionController = TextEditingController();
  final _ciudadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  @override
  void dispose() {
    _paisController.dispose();
    _regionController.dispose();
    _ciudadController.dispose();
    super.dispose();
  }

  Future<void> _loadLocation() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final user = await _userRepository.getUser(uid);
    if (!mounted) return;
    final location = user?.scout?.location;
    if (location == null) return;
    _paisController.text = location.country;
    _regionController.text = location.region;
    _ciudadController.text = location.city;
  }

  Future<void> _onSave() async {
    FocusScope.of(context).unfocus();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final location = ScoutLocation(
      country: _paisController.text.trim(),
      region: _regionController.text.trim(),
      city: _ciudadController.text.trim(),
    );
    await _userRepository.updateLocation(uid, location);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildField(_paisController, 'País'),
        const SizedBox(height: 10),
        _buildField(_regionController, 'Región'),
        const SizedBox(height: 10),
        _buildField(_ciudadController, 'Ciudad'),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _onSave,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.contrastSecondary,
            foregroundColor: AppColors.actionSecondary,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text(
            'GUARDAR UBICACIÓN',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textTerciary),
        filled: true,
        fillColor: AppColors.bgPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}