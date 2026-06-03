import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/lists/switch_view_button.dart';
import 'package:go_router/go_router.dart';

class ShoppingFooter extends StatelessWidget {
  final String customRoute;

  const ShoppingFooter({
    super.key,
    required this.customRoute
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SwitchViewButton(icon: Icons.draw_rounded, onTap: () => context.go(customRoute))
        ]
      )
    );
  }
}