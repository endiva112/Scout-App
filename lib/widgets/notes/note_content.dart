import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/last_modified_text.dart';
import 'package:scout_app/widgets/common/title_text_field.dart';
import 'package:scout_app/widgets/notes/note_body.dart';

class NoteContent extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController contentController;
  final DateTime updatedAt;
  final VoidCallback onChanged;

  const NoteContent({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.updatedAt,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.bgSecondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            TitleTextField(titleController: titleController, onChanged: onChanged),
            const SizedBox(height: 10),
            LastModifiedText(updatedAt: updatedAt),
            const SizedBox(height: 10),
            Expanded(
              child: NoteBody(
                controller: contentController,
                onChanged: onChanged,
              )
            )
          ]
        )
      )
    );
  }
}