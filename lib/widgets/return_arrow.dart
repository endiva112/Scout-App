import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ReturnArrow extends StatelessWidget {
  final VoidCallback? onTap;

  const ReturnArrow({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap ?? () => context.pop(),
        child: Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 40,
        ),
      ),
    );
  }
}