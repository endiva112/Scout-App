import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background    = Color(0xFFF1F4F8); // primaryBackground
  static const surface       = Colors.white;       // secondaryBackground
  static const textPrimary   = Color(0xFF14181B);
  static const textSecondary = Color(0xFF57636C);
  static const orange        = Color(0xFFEE8B60);
  static const border        = Color(0xFFE0E3E7);
}

// ── Widget principal ──────────────────────────────────────────────────────────
class InfoReembolsoPage extends StatelessWidget {
  const InfoReembolsoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _AppColors.surface,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(),
              Expanded(child: _buildBody()),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top bar ────────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back, size: 40, color: _AppColors.textPrimary),
          Row(
            children: [
              Row(
                children: const [
                  Icon(Icons.chevron_left_rounded,  size: 40, color: _AppColors.textPrimary),
                  SizedBox(width: 5),
                  Icon(Icons.chevron_right_rounded, size: 40, color: _AppColors.textPrimary),
                ],
              ),
              const SizedBox(width: 20),
              const Icon(Icons.more_vert_rounded, size: 40, color: _AppColors.textPrimary),
            ],
          ),
        ],
      ),
    );
  }

  // ── Cuerpo ─────────────────────────────────────────────────────────────────
  Widget _buildBody() {
    return Container(
      color: _AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            const Text(
              'Reembolso',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 28,
                color: _AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Lunes 21 Abril 14:44',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: _AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Enviado por
            const Text(
              'Enviado por',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: _AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            _buildPersonaCard(
              nombre: 'Enrique (Yo)',
              importe: '30,00 €',
              importeColor: _AppColors.orange,
            ),
            const SizedBox(height: 10),

            // Recibido por
            const Text(
              'Recibido por',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: _AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            _buildPersonaCard(
              nombre: 'Alex',
              importe: '30,00 €',
              importeColor: _AppColors.textSecondary,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ── Tarjeta de persona ─────────────────────────────────────────────────────
  Widget _buildPersonaCard({
    required String nombre,
    required String importe,
    required Color importeColor,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _AppColors.border, width: 2),
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Avatar
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: ClipOval(
                child: Image.network(
                  'https://picsum.photos/seed/50/600',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 5),
            // Nombre
            Expanded(
              flex: 5,
              child: Text(
                nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: _AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 5),
            // Importe
            Expanded(
              flex: 3,
              child: Text(
                importe,
                maxLines: 1,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: importeColor,
                ),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}