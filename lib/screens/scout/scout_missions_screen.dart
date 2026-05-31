import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/missions_collection.dart';
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
            Expanded(child: MissionsCollection())
          ]
        )
      )
    );
  }
}