import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/repositories/lists/shopping_list_repository.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';

class AddDivisionSheet extends StatefulWidget {
  final String listId;

  const AddDivisionSheet({
    super.key,
    required this.listId,
  });

  static Future<void> show(BuildContext context, {required String listId}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => AddDivisionSheet(listId: listId),
    );
  }

  @override
  State<AddDivisionSheet> createState() => _AddDivisionSheetState();
}

class _AddDivisionSheetState extends State<AddDivisionSheet> {
  final _controller = TextEditingController();
  final _repository = ShoppingListRepository();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;

    await _repository.saveDivision(
      widget.listId,
      Division(id: '', name: name),
    );
    await _repository.incrementDivisionCount(widget.listId);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Agregar supermercado',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.bgPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            autofocus: true,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Nombre de la tienda o supermercado',
              hintStyle: const TextStyle(color: AppColors.textSecondary),
              filled: true,
              fillColor: AppColors.bgPrimary,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomButton(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.bgPrimary,
                  borderColor: AppColors.contrastPrimary,
                  backgroundColor: AppColors.contrastPrimary,
                  elevation: 5,
                  borderRadius: 12,
                  label: 'Cancelar',
                  onPressed: () => Navigator.of(context).pop()
                )
              ),
              SizedBox(width: 10),
              Expanded(
                child:CustomButton(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.actionPrimary,
                  borderColor: AppColors.bgPrimary,
                  backgroundColor: AppColors.bgPrimary,
                  borderRadius: 12,
                  elevation: 5,
                  label: 'Guardar',
                  onPressed: _save
                )
              )
            ]
          )
        ]
      )
    );
  }
}