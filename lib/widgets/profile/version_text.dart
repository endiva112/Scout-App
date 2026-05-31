import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class VersionText extends StatelessWidget {
  const VersionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('1.0.0', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: AppColors.textPrimary), textAlign: TextAlign.center);
  }
}