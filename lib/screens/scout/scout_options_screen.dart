import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/stores_collection.dart';
import 'package:scout_app/widgets/footers/bottom_empty.dart';
import 'package:scout_app/widgets/headers/return_header.dart';
import 'package:scout_app/widgets/scout/location_container.dart';
import 'package:scout_app/widgets/tool_tip.dart';

class ScoutOptionsScreen extends StatelessWidget {
  const ScoutOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.bgPrimary,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ReturnHeader(),
              Expanded(child: _buildBody()),
              BottomEmpty()
            ]
          )
        )
      )
    );
  }

  Widget _buildBody() {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.bgPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(20),
          child: _buildMainContent()
        )
      )
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Título + tooltip
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tiendas por tu zona',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              )
            ),
            ToolTip(message: '¡Ayuda a la comunidad!, marca aquellas tiendas sobre las cuáles quieras recibir misiones'),
          ]
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.bgSecondary,
            ),
            padding: const EdgeInsets.all(10),
            child: StoresCollection(),
          ),
        ),
        const SizedBox(height: 24),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.bgSecondary,
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                '== UBICACIÓN ACTUAL ==',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 10),
              LocationContainer(),
            ],
          ),
        ),
      ],
    );
  }
}