import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/header_icon.dart';
import 'package:scout_app/widgets/common/return_arrow.dart';

class SimpleListHeader extends StatelessWidget {
  final Future<void> Function() onBeforeReturn;

  const SimpleListHeader({
    super.key,
    required this.onBeforeReturn,
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
            ReturnArrow(
              customRoute: '/',
              onBeforeReturn: onBeforeReturn,
            ),
            HeaderIcon(
              icon: Icons.edit_note_rounded,
              route: '/lists/simple_list/annotations',
            ),
          ],
        ),
      ),
    );
  }
}