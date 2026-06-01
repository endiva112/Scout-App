import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/repositories/user_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
import 'package:scout_app/widgets/collections/store_missions_collection.dart';
import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';
import 'package:scout_app/widgets/common/progress_bar.dart';

class ScoutScreen extends StatefulWidget {
  const ScoutScreen({super.key});

  @override
  State<ScoutScreen> createState() => _ScoutScreenState();
}

class _ScoutScreenState extends State<ScoutScreen> {
  final _userRepository = UserRepository();

  AppUser? _user;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    if (firebaseUser.isAnonymous) {
      setState(() => _loading = false);
      return;
    }
    final user = await _userRepository.getUser(firebaseUser.uid);
    if (!mounted) return;
    setState(() {
      _user = user;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MainHeader(),
            Expanded(child: _buildBody(context)),
            BottomNavBar(activeIndex: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: BorderedContainer(
                backgroundColor: AppColors.contrastSecondary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildLevelCard(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildSubContainers(context),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: _buildMissionSection(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard() {
    final scout = _user?.scout;
    final level = scout?.level ?? 0;
    final points = scout?.points ?? 0;
    final progress = (points % 1000) / 1000;
    final pointsToNext = 1000 - (points % 1000);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildText('Tu nivel actual', 16, FontWeight.w400, AppColors.textTerciary),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText('Nivel $level', 24, FontWeight.w600, AppColors.actionSecondary),
            _buildText('$points puntos', 24, FontWeight.w600, AppColors.actionSecondary),
          ],
        ),
        const SizedBox(height: 5),
        ProgressBar(
          customBackgroundColor: AppColors.bgPrimary,
          customColor: AppColors.actionSecondary,
          progress: progress,
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText('Nivel $level', 14, FontWeight.w500, AppColors.actionSecondary),
            _buildText('Nivel ${level + 1} ($pointsToNext pts)', 14, FontWeight.w500, AppColors.actionSecondary),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSubContainers(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BorderedContainer(
            backgroundColor: AppColors.contrastPrimary,
            borderRadius: 24,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildRankContainer(context),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: BorderedContainer(
            backgroundColor: AppColors.contrastSecondary,
            borderRadius: 24,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildConfigContainer(context),
          ),
        ),
      ],
    );
  }

  Widget _buildRankContainer(BuildContext context) {
    final rank = _user?.scout?.rank ?? 'iron';

    final rankImage = switch (rank) {
      'iron'   => 'assets/images/ranks/iron.png',
      'bronze' => 'assets/images/ranks/bronze.png',
      'silver' => 'assets/images/ranks/silver.png',
      'gold'   => 'assets/images/ranks/gold.png',
      _        => 'assets/images/ranks/iron.png',
    };

    final rankLabel = switch (rank) {
      'iron'   => 'HIERRO',
      'bronze' => 'BRONCE',
      'silver' => 'PLATA',
      'gold'   => 'ORO',
      _        => 'HIERRO',
    };

    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildText('Tu rango de Scout', 16, FontWeight.w400, AppColors.bgPrimary),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    rankImage,
                    height: MediaQuery.sizeOf(context).height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                _buildText(rankLabel, 16, FontWeight.w700, AppColors.bgPrimary),
              ],
            ),
    );
  }

  Widget _buildConfigContainer(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tiendas con misiones',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.actionSecondary,
              height: 1,
            ),
          ),
          _buildText('3', 48, FontWeight.w800, AppColors.actionSecondary),
          ElevatedButton(
            onPressed: () => context.push('/scout/options'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.actionSecondary,
              foregroundColor: AppColors.bgPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              minimumSize: const Size(0, 40),
            ),
            child: _buildText('Configuración', 16, FontWeight.w600, AppColors.bgPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        _buildText('Misiones diarias', 14, FontWeight.w400, AppColors.textPrimary),
        const Divider(),
        StoreMissionsCollection(),
      ],
    );
  }

  Widget _buildText(String text, double customFontSize, FontWeight customFontWeight, Color customColor) {
    return Text(
      text,
      style: TextStyle(fontSize: customFontSize, fontWeight: customFontWeight, color: customColor),
      textAlign: TextAlign.start,
    );
  }
}