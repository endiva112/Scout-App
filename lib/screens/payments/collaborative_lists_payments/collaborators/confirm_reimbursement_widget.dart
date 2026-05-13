import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background = Color(0xFFF1F4F8); // primaryBackground
  static const surface    = Colors.white;       // secondaryBackground
  static const orange     = Color(0xFFEE8B60);
}

// ── Widget principal ──────────────────────────────────────────────────────────
class PagoMenuPage extends StatelessWidget {
  const PagoMenuPage({super.key});

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
              // Área gris superior (vacía, empuja el panel hacia abajo)
              Expanded(
                child: Container(color: _AppColors.background),
              ),
              // Panel inferior con gradiente
              _buildBottomPanel(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomPanel(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_AppColors.orange, _AppColors.surface],
          stops: [0.8, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(
              'Se añadirá un reembolso al balance de esta lista',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: _AppColors.surface,
              ),
            ),
          ),

          // Botón "¡ESTÁ PAGADO!"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _AppColors.background,
                  foregroundColor: _AppColors.orange,
                  elevation: 2,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  '¡ESTÁ PAGADO!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Botón "CANCELAR"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _AppColors.orange,
                  foregroundColor: _AppColors.surface,
                  elevation: 0,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'CANCELAR',
                  style: TextStyle(fontSize: 18),
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