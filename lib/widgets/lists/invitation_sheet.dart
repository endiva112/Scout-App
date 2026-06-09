import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';

class InvitationSheet {
  static void show({
    required BuildContext context,
    required String listId,
  }) {
    // TODO: lógica real de generación de enlace
    final inviteUrl = 'https://scoutapp.com/invite/$listId/estoEsUnTest';

    CustomBottomSheet.show(
      context,
      content: _InvitationSheetContent(
        inviteUrl: inviteUrl,
      ),
    );
  }
}

class _InvitationSheetContent extends StatelessWidget {
  final String inviteUrl;

  const _InvitationSheetContent({
    required this.inviteUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        const Text(
          'Invitar a la lista',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Comparte el enlace con quien quieras\nCaduca en 48 horas',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w300,
            color: AppColors.textPrimary,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.bgPrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const Icon(Icons.link_rounded, size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  inviteUrl,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: inviteUrl));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Enlace copiado')),
                  );
                },
                child: const Text(
                  'Copiar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.actionPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CustomButton(
          label: 'Compartir enlace',
          onPressed: () {
            // TODO: share nativo
            Navigator.pop(context);
          },
          backgroundColor: AppColors.bgPrimary,
          textColor: AppColors.actionPrimary,
          borderColor: AppColors.bgPrimary,
          borderRadius: 12,
          elevation: 2,
        ),
        const SizedBox(height: 12),
        CustomButton(
          label: 'Cancelar',
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.actionPrimary,
          textColor: AppColors.bgPrimary,
          borderColor: AppColors.actionPrimary,
          borderRadius: 12,
          elevation: 0,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}