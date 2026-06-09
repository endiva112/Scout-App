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
    final inviteUrl = 'https://scoutapp.com/invite/$listId/estoEsUnTest';

    CustomBottomSheet.show(
      context,
      content: _InvitationSheetContent(
        inviteUrl: inviteUrl,
      ),
    );
  }
}

class _InvitationSheetContent extends StatefulWidget {
  final String inviteUrl;

  const _InvitationSheetContent({
    required this.inviteUrl,
  });

  @override
  State<_InvitationSheetContent> createState() =>
      _InvitationSheetContentState();
}

class _InvitationSheetContentState extends State<_InvitationSheetContent> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.inviteUrl);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showTopToast(String message) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.actionPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.bgPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Invitar a la lista',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.bgPrimary,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Comparte el enlace con quien quieras\nCaduca en 48 horas',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.bgPrimary,
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
              const Icon(Icons.link_rounded,
                  size: 18, color: AppColors.textSecondary),
              const SizedBox(width: 8),

              Expanded(
                child: TextField(
                  controller: _controller,
                  readOnly: true,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),

              SizedBox(width: 5),

              GestureDetector(
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: _controller.text),
                  );

                  _showTopToast('¡Enlace copiado!');
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

        const SizedBox(height: 10),

        CustomButton(
          label: 'Compartir enlace',
          fontSize: 18,
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

        const SizedBox(height: 5),

        CustomButton(
          label: 'Cancelar',
          fontSize: 18,
          onPressed: () => Navigator.pop(context),
          backgroundColor: AppColors.actionPrimary,
          textColor: AppColors.bgPrimary,
          borderColor: AppColors.bgPrimary,
          borderRadius: 12,
          elevation: 0,
        ),
      ],
    );
  }
}