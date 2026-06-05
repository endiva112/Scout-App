import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';
import 'package:scout_app/models/shopping_list.dart';
import 'package:go_router/go_router.dart';

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
  final String listId;

  const ListCard({
    super.key,
    required this.type,
    required this.title,
    required this.items,
    required this.extraInfo,
    required this.listId,
  });

  String get _customRoute {
    switch (type) {
      case ListType.simple:
        return '/lists/simple_list/shopping/';//$listId
      case ListType.collaborative:
        return '/lists/collaborative_list/shopping/';
      case ListType.recurring:
        return '/lists/recurring_list/planning/';
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _cardStyles[type]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BorderedContainer(
        backgroundColor: AppColors.bgPrimary,
        borderColor: style.borderColor,
        borderWidth: 2,
        child: InkWell(
          onTap: () => context.push(_customRoute),
          borderRadius: BorderRadius.circular(12),
          child: _buildCardContent(context, style),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, _ListCardStyle style) {
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
              ]
            )
          )
        ),
        _buildVerticalOptionsButton(context)
      ]
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1),
    );
  }

  Widget _buildInfoText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
    );
  }

  Widget _buildVerticalOptionsButton(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: AppColors.textPrimary, size: 32),
      onSelected: (value) {
        switch (value) {
          case 'share':
            // acción compartir TODO
            break;
          case 'edit':
            context.push('/lists/simple_lists/planning');
            break;
          case 'delete':
            // acción eliminar TODO
            break;
        }
      },
      itemBuilder: (context) => [

        const PopupMenuItem(
          value: 'share',
          child: ListTile(
            dense: true,
            title: Text('Compartir lista'),
            trailing: Icon(Icons.share_rounded),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          )
        ),

        const PopupMenuItem(
          value: 'edit',
          child: ListTile(
            dense: true,
            title: Text('Editar lista'),
            trailing: Icon(Icons.edit_outlined),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          )
        ),

        const PopupMenuItem(
          height: 40,
          value: 'delete',
          child: ListTile(
            dense: true,
            title: Text('Eliminar lista', style: TextStyle(color: AppColors.negative)),
            trailing: Icon(Icons.delete_outline, color: AppColors.negative),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          )
        )

      ],
    );
  }
}