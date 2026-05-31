import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final Color customBackgroundColor;
  final Color customColor;
  final double progress; // 1 = 100%

  const ProgressBar({
    super.key,
    required this.customBackgroundColor,
    required this.customColor,
    required this.progress
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 10,
        backgroundColor: customBackgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(customColor),
      ),
    );
  }
}
