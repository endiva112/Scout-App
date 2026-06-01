import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/models/mission.dart';
import 'package:scout_app/models/store.dart';
import 'package:scout_app/repositories/mission_repository.dart';
import 'package:scout_app/repositories/store_repository.dart';
import 'package:scout_app/repositories/user_repository.dart';
import 'package:scout_app/widgets/cards/store_mission_card.dart';
import 'package:scout_app/widgets/common/default_tip_text.dart';

class StoreMissionsCollection extends StatefulWidget {
  const StoreMissionsCollection({super.key});

  @override
  State<StoreMissionsCollection> createState() => _StoreMissionsCollectionState();
}

class _StoreMissionsCollectionState extends State<StoreMissionsCollection> {
  final _missionRepository = MissionRepository();
  final _storeRepository = StoreRepository();
  final _userRepository = UserRepository();

  AppUser? _user;
  Map<Store, List<Mission>> _missionsByStore = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final user = await _userRepository.getUser(uid);
    if (!mounted) return;
    setState(() => _user = user);
    if (user?.scout?.location != null) {
      _listenMissions(user!.scout!.location);
    } else {
      setState(() => _loading = false);
    }
  }

  void _listenMissions(ScoutLocation location) {
    _missionRepository.getMissions(location).listen((missions) async {
      // Agrupar por storeId
      final grouped = <String, List<Mission>>{};
      for (final mission in missions) {
        grouped.putIfAbsent(mission.storeId, () => []).add(mission);
      }

      // Cargar datos de cada tienda
      final result = <Store, List<Mission>>{};
      for (final entry in grouped.entries) {
        final store = await _storeRepository.getStore(entry.key);
        if (store != null) result[store] = entry.value;
      }

      if (!mounted) return;
      setState(() {
        _missionsByStore = result;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final isAnonymous = _user?.isAnonymous ?? true;
    final hasLocation = _user?.scout?.location != null &&
        _user!.scout!.location.city.isNotEmpty;

    // Tips según el estado del usuario
    final tips = <Widget>[];
    if (!hasLocation) {
      tips.add(const DefaultTipText(
        tip: 'ESTABLECE UNA LOCALIZACIÓN Y CONTRIBUYE A TU COMUNIDAD',
      ));
    }
    if (isAnonymous) {
      tips.add(const DefaultTipText(
        tip: 'INICIA SESIÓN Y AYUDANOS A OTROS SCOUTS A MANTENER LOS PRECIOS AL DÍA',
      ));
    }
    if (hasLocation && _missionsByStore.isEmpty) {
      tips.add(const DefaultTipText(tip: 'SIN MISIONES PARA ESTA REGIÓN'));
    }

    final items = <Widget>[
      ..._missionsByStore.entries.map((entry) {
        final store = entry.key;
        final missions = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: StoreMissionCard(
            imageUrl: store.logoUrl ?? '',
            storeName: store.name,
            productCount: '${missions.length} productos',
            points: '${missions.length * 20} puntos',
            storeId: store.id,
          ),
        );
      }),
      ...tips,
    ];

    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) => items[index],
    );
  }
}