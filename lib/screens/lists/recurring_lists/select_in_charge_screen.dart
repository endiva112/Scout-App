import 'package:flutter/material.dart';

// Reutiliza _AppColors de b_recurrente_crear.dart
class _AppColors {
  static const orange = Color(0xFFEE8B60);
  static const primaryBackground = Color(0xFFF1F4F8);
  static const secondaryBackground = Colors.white;
  static const primaryText = Color(0xFF14181B);
  //static const secondaryText = Color(0xFF57636C);
  static const alternate = Color(0xFFE0E3E7);
  static const primary = Color(0xFF4B39EF); // color del checkbox activo
  static const info = Colors.white;         // checkmark color
}

// ─── Modelo de datos ──────────────────────────────────────────────────────────

class _Member {
  final String name;
  bool selected;
  _Member(this.name, {this.selected = false});
}

// ─── Pantalla ─────────────────────────────────────────────────────────────────

class SelectInChargeScreen extends StatefulWidget {
  const SelectInChargeScreen({super.key});

  @override
  State<SelectInChargeScreen> createState() =>
      _SelectInChargeScreenState();
}

class _SelectInChargeScreenState
    extends State<SelectInChargeScreen> {
  // Lista de miembros – hardcoded, el primero empieza seleccionado
  final List<_Member> _members = [
    _Member('Sin encargado', selected: true),
    _Member('Enrique (Yo)'),
    _Member('Lia'),
    _Member('Tommy'),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _AppColors.secondaryBackground,
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

  // ─── Top bar (idéntico al resto de pantallas) ──────────────────────────────

  Widget _buildTopBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.secondaryBackground,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back, size: 40, color: _AppColors.primaryText),
          Row(
            children: [
              _navIcon(Icons.attach_money_sharp),
              const SizedBox(width: 10),
              _navIcon(Icons.event_note_rounded),
              const SizedBox(width: 10),
              _navIcon(Icons.person),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon) {
    return Material(
      elevation: 1.2,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: _AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 38, color: _AppColors.primaryText),
      ),
    );
  }

  // ─── Body ──────────────────────────────────────────────────────────────────

  Widget _buildBody() {
    return Container(
      color: _AppColors.primaryBackground,
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Flecha interna de vuelta
            const Icon(Icons.arrow_back, size: 32, color: _AppColors.primaryText),
            const SizedBox(height: 10),

            // Título + icono de ayuda
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Seleccionar encargado de este gasto',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, color: _AppColors.primaryText),
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: const BoxDecoration(
                    color: _AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Icon(
                    Icons.question_mark_rounded,
                    color: _AppColors.info,
                    size: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Contador de miembros
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                '3 miembros',
                style: TextStyle(fontSize: 14, color: _AppColors.primaryText),
              ),
            ),
            const SizedBox(height: 10),

            // Lista de miembros
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: _AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  itemCount: _members.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (_, i) => _buildMemberRow(_members[i], i),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberRow(_Member member, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              member.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: _AppColors.primaryText,
              ),
            ),
            Checkbox(
              value: member.selected,
              onChanged: (v) => setState(() => member.selected = v!),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              side: const BorderSide(width: 2, color: _AppColors.alternate),
              activeColor: _AppColors.primary,
              checkColor: _AppColors.info,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }

  // ─── Bottom bar (vacío, solo mantiene la altura mínima) ───────────────────

  Widget _buildBottomBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.secondaryBackground,
    );
  }
}