import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class CustomSetting extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;

  const CustomSetting({
    super.key,
    this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.textPrimary)),
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