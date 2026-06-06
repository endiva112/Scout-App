import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/add_group_button.dart';
import 'package:scout_app/widgets/common/title_text_field.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';

class SimplePlanningBody extends StatelessWidget {
  final String listId;
  final TextEditingController titleController;
  final DateTime updatedAt;
  final VoidCallback onChanged;

  const SimplePlanningBody({
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
            // TODO: divisiones e items
            AddGroupButton(listId: listId)
          ],
        ),
      ),
    );
  }
}