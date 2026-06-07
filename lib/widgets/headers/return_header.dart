import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class ReturnHeader extends StatelessWidget {
  final Future<void> Function()? onBeforeReturn;

  const ReturnHeader({
    super.key,
    this.onBeforeReturn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      decoration: const BoxDecoration(color: AppColors.bgPrimary),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  await onBeforeReturn?.call();
                  if (context.mounted) context.pop();
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}