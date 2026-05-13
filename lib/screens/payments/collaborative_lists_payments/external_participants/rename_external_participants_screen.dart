import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background = Color(0xFFF1F4F8); // primaryBackground
  static const surface    = Colors.white;       // secondaryBackground
  static const textPrimary   = Color(0xFF14181B);
  //static const textSecondary = Color(0xFF57636C);
  static const border     = Color(0xFFE0E3E7);
  //static const error      = Color(0xFFFF5963);
}

// ── Widget principal ──────────────────────────────────────────────────────────
class EditarExternosPage extends StatefulWidget {
  const EditarExternosPage({super.key});

  @override
  State<EditarExternosPage> createState() => _EditarExternosPageState();
}

class _EditarExternosPageState extends State<EditarExternosPage> {
  // Hardcoded inicial, igual que en el original
  final _miembros = [
    'Integrante 1',
    'Integrante 2',
    'Markus',
    'El primo de Markus que conocimos aquel dia en la playa cuando nos fuimos de vacaciones El primo de ',
  ];

  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = _miembros.map((m) => TextEditingController(text: m)).toList();
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

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
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _AppColors.border, width: 2),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            const Text(
              'Editar miembros abonados',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: _AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            // Divisor punteado
            _buildDashedDivider(),
            const SizedBox(height: 10),
            // Lista de miembros
            Expanded(
              child: ListView.separated(
                itemCount: _controllers.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (_, i) => _buildMiembroRow(_controllers[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Fila de miembro ────────────────────────────────────────────────────────
  Widget _buildMiembroRow(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: _AppColors.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '-',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: _AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: null,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: _AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: _AppColors.background,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Divisor punteado ───────────────────────────────────────────────────────
  Widget _buildDashedDivider() {
    return LayoutBuilder(
      builder: (_, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(count, (_) => Container(
            width: dashWidth,
            height: 2,
            margin: const EdgeInsets.only(right: dashSpace),
            color: _AppColors.border,
          )),
        );
      },
    );
  }
}