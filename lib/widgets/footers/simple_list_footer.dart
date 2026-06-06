import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/lists/switch_view_button.dart';
import 'package:go_router/go_router.dart';

class SimpleListFooter extends StatelessWidget {
  final String listId;
  final String mode;

  const SimpleListFooter({
    super.key,
    required this.listId,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return mode == 'shopping' ? _buildShopping(context) : _buildPlanning(context);
  }

  Widget _buildPlanning(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SwitchViewButton(
            icon: Icons.shopping_cart_checkout_rounded,
            onTap: listId.isEmpty
                ? null
                : () => context.go('/lists/simple_list/$listId?mode=shopping'),
          ),
        ],
      ),
    );
  }

  Widget _buildShopping(BuildContext context) {
    return Container(
      height: 70,
      color: AppColors.bgPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SwitchViewButton(
            icon: Icons.draw_rounded,
            onTap: () => context.go('/lists/simple_list/$listId?mode=planning'),
          ),
        ],
      ),
    );
  }
}