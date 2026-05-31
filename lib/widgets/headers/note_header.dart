import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/custom_bottom_sheet.dart';
import 'package:scout_app/widgets/return_arrow.dart';
import 'package:scout_app/constants/note_icons.dart';

class NoteHeader extends StatefulWidget {
  final bool isListNote;
  
  const NoteHeader({super.key, this.isListNote = false});

  @override
  State<NoteHeader> createState() => _NoteHeaderState();
}

class _NoteHeaderState extends State<NoteHeader> {

  NoteIcon _selectedIcon = defaultNoteIcon;

  void _openIconSelector() {
    CustomBottomSheet.show(
      context,
      content: StatefulBuilder(
        builder: (context, setModalState) => Column(
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
                final bool isSelected = entry.key == _selectedIcon;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIcon = entry.key);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.bgPrimary: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? AppColors.bgPrimary : AppColors.bgPrimary,
                        width: 2,
                      ),
                    ),
                    child: Icon(entry.value, color: isSelected ? AppColors.textPrimary : AppColors.bgPrimary, size: 32),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
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
            ReturnArrow(),
            if (!widget.isListNote) _buildIconSelector(), // Si es una nota de lista quito el icono
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    return IconButton(
      onPressed: _openIconSelector,
      icon: Icon(noteIconData[_selectedIcon], color: AppColors.textPrimary, size: 32),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.bgSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}