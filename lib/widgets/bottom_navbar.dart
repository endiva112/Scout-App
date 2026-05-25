import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

import 'package:go_router/go_router.dart';


class BottomNavBar extends StatelessWidget {
  final int activeIndex;  //varaible para saber en que pantalla estoy

  const BottomNavBar({
    super.key,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(context, Icons.filter_list, 'Listas', index: 0, route: '/lists'),
          _buildNavItem(context, Icons.money_off_csred, 'Pagos', index: 1, route: '/payments'),
          _buildNavItem(context, Icons.star_rounded, 'Notas', index: 2, route: '/notes'),
          _buildNavItem(context, Icons.flag_rounded, 'Scout', index: 3, route: '/scout'),
        ]
      )
    );
  }

// Opciones del menú de navegación
Widget _buildNavItem(BuildContext context, IconData icon, String label, {required int index, required String route}) {
  // Color dinámico
  final bool isActive = index == activeIndex;
  final Color color = isActive ? AppColors.actionPrimary : AppColors.textSecondary;

  return Expanded(
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go(route),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,size: 32,color: color),
            Text(label,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: color))
          ]
        )
      )
    )
  );
}
}