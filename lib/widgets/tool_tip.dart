import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class ToolTip extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color iconColor;
  final double size;

  const ToolTip({
    super.key,
    required this.message,
    this.backgroundColor = AppColors.actionPrimary,
    this.iconColor = AppColors.bgPrimary,
    this.size = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      triggerMode: TooltipTriggerMode.tap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(2),
        child: Icon(
          Icons.question_mark_rounded,
          color: iconColor,
          size: size,
        ),
      ),
    );
  }
}