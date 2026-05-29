import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/cards/mission_card.dart';
import 'package:scout_app/widgets/headers/return_header.dart';

class ScoutMissionsScreen extends StatelessWidget {
  const ScoutMissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          // Componentes de esta página
          children: [
            ReturnHeader(),
            Expanded(child: _buildBody())
          ]
        )
      )
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Lidl', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: AppColors.textPrimary,), textAlign: TextAlign.left,),
            Expanded(child: _buildMissionsCollection())
          ]
        )
      )
    );
  }

  Widget _buildMissionsCollection() {
    final widgets = [
      MissionCard(
        productName: 'Huevos camperos, 200mg super naturales',
        price: '8,23',
        unit: 'Kg',
      ),
      MissionCard(
        productName: 'Lorem ipsum dolor si amet Lorem ipsum dolor si amet Lorem ipsum dolor si amet Lorem ipsum dolor si amet Lorem ipsum dolor si amet',
        price: '8,23',
        unit: 'paquete',
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
      itemCount: widgets.length,

      itemBuilder: (context, index) {
        return widgets[index];
      },

      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
    );
  }
}