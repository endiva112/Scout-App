import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/notes/note_body.dart';

class NoteContent extends StatelessWidget {
  final bool isListNote;

  const NoteContent({super.key, this.isListNote = false});

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
            if (!isListNote) ...[
              _buildTitle(),
              const SizedBox(height: 10),
            ],
            _buildLastModifiedText(),
            const SizedBox(height: 10),
            const Expanded(child: NoteBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return TextFormField(
      autofocus: false,
      maxLines: 3,
      minLines: 1,
      cursorColor: AppColors.textPrimary,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Título',
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
        filled: true,
        fillColor: AppColors.bgPrimary,
        isDense: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildLastModifiedText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        '25 Abril 2025',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}