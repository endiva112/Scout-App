import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/header_icon.dart';
import 'package:scout_app/widgets/common/return_arrow.dart';

class CollaborativeListHeader extends StatelessWidget {
  final Future<void> Function() onBeforeReturn;
  final String listId;

  const CollaborativeListHeader({
    super.key,
    required this.onBeforeReturn,
    required this.listId,
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
            Row(
              children: [
                /*
                HeaderIcon(
                  icon: Icons.attach_money_rounded,
                  route: '/payments/collaborative_list/expenses'
                ),
                */
                SizedBox(width: 10),
                HeaderIcon(
                  icon: Icons.edit_note_rounded,
                  route: '/lists/collaborative_list/$listId/annotation',
                ),
                SizedBox(width: 10),
                HeaderIcon(
                  icon: Icons.group_rounded,
                  route: '/lists/collaborative_list/$listId/details'
                )
              ]
            )
          ]
        )
      )
    );
  }
}