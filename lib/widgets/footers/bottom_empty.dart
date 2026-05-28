import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';


class BottomEmpty extends StatelessWidget {

  const BottomEmpty({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.bgPrimary,
    );
  }
}