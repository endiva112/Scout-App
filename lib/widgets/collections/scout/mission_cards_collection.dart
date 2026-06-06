import 'package:flutter/material.dart';
import 'package:scout_app/models/scout/mission.dart';
import 'package:scout_app/widgets/cards/mission_card.dart';

class MissionCardsCollection extends StatelessWidget {
  final List<Mission> missions;
  final void Function(String missionId) onMissionCompleted;

  const MissionCardsCollection({
    super.key,
    required this.missions,
    required this.onMissionCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: missions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 20),
      itemBuilder: (_, index) {
        final mission = missions[index];
        return MissionCard(
          missionId: mission.id,
          productName: mission.productName,
          suggestedPrice: mission.suggestedPrice,
          unit: mission.unit,
          onCompleted: onMissionCompleted,
        );
      },
    );
  }
}