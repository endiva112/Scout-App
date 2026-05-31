import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final double elevation;

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = AppColors.actionPrimary,
    this.textColor = AppColors.bgPrimary,
    this.borderColor = AppColors.actionPrimary,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 24,
    this.elevation = 2
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: elevation,
        padding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: textColor, height: 1),
      ),
    );
  }
}