import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:scout_app/widgets/custom_bottom_sheet.dart';

class NoteHeader extends StatefulWidget {
  const NoteHeader({super.key});

  @override
  State<NoteHeader> createState() => _NoteHeaderState();
}

class _NoteHeaderState extends State<NoteHeader> {

  // Icono seleccionado actualmente
  IconData _selectedIcon = Icons.cake_rounded;

  // Iconos disponibles para seleccionar
  static const List<IconData> _availableIcons = [
    Icons.cake_rounded,
    Icons.shopping_cart_outlined,
    Icons.home_outlined,
    Icons.star_outline_rounded,
    Icons.favorite_outline_rounded,
    Icons.bolt_rounded,
    Icons.beach_access_outlined,
    Icons.sports_soccer_rounded,
    Icons.music_note_outlined,
    Icons.pets_rounded,
  ];

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
              children: _availableIcons.map((icon) {
                final bool isSelected = icon == _selectedIcon;
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedIcon = icon);
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
                    child: Icon(icon, color: isSelected ? AppColors.textPrimary : AppColors.bgPrimary, size: 32),
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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 40),
              ),
            ),
            _buildIconSelector(),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSelector() {
    return IconButton(
      onPressed: _openIconSelector,
      icon: Icon(_selectedIcon, color: AppColors.textPrimary, size: 32),
      style: IconButton.styleFrom(
        backgroundColor: AppColors.bgSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}