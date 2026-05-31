import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/notes/note_body.dart';

class NoteContent extends StatelessWidget {
  final bool isListNote;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final DateTime updatedAt;
  final VoidCallback onChanged;

  const NoteContent({
    super.key,
    this.isListNote = false,
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
            if (!isListNote) ...[
              _buildTitle(),
              const SizedBox(height: 10),
            ],
            _buildLastModifiedText(),
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

  Widget _buildTitle() {
    return TextFormField(
      controller: titleController,
      onChanged: (_) => onChanged(),
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
        _formatDate(updatedAt),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.italic,
          color: AppColors.textSecondary,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}