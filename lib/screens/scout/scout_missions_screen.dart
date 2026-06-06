import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/scout/mission.dart';
import 'package:scout_app/models/scout/store.dart';
import 'package:scout_app/repositories/scout/mission_repository.dart';
import 'package:scout_app/repositories/scout/store_repository.dart';
import 'package:scout_app/repositories/user_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/scout/mission_cards_collection.dart';
import 'package:scout_app/widgets/headers/return_header.dart';

class ScoutMissionsScreen extends StatefulWidget {
  final String storeId;

  const ScoutMissionsScreen({super.key, required this.storeId});

  @override
  State<ScoutMissionsScreen> createState() => _ScoutMissionsScreenState();
}

class _ScoutMissionsScreenState extends State<ScoutMissionsScreen> {
  final _missionRepository = MissionRepository();
  final _storeRepository = StoreRepository();
  final _userRepository = UserRepository();

  Store? _store;
  List<Mission> _missions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final user = await _userRepository.getUser(uid);
    final store = await _storeRepository.getStore(widget.storeId);

    if (user?.scout?.location == null || !mounted) {
      setState(() => _loading = false);
      return;
    }

    final allMissions = await _missionRepository.getMissionsByStore(
      widget.storeId,
      user!.scout!.location,
    );

    final pending = <Mission>[];
    for (final mission in allMissions) {
      final responded = await _missionRepository.hasResponded(mission.id);
      if (!responded) pending.add(mission);
    }

    if (!mounted) return;
    setState(() {
      _store = store;
      _missions = pending;
      _loading = false;
    });
  }

  void _onMissionCompleted(String missionId) {
    setState(() => _missions.removeWhere((m) => m.id == missionId));
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
            ReturnHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());

    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _store?.name ?? '',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Expanded(
              child: _missions.isEmpty
                  ? const Center(
                      child: Text(
                        'No hay misiones pendientes para esta tienda',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    )
                  : MissionCardsCollection(
                      missions: _missions,
                      onMissionCompleted: _onMissionCompleted,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}