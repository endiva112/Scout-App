import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class DefaultTipText extends StatelessWidget {
  final String tip;

  const DefaultTipText({
    super.key,
    required this.tip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        tip,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColors.textTerciary)
      ),
    );
  }
}