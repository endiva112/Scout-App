import 'package:flutter/material.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/collections/lists/items_collection.dart';
import 'package:scout_app/widgets/common/bordered_container.dart';

class DivisionCard extends StatelessWidget {
  final String listId;
  final Division division;
  final VoidCallback onDelete;

  const DivisionCard({
    super.key,
    required this.listId,
    required this.division,
    required this.onDelete,
  });

  void _showMenu(BuildContext context, Offset position) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'delete',
          child: ListTile(
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 5),
            title: const Text(
              'Eliminar tienda',
              style: TextStyle(color: AppColors.negative),
            ),
            trailing: const Icon(Icons.delete_outline, color: AppColors.negative),
          ),
        ),
      ],
    ).then((value) {
      if (value == 'delete') onDelete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) => _showMenu(context, details.globalPosition),
      child: BorderedContainer(
        borderColor: AppColors.borderAccent,
        borderWidth: 1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                division.name.isEmpty ? 'Sin tienda asignada' : division.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              ItemsCollection(
                listId: listId,
                divisionId: division.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}