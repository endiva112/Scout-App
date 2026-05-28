import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/bordered_container.dart';
import 'package:scout_app/widgets/collections/missions_collection.dart';

import 'package:scout_app/widgets/headers/main_header.dart';
import 'package:scout_app/widgets/footers/bottom_navbar.dart';
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
              child: BorderedContainer(
                backgroundColor: AppColors.contrastSecondary,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: _buildLevelCard()
              )
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: _buildSubContainers(context)
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: _buildMissionSection(context),
            )
          ]
        )
      )
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
          ]
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
        const SizedBox(height: 10),
      ],
    );
  }

  // Suncontenedores de nivel
  Widget _buildSubContainers(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BorderedContainer(
            backgroundColor: AppColors.contrastPrimary,
            borderRadius: 24,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
            child: _buildRankContainer(context),
          )
        ),

        const SizedBox(width: 10),

        Expanded(
          child: BorderedContainer(
            backgroundColor: AppColors.contrastSecondary,
            borderRadius: 24,
            elevation: 10,
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10,),
            child: _buildConfigContainer(context),
          )
        )
      ]
    );
  }

  Widget _buildRankContainer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText('Tu rango de Scout', 16, FontWeight.w400, AppColors.bgPrimary),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/seed/758/600',
              height: MediaQuery.sizeOf(context).height * 0.1,
              fit: BoxFit.cover
            )
          ),
          _buildText('ORO', 16, FontWeight.w700, AppColors.bgPrimary)
        ]
      )
    );
  }

  Widget _buildConfigContainer(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Tiendas con misiones',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.actionSecondary, height: 1)
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
          )
        ]
      )
    );
  }

  // Misiones
  Widget _buildMissionSection(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(),
        _buildText('Misiones diarias', 14, FontWeight.w400, AppColors.textPrimary),
        Divider(),
        MissionsCollection()
      ]
    );
  }

  Widget _buildText(String text, double customFontSize, FontWeight customFontWeight, Color customColor) {
    return Text(
      text, style: TextStyle(fontSize: customFontSize, fontWeight: customFontWeight, color: customColor), textAlign: TextAlign.start,
    );
  }
}