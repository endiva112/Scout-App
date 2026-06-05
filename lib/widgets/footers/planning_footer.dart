import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
import 'package:scout_app/widgets/lists/switch_view_button.dart';
import 'package:go_router/go_router.dart';

class PlanningFooter extends StatelessWidget {
  final String listId;
  final String customRoute;

  const PlanningFooter({
    super.key,
    required this.listId,
    required this.customRoute,
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
          _buildOptimizeShopping(),
          SwitchViewButton(
            icon: Icons.shopping_cart_checkout_rounded,
            onTap: listId.isEmpty ? null : () => context.go('$customRoute/$listId'),
          ),
        ],
      ),
    );
  }

  Widget _buildOptimizeShopping() {
    return BorderedContainer(
      child: Row(children: []),//TODO agregar el boton de reagrupar las listas por precio mas barato
    );
  }
}