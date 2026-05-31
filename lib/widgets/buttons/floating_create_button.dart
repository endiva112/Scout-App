import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class FloatingCreateButton extends StatelessWidget {
  final VoidCallback onTap;

  const FloatingCreateButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: AppColors.actionPrimary,
          borderRadius: BorderRadius.circular(24),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(24),
            splashColor: AppColors.focusPrimary,
            highlightColor: AppColors.focusPrimary,
            child: SizedBox(
              width: 80,
              height: 80,
              child: const Icon(Icons.add, color: AppColors.bgPrimary, size: 48),
            )
          )
        )
      )
    );
  }
}