import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/bordered_container.dart';

enum NoteIcon {
  work,
  home,
  school,
  health,
  finance,
  travel,
  food,
  sport,
  music,
  personal,
  birthday,
}

const _noteIcons = {
  NoteIcon.work:     Icons.work_rounded,
  NoteIcon.home:     Icons.home_rounded,
  NoteIcon.school:   Icons.school_rounded,
  NoteIcon.health:   Icons.favorite_rounded,
  NoteIcon.finance:  Icons.account_balance_rounded,
  NoteIcon.travel:   Icons.flight_rounded,
  NoteIcon.food:     Icons.restaurant_rounded,
  NoteIcon.sport:    Icons.sports_soccer_rounded,
  NoteIcon.music:    Icons.music_note_rounded,
  NoteIcon.personal: Icons.person_rounded,
  NoteIcon.birthday: Icons.cake_rounded
};

class NoteCard extends StatelessWidget {
  final String title;
  final String date;
  final NoteIcon icon;
  final String noteId;

  const NoteCard({
    super.key,
    required this.title,
    required this.date,
    required this.icon,
    required this.noteId
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
          onTap: () => context.push('/note'),//$noteId
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
            _noteIcons[icon],
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
            // TODO: compartir
            break;
          case 'delete':
            // TODO: eliminar
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