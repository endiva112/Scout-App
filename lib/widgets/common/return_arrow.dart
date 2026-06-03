import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ReturnArrow extends StatelessWidget {
  final String customRoute;

  const ReturnArrow({super.key, required this.customRoute});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(customRoute),
        child: Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 40,
        ),
      ),
    );
  }
}