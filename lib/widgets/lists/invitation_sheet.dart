import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scout_app/repositories/lists/invitation_repository.dart';
import 'package:scout_app/theme/app_colors.dart';
import 'package:scout_app/widgets/buttons/custom_button.dart';
import 'package:scout_app/widgets/common/custom_bottom_sheet.dart';

class InvitationSheet {
  static void show({
    required BuildContext context,
    required String listId,
  }) {
    CustomBottomSheet.show(
      context,
      content: _InvitationSheetContent(listId: listId),
    );
  }
}

// ── Estados internos ─────────────────────────────────────────────────────────

sealed class _InvitationState {}
class _Loading extends _InvitationState {}
class _Ready extends _InvitationState {
  final String url;
  _Ready(this.url);
}
class _Error extends _InvitationState {}

// ── Widget ───────────────────────────────────────────────────────────────────

class _InvitationSheetContent extends StatefulWidget {
  final String listId;

  const _InvitationSheetContent({required this.listId});

  @override
  State<_InvitationSheetContent> createState() =>
      _InvitationSheetContentState();
}

class _InvitationSheetContentState extends State<_InvitationSheetContent> {
  final _repo = InvitationRepository();
  late final TextEditingController _controller;
  _InvitationState _state = _Loading();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _generateInvitation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _generateInvitation() async {
    try {
      final invitation = await _repo.createInvitation(widget.listId);
      final url = 'https://endiva112.github.io/Scout-App/invite/${widget.listId}/${invitation.token}';

      if (!mounted) return;
      setState(() {
        _state = _Ready(url);
        _controller.text = url;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _state = _Error());
    }
  }

  void _showTopToast(String message) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (ctx) => Positioned(
        top: MediaQuery.of(ctx).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
    Future.delayed(const Duration(seconds: 2), entry.remove);
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
              color: AppColors.bgPrimary),
        ),
        const SizedBox(height: 10),
        const Text(
          'Comparte el enlace con quien quieras\nCaduca en 48 horas',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.bgPrimary,
              height: 1.3),
        ),
        const SizedBox(height: 20),
        _buildUrlBox(),
        const SizedBox(height: 10),
        CustomButton(
          label: 'Compartir enlace',
          fontSize: 18,
          onPressed: _state is _Ready
              ? () => Navigator.pop(context) // TODO: share nativo
              : () {}, // no-op mientras carga
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
      ],//https://scoutapp.com/invite/r3s2fcd96phHrt8Ta1oP/Hh3YfzHFIyJZMgMoWwiVe5fJHiW56Ik0
    );
  }

  Widget _buildUrlBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.bgPrimary, borderRadius: BorderRadius.circular(12)),
      child: switch (_state) {
        _Loading() => const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        _Error() => const Text(
            'No se pudo generar el enlace. Inténtalo de nuevo.',
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
        _Ready() => Row(
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
                      border: InputBorder.none, isCollapsed: true),
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _controller.text));
                  _showTopToast('¡Enlace copiado!');
                },
                child: const Text(
                  'Copiar',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.actionPrimary),
                ),
              ),
            ],
          ),
      },
    );
  }
}