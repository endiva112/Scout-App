import 'package:flutter/material.dart';
import 'package:scout_app/widgets/cards/market_mission_card.dart';
import 'package:scout_app/widgets/default_tip_text.dart';

class MissionsCollection extends StatelessWidget {
  const MissionsCollection({super.key});

  List<Map<String, String>> get _missions => [
    {
      'imageUrl': 'https://picsum.photos/seed/964/600',
      'marketName': 'Carrefour',
      'productCount': '4 productos',
      'points': '80 puntos',
      'marketId': '1'
    },
    {
      'imageUrl': 'https://picsum.photos/seed/964/600',
      'marketName': 'Mercadona',
      'productCount': '3 productos',
      'points': '60 puntos',
      'marketId': '2'
    },
  ];

  List<Widget> get _allItems => [
    ..._missions.map(
      (mission) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MarketMissionCard(
          imageUrl: mission['imageUrl']!,
          marketName: mission['marketName']!,
          productCount: mission['productCount']!,
          points: mission['points']!,
          marketId: mission['marketId']!,
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
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) => _allItems[index],
    );
  }
}