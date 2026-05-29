import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/mission_card.dart';

class MissionsCollection extends StatelessWidget {
  const MissionsCollection({super.key});

  // TODO: reemplazar por llamada a Firestore
  List<Map<String, String>> get _missions => [
    {
      'productName': 'Huevos camperos, 200mg super naturales',
      'price': '8,23',
      'unit': 'Kg',
    },
    {
      'productName': 'Lorem ipsum dolor si amet Lorem ipsum dolor si amet Lorem ipsum dolor si amet',
      'price': '8,23',
      'unit': 'paquete',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 150),
      itemCount: _missions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 20),
      itemBuilder: (_, index) {
        final mission = _missions[index];
        return MissionCard(
          productName: mission['productName']!,
          price: mission['price']!,
          unit: mission['unit']!,
        );
      },
    );
  }
}