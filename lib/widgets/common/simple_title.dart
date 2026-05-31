import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class SimpleTitle extends StatelessWidget {
  final String title;

  const SimpleTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600,color: AppColors.textPrimary),
      )
    );
  }
}
