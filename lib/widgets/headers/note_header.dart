import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';
import 'package:scout_app/widgets/common/return_arrow.dart';
import 'package:scout_app/constants/note_icons.dart';

class NoteHeader extends StatelessWidget {
  final bool isListNote;
  final NoteIcon selectedIcon;
  final ValueChanged<NoteIcon> onIconChanged;
  final VoidCallback onBack;

  const NoteHeader({
    super.key,
    this.isListNote = false,
    required this.selectedIcon,
    required this.onIconChanged,
    required this.onBack,
  });

  void _openIconSelector(BuildContext context) {
    CustomBottomSheet.show(
      context,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecciona un icono',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: noteIconData.entries.map((entry) {
              final bool isSelected = entry.key == selectedIcon;
              return GestureDetector(
                onTap: () {
                  onIconChanged(entry.key);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.bgSecondary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? AppColors.actionPrimary : AppColors.borderAccent,
                      width: 2,
                    ),
                  ),
                  child: Icon(entry.value, color: AppColors.textPrimary, size: 32),
                )
              );
            }).toList()
          )
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      decoration: const BoxDecoration(color: AppColors.bgPrimary),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ReturnArrow(onTap: onBack),
            if (!isListNote) _buildIconSelector(context),
          ]
        )
      )
    );
  }

  Widget _buildIconSelector(BuildContext context) {
    return IconButton(
      onPressed: () => _openIconSelector(context),
      icon: Icon(noteIconData[selectedIcon], color: AppColors.textPrimary, size: 32),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.bgSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      )
    );
  }
}