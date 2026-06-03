import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/constants/note_icons.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final String date;
  final NoteIcon icon;
  final String noteId;
  final VoidCallback onDelete;

  const NoteCard({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
    required this.noteId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BorderedContainer(
        backgroundColor: AppColors.bgTerciary,
        borderColor: AppColors.borderAccent,
        borderWidth: 2,
        child: InkWell(
          onTap: () => context.go('/note/$noteId'),
          borderRadius: BorderRadius.circular(12),
          child: _buildCardContent(context),
        ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            noteIconData[icon],
            color: Theme.of(context).colorScheme.onSurface,
            size: 60,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const SizedBox(height: 5),
                _buildDate(context),
              ],
            ),
          ),
        ),
        _buildOptionsButton(),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1,
      ),
    );
  }

  Widget _buildDate(BuildContext context) {
    return Text(
      date,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildOptionsButton() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: AppColors.textPrimary, size: 32),
      onSelected: (value) {
        switch (value) {
          case 'share':
            // compartir
            break;
          case 'delete':
            onDelete();
            break;
        }
      },
      itemBuilder: (context) => [

        const PopupMenuItem(
          value: 'share',
          child: ListTile(
            dense: true,
            title: Text('Compartir'),
            trailing: Icon(Icons.share_rounded),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),

        const PopupMenuItem(
          value: 'delete',
          child: ListTile(
            dense: true,
            title: Text('Eliminar', style: TextStyle(color: AppColors.negative)),
            trailing: Icon(Icons.delete_outline, color: AppColors.negative),
            contentPadding: EdgeInsets.symmetric(horizontal: 5),
          ),
        ),

      ],
    );
  }
}