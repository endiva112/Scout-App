import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/add_division_button.dart';
import 'package:scout_app/widgets/collections/lists/collaborative_divisions_collection.dart';
import 'package:scout_app/widgets/common/title_text_field.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';

class CollaborativePlanningBody extends StatelessWidget {
  final String listId;
  final TextEditingController titleController;
  final DateTime updatedAt;
  final VoidCallback onChanged;

  const CollaborativePlanningBody({
    super.key,
    required this.listId,
    required this.titleController,
    required this.updatedAt,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            TitleTextField(
              titleController: titleController,
              onChanged: onChanged,
            ),
            const SizedBox(height: 10),
            LastModifiedText(updatedAt: updatedAt),
            const SizedBox(height: 10),
            CollaborativeDivisionsCollection(listId: listId),
            AddDivisionButton(listId: listId)
          ],
        ),
      ),
    );
  }
}