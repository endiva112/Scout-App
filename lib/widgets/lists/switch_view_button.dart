import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class SwitchViewButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const SwitchViewButton({
    super.key,
    required this.icon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: BorderedContainer(
          backgroundColor: AppColors.bgSecondary,
          borderRadius: 5,
          padding: const EdgeInsets.all(5),
          child: Icon(
            icon,
            color: AppColors.textPrimary,
            size: 40,
          )
        )
      )
    );
  }
}