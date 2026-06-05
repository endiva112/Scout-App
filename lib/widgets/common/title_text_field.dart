import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class TitleTextField extends StatelessWidget {
  final TextEditingController titleController;
  final VoidCallback onChanged;

  const TitleTextField({
    super.key,
    required this.titleController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, ) {
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
}
