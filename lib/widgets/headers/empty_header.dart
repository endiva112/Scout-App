import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class EmptyHeader extends StatelessWidget {
  const EmptyHeader({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 70),
      color: AppColors.bgPrimary,
    );
  }
}
