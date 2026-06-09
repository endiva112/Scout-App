import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background    = Color(0xFFF1F4F8);
  static const surface       = Colors.white;
  static const textPrimary   = Color(0xFF14181B);
  static const textSecondary = Color(0xFF57636C);
  static const accent        = Color(0xFF7CD2B9);
  static const orangeDark    = Color(0xFFD67A31);
  static const error         = Color(0xFFFF5963);
  static const border        = Color(0xFFE0E3E7);
}

// ── Modelos de datos ──────────────────────────────────────────────────────────
class _GastoPendiente {
  final String nombre;
  const _GastoPendiente(this.nombre);
}

class _GastoAbonado {
  final String nombre;
  final String pagador;
  final String importe;
  final Color borderColor;
  const _GastoAbonado({
    required this.nombre,
    required this.pagador,
    required this.importe,
    required this.borderColor,
  });
}

class _GrupoFecha {
  final String fecha;
  final List<_GastoAbonado> gastos;
  const _GrupoFecha({required this.fecha, required this.gastos});
}

// ── Widget principal ──────────────────────────────────────────────────────────
class RecurringExpensesScreen extends StatelessWidget {
  const RecurringExpensesScreen({super.key});

  static const _pendientes = [
    _GastoPendiente('Luz y agua'),
    _GastoPendiente('Contribución'),
    _GastoPendiente('Gasolina de este mes'),
  ];

  static const _grupos = [
    _GrupoFecha(
      fecha: 'Hoy',
      gastos: [
        _GastoAbonado(
          nombre: 'Contribución millonaria',
          pagador: 'Paco Nombre Muy Largo Como caso',
          importe: '1.111.111,10 €',
          borderColor: _AppColors.orangeDark,
        ),
      ],
    ),
    _GrupoFecha(
      fecha: '2 de abril de 2026',
      gastos: [
        _GastoAbonado(
          nombre: 'Cubiertos y extras para que ocu',
          pagador: 'Paco Nombre Muy pero que',
          importe: '111,10 €',
          borderColor: _AppColors.accent,
        ),
        _GastoAbonado(
          nombre: 'Cubiertos y extras para que ocu',
          pagador: 'Paco Nombre Muy pero que',
          importe: '111,10 €',
          borderColor: _AppColors.orangeDark,
        ),
      ],
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
              _buildBottomBar(),
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
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.arrow_back, size: 40, color: _AppColors.textPrimary),
      ),
    );
  }

  // ── Cuerpo ─────────────────────────────────────────────────────────────────
  Widget _buildBody() {
    return Container(
      color: _AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Gastos',
              style: TextStyle(fontSize: 28, color: _AppColors.textPrimary),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Anotad los costes de los elementos por abonar para dividir los costes de manera sencilla',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: _AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildResumenCard(),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              children: [
                _buildSeccionPendiente(),
                const SizedBox(height: 10),
                ..._grupos.map(_buildSeccionFecha),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Tarjeta resumen ────────────────────────────────────────────────────────
  Widget _buildResumenCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: Colors.transparent,
        elevation: 1,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            color: _AppColors.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Expanded(child: _buildResumenItem('Mis Gastos',     '2.061.111,23 €')),
              Expanded(child: _buildResumenItem('Gastos Totales', '2.062.333,53 €')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResumenItem(String label, String importe) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            importe,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ── Sección pendientes ─────────────────────────────────────────────────────
  Widget _buildSeccionPendiente() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            'Por abonar',
            style: TextStyle(fontWeight: FontWeight.w600, color: _AppColors.textPrimary),
          ),
        ),
        ..._pendientes.map(_buildFilaPendiente),
      ],
    );
  }

  Widget _buildFilaPendiente(_GastoPendiente item) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: _AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _AppColors.error, width: 2),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  item.nombre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.payments_rounded, size: 32, color: _AppColors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }

  // ── Sección por fecha ──────────────────────────────────────────────────────
  Widget _buildSeccionFecha(_GrupoFecha grupo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            grupo.fecha,
            style: const TextStyle(fontWeight: FontWeight.w600, color: _AppColors.textPrimary),
          ),
        ),
        ...grupo.gastos.map(_buildFilaAbonado),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildFilaAbonado(_GastoAbonado item) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            color: _AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: item.borderColor, width: 2),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nombre,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: _AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Pagado por ',
                          style: TextStyle(color: _AppColors.textPrimary),
                        ),
                        Expanded(
                          child: Text(
                            item.pagador,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  item.importe,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Bottom bar ─────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: Material(
          color: Colors.transparent,
          elevation: 5,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            constraints: const BoxConstraints(minHeight: 50),
            decoration: BoxDecoration(
              color: _AppColors.error,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: _AppColors.border),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const Center(
              child: Text(
                'Gestionar saldos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: _AppColors.background,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}