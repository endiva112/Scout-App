import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/custom_bottom_sheet.dart';

class DeleteProfileSheet extends StatelessWidget {
  const DeleteProfileSheet({super.key});

  static void show(BuildContext context) {
    CustomBottomSheet.show(
      context,
      content: const DeleteProfileSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Tu perfil Scout se eliminará de manera irrecuperable y perderás todos tus datos.\n¿Seguro que deseas eliminarlo?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: AppColors.bgPrimary),
          ),
        ),
        const SizedBox(height: 10),
        CustomButton(
          label: 'SÍ, ELIMINAR MI PERFIL',
          fontSize: 18,
          borderRadius: 12,
          backgroundColor: AppColors.bgPrimary,
          textColor: AppColors.actionPrimary,
          borderColor: AppColors.bgPrimary,
          onPressed: () => Navigator.pop(context), // TODO: lógica de borrado
        ),
        const SizedBox(height: 10),
        CustomButton(
          label: 'CANCELAR',
          fontSize: 18,
          borderRadius: 12,
          elevation: 0,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}