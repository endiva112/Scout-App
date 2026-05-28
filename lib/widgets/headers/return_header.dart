import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

import 'package:go_router/go_router.dart';

class ReturnHeader extends StatelessWidget {
  const ReturnHeader({super.key,});

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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.textPrimary,
                  size: 40,
                )
              )
            )
          ]
        )
      )
    );
  }
}
