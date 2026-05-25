import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

enum ListType {
  simple,
  collaborative,
  recurring,
}

// Configuración visual por tipo
class _ListCardStyle {
  final Color borderColor;
  final IconData icon;
  final Color iconColor;

  const _ListCardStyle({
    required this.borderColor,
    required this.icon,
    required this.iconColor,
  });
}

const _cardStyles = {
  ListType.simple: _ListCardStyle(
    borderColor: AppColors.listTypeSimple,
    icon: Icons.shopping_cart_outlined,
    iconColor: AppColors.listTypeSimple,
  ),
  ListType.collaborative: _ListCardStyle(
    borderColor: AppColors.listTypeCollaborative,
    icon: Icons.groups_2_rounded,
    iconColor: AppColors.listTypeCollaborative,
  ),
  ListType.recurring: _ListCardStyle(
    borderColor: AppColors.listTypeRecurring,
    icon: Icons.restart_alt_rounded,
    iconColor: AppColors.listTypeRecurring,
  ),
};

class ListCard extends StatelessWidget {
  final ListType type;
  final String title;
  final int items;
  final String extraInfo;

  const ListCard({
    super.key,
    required this.type,
    required this.title,
    required this.items,
    required this.extraInfo,
  });

  @override
  Widget build(BuildContext context) {
    final style = _cardStyles[type]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: style.borderColor, width: 2),
          ),
          child: _buildListInformation(context, style),
        ),
      ),
    );
  }

  Widget _buildListInformation(BuildContext context, _ListCardStyle style) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(style.icon, color: style.iconColor, size: 80),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTitle(),
                _buildInfoText('- $items items'),
                _buildInfoText('- $extraInfo'),
              ],
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: IconButton(
            onPressed: () => context.go('/profile'),
            icon: Icon(Icons.more_vert, color: AppColors.textPrimary, size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
    );
  }
}