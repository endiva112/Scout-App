import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/header_icon.dart';
import 'package:scout_app/widgets/common/return_arrow.dart';


class ComplexListHeader extends StatelessWidget {
  const ComplexListHeader({super.key,});

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
            ReturnArrow(customRoute: '/'),
            Row(
              children: [
                HeaderIcon(icon: Icons.attach_money_rounded, route: '/lists/collaborative_list/expenses'),
                SizedBox(width: 10),
                HeaderIcon(icon: Icons.edit_note_rounded, route: '/lists/collaborative_list/notes'),
                SizedBox(width: 10),
                HeaderIcon(icon: Icons.group_rounded, route: '/lists/collaborative_list/list_details')
              ]
            )
          ]
        )
      )
    );
  }
}
