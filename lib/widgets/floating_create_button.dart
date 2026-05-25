import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class FloatingCreateButton extends StatelessWidget {

  const FloatingCreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.actionPrimary,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 48),
        )
      )
    );
  }
}