import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background    = Color(0xFFF1F4F8); // primaryBackground
  static const surface       = Colors.white;       // secondaryBackground
  static const textPrimary   = Color(0xFF14181B);
  static const textSecondary = Color(0xFF57636C);
  static const accent        = Color(0xFF7CD2B9);
  static const orange        = Color(0xFFEE8B60);
  static const success       = Color(0xFF249689);
  static const error         = Color(0xFFFF5963);
}

// ── Modelo de datos ───────────────────────────────────────────────────────────
class _SaldoItem {
  final String nombre;
  final String importe;
  final Color borderColor;
  final Color importeColor;

  const _SaldoItem({
    required this.nombre,
    required this.importe,
    required this.borderColor,
    required this.importeColor,
  });
}

// ── Widget principal ──────────────────────────────────────────────────────────
class SaldosRecurrentesPage extends StatelessWidget {
  const SaldosRecurrentesPage({super.key});

  static const _saldos = [
    _SaldoItem(
      nombre: 'Enrique (Yo)',
      importe: '+ 30,00 €',
      borderColor: _AppColors.accent,
      importeColor: _AppColors.success,
    ),
    _SaldoItem(
      nombre: 'Paco',
      importe: '- 40,00 €',
      borderColor: _AppColors.orange,
      importeColor: _AppColors.error,
    ),
    _SaldoItem(
      nombre: 'Felix',
      importe: '+ 10,00 €',
      borderColor: _AppColors.orange,
      importeColor: _AppColors.success,
    ),
  ];

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
          Material(
            color: Colors.transparent,
            elevation: 1.2,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: _AppColors.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                size: 38,
                color: _AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Cuerpo ─────────────────────────────────────────────────────────────────
  Widget _buildBody() {
    return Container(
      color: _AppColors.background,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Título
          const Text(
            'Saldos',
            style: TextStyle(fontSize: 28, color: _AppColors.textPrimary),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Gestiona quién debe a quién de manera simple',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: _AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Tarjeta "Te deben"
          _buildTeDeben(),
          const SizedBox(height: 10),

          // Subtítulo lista
          const Text(
            'Saldos de los integrantes de la lista',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: _AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          // Lista de saldos
          Expanded(
            child: ListView.separated(
              itemCount: _saldos.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (_, i) => _buildSaldoRow(_saldos[i]),
            ),
          ),
        ],
      ),
    );
  }

  // ── Tarjeta "Te deben" ─────────────────────────────────────────────────────
  Widget _buildTeDeben() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: _AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _AppColors.orange, width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(Icons.thumb_up, color: _AppColors.orange, size: 36),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Text(
                      'Te deben',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '30,00 €',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: _AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Consulta lo que te deben',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: _AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            flex: 1,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: _AppColors.textSecondary,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }

  // ── Fila de saldo de integrante ────────────────────────────────────────────
  Widget _buildSaldoRow(_SaldoItem item) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: _AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: item.borderColor, width: 2),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const SizedBox(width: 2),
          // Avatar
          ClipOval(
            child: Image.network(
              'https://picsum.photos/seed/50/600',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 2),
          // Nombre
          Expanded(
            child: Text(
              item.nombre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: _AppColors.textPrimary,
              ),
            ),
          ),
          // Importe
          Expanded(
            child: Text(
              item.importe,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: item.importeColor,
              ),
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}