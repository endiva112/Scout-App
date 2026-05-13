import 'package:flutter/material.dart';

class GenerarInvitacion extends StatelessWidget {
  const GenerarInvitacion({super.key});

  static const String routeName = 'generar-invitacion';
  static const String routePath = '/generarInvitacion';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: const Color(0xFFF1F4F8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _InvitacionBottomSheet(
                      onShare: () {},
                      onCancel: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bottom sheet ──────────────────────────────────────────────────────────────

class _InvitacionBottomSheet extends StatelessWidget {
  const _InvitacionBottomSheet({
    required this.onShare,
    required this.onCancel,
  });

  final VoidCallback onShare;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEE8B60), Colors.white],
          stops: [0.8, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Invitar a la lista',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              'Comparte el enlace con quien quieras\nCaduca en 48 horas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w300,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _LinkRow(onCopy: () {}),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onShare,
                icon: const Icon(
                  Icons.share_rounded,
                  size: 20,
                  color: Color(0xFFEE8B60),
                ),
                label: const Text(
                  'Compartir enlace',
                  style: TextStyle(
                    color: Color(0xFFEE8B60),
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1F4F8),
                  padding: const EdgeInsets.all(16),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEE8B60),
                  padding: const EdgeInsets.all(16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: Color(0xFFF1F4F8), width: 2),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ── Link row ──────────────────────────────────────────────────────────────────

class _LinkRow extends StatelessWidget {
  const _LinkRow({required this.onCopy});

  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4F8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: const [
              Icon(Icons.link_rounded, color: Color(0xFF57636C)),
              SizedBox(width: 5),
              Text(
                'scout.app/join/a3f8c2d1-4b7e',
                style: TextStyle(
                  color: Color(0xFF57636C),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onCopy,
            child: const Text(
              'Copiar',
              style: TextStyle(
                color: Color(0xFFEE8B60),
                fontSize: 14,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}