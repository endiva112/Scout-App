import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class HeaderIcon extends StatelessWidget {
  final IconData icon;
  final String? route;

  const HeaderIcon({
    super.key,
    required this.icon,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => route != null ? context.push(route!) : context.pop(),
        child: BorderedContainer(
          backgroundColor: AppColors.bgPrimary,
          elevation: 1.2,
          padding: const EdgeInsets.all(0),
          borderWidth: 0.1,
          borderColor: AppColors.bgPrimary,
          borderRadius: 5,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(icon, color: AppColors.textPrimary, size: 38),
          ),
        ),
      ),
    );
  }
}