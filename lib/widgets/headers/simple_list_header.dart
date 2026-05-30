import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/header_icon.dart';
import 'package:scout_app/widgets/return_arrow.dart';


class SimpleListHeader extends StatelessWidget {
  const SimpleListHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 70,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReturnArrow(),
            HeaderIcon(icon: Icons.edit_note_rounded, route: '/lists/simple_lists/notes')
          ]
        )
      )
    );
  }
}
