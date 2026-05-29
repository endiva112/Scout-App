import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/store_mission_card.dart';
import 'package:scout_app/widgets/default_tip_text.dart';

class StoreMissionsCollection extends StatelessWidget {
  const StoreMissionsCollection({super.key});

  List<Map<String, String>> get _missions => [
    {
      'imageUrl': 'assets/images/carrefour.png',
      'storeName': 'Carrefour',
      'productCount': '4 productos',
      'points': '80 puntos',
      'storeId': '1'
    },
    {
      'imageUrl': 'assets/images/lidl.png',
      'storeName': 'Lidl',
      'productCount': '3 productos',
      'points': '60 puntos',
      'storeId': '2'
    },
  ];

  List<Widget> get _allItems => [
    ..._missions.map(
      (mission) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: StoreMissionCard(
          imageUrl: mission['imageUrl']!,
          storeName: mission['storeName']!,
          productCount: mission['productCount']!,
          points: mission['points']!,
          storeId: mission['storeId']!,
        ),
      ),
    ),
    const DefaultTipText(tip: 'SIN MISIONES PARA ESTA REGIÓN'),
    const DefaultTipText(tip: 'ESTABLECE UNA LOCALIZACIÓN Y CONTRIBUYE A TU COMUNIDAD'),
    const DefaultTipText(tip: 'INICIA SESIÓN Y AYUDANOS A OTROS SCOUTS A MANTENER LOS PRECIOS AL DÍA'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: _allItems.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (_, index) => _allItems[index],
    );
  }
}