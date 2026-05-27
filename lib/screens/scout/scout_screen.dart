import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/default_tip_text.dart';

import 'package:scout_app/widgets/main_header.dart';
import 'package:scout_app/widgets/bottom_navbar.dart';
import 'package:scout_app/widgets/progress_bar.dart';

class ScoutScreen extends StatelessWidget {
  const ScoutScreen({super.key});

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

            // Componentes de esta página
            children: [
              MainHeader(),
              Expanded(child: _buildBody(context)),
              BottomNavBar(activeIndex: 3)
            ]
          )
        )
      )
    );
  }

  // Cuerpo de la vista
  Widget _buildBody(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildElevationContainer(_buildLevelCard(), AppColors.contrastSecondary)
            ),

            _buildSubContainers(),
            _buildMissionSection()
          ]
        )
      )
    );
  }

  // Elevación reusable
  Widget _buildElevationContainer(Widget customChild, Color customColor) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: customColor,
          borderRadius: BorderRadius.circular(24)
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: customChild,
      ),
    );
  }

  // Tarjeta de nivel
  Widget _buildLevelCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        _buildText('Tu nivel actual', 16, FontWeight.w400, AppColors.textTerciary),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText('Nivel 6', 24, FontWeight.w600, AppColors.actionSecondary),
            _buildText('380 puntos', 24, FontWeight.w600, AppColors.actionSecondary),
          ],
        ),
        const SizedBox(height: 5),

        ProgressBar(customBackgroundColor: AppColors.bgPrimary, customColor: AppColors.actionSecondary, progress: 0.7),
        const SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildText('Nivel 6', 14, FontWeight.w500, AppColors.actionSecondary),
            _buildText('Nivel 6', 14, FontWeight.w500, AppColors.actionSecondary),
          ],
        ),
      ],
    );
  }

  Widget _buildText(String text, double customFontSize, FontWeight customFontWeight, Color customColor) {
    return Text(
      text, style: TextStyle(fontSize: customFontSize, fontWeight: customFontWeight, color: customColor)
    );
  }

  // Suncontenedores de nivel
  Widget _buildSubContainers() {
    return Container(

    );
  }

  // Misiones
  Widget _buildMissionSection() {
    return Container(

    );
  }
}