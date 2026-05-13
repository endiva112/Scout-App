import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background = Color(0xFFF1F4F8); // primaryBackground
  static const surface    = Colors.white;       // secondaryBackground
  static const orange     = Color(0xFFEE8B60);
}

// ── Widget principal ──────────────────────────────────────────────────────────
class TodoPagadoMenuPage extends StatelessWidget {
  const TodoPagadoMenuPage({super.key});

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
              Expanded(child: Container(color: _AppColors.background)),
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
              '¿Estás seguro de querer anotar que todos los integrantes externos han pagado?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: _AppColors.surface),
            ),
          ),

          // Botón confirmar
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
                  '¡SI! TODOS HAN PAGADO',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Botón cancelar
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