import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ReturnArrow extends StatelessWidget {
  final String customRoute;
  final Future<void> Function()? onBeforeReturn;

  const ReturnArrow({
    super.key,
    required this.customRoute,
    this.onBeforeReturn,
  });

  Future<void> _handleTap(BuildContext context) async {
    await onBeforeReturn?.call();

    if (context.mounted) {
      context.go(customRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _handleTap(context),
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 40,
        ),
      ),
    );
  }
}