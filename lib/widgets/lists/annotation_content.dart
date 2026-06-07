import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/notes/note_body.dart';

class AnnotationContent extends StatelessWidget {
  final TextEditingController contentController;
  final VoidCallback onChanged;

  const AnnotationContent({
    super.key,
    required this.contentController,
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
            Expanded(
              child: NoteBody(
                controller: contentController,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}