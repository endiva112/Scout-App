import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class CustomProfileSetting extends StatelessWidget {
  final VoidCallback? onTap;
  final String desciption;
  final String currentValue;

  const CustomProfileSetting({
    super.key,
    this.onTap,
    required this.desciption,
    required this.currentValue
  });

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(desciption, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: AppColors.textPrimary)),
              Text(currentValue, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textPrimary)),
            ]
          ),
          if (onTap != null)
            const Icon(Icons.chevron_right_rounded, color: AppColors.textTerciary),
        ]
      )
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, child: child);
    }

    return child;
  }
}