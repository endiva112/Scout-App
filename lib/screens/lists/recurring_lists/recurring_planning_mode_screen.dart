import 'package:flutter/material.dart';

// ─── Colores de la app ────────────────────────────────────────────────────────
// Sustituye estos valores por tu ThemeData cuando lo tengas listo.
class _AppColors {
  static const green = Color(0xFF7CD2B9);
  static const greenDark = Color(0xFF4E7566);
  static const orange = Color(0xFFEE8B60);

  // Claros (light mode). Ajusta según tu tema.
  static const primaryBackground = Color(0xFFF1F4F8);
  static const secondaryBackground = Colors.white;
  static const primaryText = Color(0xFF14181B);
  static const secondaryText = Color(0xFF57636C);
  static const accent3 = Color(0xFFE0E3E7);
  static const error = Color(0xFFFF5963);
}

// ─── Pantalla ─────────────────────────────────────────────────────────────────

class RecurringPlanningModeScreen extends StatefulWidget {
  const RecurringPlanningModeScreen({super.key});

  @override
  State<RecurringPlanningModeScreen> createState() => _RecurringPlanningModeScreenState();
}

class _RecurringPlanningModeScreenState extends State<RecurringPlanningModeScreen> {
  // Dropdown state
  String _repeatAt = 'FINALES';
  String _repeatEvery = 'MES';

  // Controllers – hardcodeados con datos de ejemplo
  late final List<TextEditingController> _nameControllers;
  late final List<TextEditingController> _amountControllers;

  // Datos de los grupos (hardcoded)
  final _groups = [
    _GroupData(
      title: 'General',
      participants: '3 participantes',
      items: [
        _ItemData(name: 'Netflix', amount: '20€', avatarUrl: 'https://picsum.photos/seed/8/600'),
        _ItemData(name: 'Luz y agua', amount: '-', icon: Icons.person_off),
        _ItemData(name: 'Contribución al horrible casero', amount: '-', icon: Icons.person_off),
      ],
    ),
    _GroupData(
      title: 'Lia & Tommy :)',
      participants: '2 participantes',
      items: [
        _ItemData(name: 'Crunchyroll', amount: '20€', avatarUrl: 'https://picsum.photos/seed/8/600'),
        _ItemData(name: 'Suscripción a la bolera', amount: '-', icon: Icons.person_off),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _nameControllers = _groups
        .expand((g) => g.items)
        .map((i) => TextEditingController(text: i.name))
        .toList();
    _amountControllers = _groups
        .expand((g) => g.items)
        .map((i) => TextEditingController(text: i.amount))
        .toList();
  }

  @override
  void dispose() {
    for (final c in [..._nameControllers, ..._amountControllers]) {
      c.dispose();
    }
    super.dispose();
  }

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

  // ─── Top bar ───────────────────────────────────────────────────────────────

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                'Gastos del piso de la universidad',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 28, color: _AppColors.primaryText),
              ),
            ),
            const SizedBox(height: 2),
            // Subtítulo
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Última modificación: 21 Abril 2026',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: _AppColors.secondaryText,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Card de recurrencia
            _buildRecurrenceCard(),
            const SizedBox(height: 10),

            // Cards de grupos
            ..._buildGroupCards(),
            const SizedBox(height: 10),

            // Botón agregar subdivisión
            _buildAddSubdivisionButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ─── Tarjeta de recurrencia ────────────────────────────────────────────────

  Widget _buildRecurrenceCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: _AppColors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildDropdownRow('REPETIR A', ['INICIO', 'FINALES'], _repeatAt,
                  (v) => setState(() => _repeatAt = v!)),
              const SizedBox(height: 5),
              _buildDropdownRow('DE CADA', ['SEMANA', 'MES', 'AÑO'], _repeatEvery,
                  (v) => setState(() => _repeatEvery = v!)),
              const SizedBox(height: 5),
              // Footer de la card
              Container(
                decoration: const BoxDecoration(
                  color: _AppColors.secondaryBackground,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  border: Border(
                    top: BorderSide(color: _AppColors.green),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('El primer importe se hará el:',
                        style: TextStyle(
                            color: _AppColors.secondaryText,
                            fontWeight: FontWeight.w500)),
                    Text('30 Abril 2026',
                        style: TextStyle(
                            color: _AppColors.primaryText,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownRow(
    String label,
    List<String> options,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _AppColors.greenDark,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: _AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                underline: const SizedBox(),
                icon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: _AppColors.secondaryText),
                style: const TextStyle(
                  color: _AppColors.secondaryText,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                items: options
                    .map((o) => DropdownMenuItem(value: o, child: Text(o)))
                    .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Cards de grupos ───────────────────────────────────────────────────────

  List<Widget> _buildGroupCards() {
    int controllerIndex = 0;
    return _groups.map((group) {
      final startIndex = controllerIndex;
      controllerIndex += group.items.length;
      return Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: _buildGroupCard(group, startIndex),
      );
    }).toList();
  }

  Widget _buildGroupCard(_GroupData group, int startIndex) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.secondaryBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _AppColors.accent3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabecera del grupo
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(group.title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                  Row(
                    children: [
                      Text(group.participants,
                          style: const TextStyle(
                              fontSize: 15, color: _AppColors.secondaryText)),
                      const SizedBox(width: 10),
                      _groupsIcon(),
                    ],
                  ),
                ],
              ),
            ),

            // Filas de items
            ...group.items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final ci = startIndex + i;
              return Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: _buildItemRow(
                  nameController: _nameControllers[ci],
                  amountController: _amountControllers[ci],
                  item: item,
                ),
              );
            }),

            // Botón agregar elemento
            _buildAddItemButton(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ─── Fila de item (nombre + importe + avatar/icono) ────────────────────────

  Widget _buildItemRow({
    required TextEditingController nameController,
    required TextEditingController amountController,
    required _ItemData item,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Row(
        children: [
          // Campo nombre
          Expanded(
            flex: 5,
            child: _cleanTextField(
              controller: nameController,
              fillColor: _AppColors.secondaryBackground,
              textAlign: TextAlign.start,
              textColor: _AppColors.primaryText,
            ),
          ),
          const SizedBox(width: 5),
          // Campo importe
          Expanded(
            flex: 3,
            child: _cleanTextField(
              controller: amountController,
              fillColor: _AppColors.primaryBackground,
              textAlign: TextAlign.center,
              textColor: _AppColors.secondaryText,
            ),
          ),
          const SizedBox(width: 5),
          // Avatar o icono
          Expanded(
            flex: 1,
            child: item.avatarUrl != null
                ? ClipOval(
                    child: Image.network(item.avatarUrl!,
                        fit: BoxFit.cover, width: 36, height: 36),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      color: _AppColors.orange,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Icon(item.icon,
                        color: _AppColors.primaryBackground, size: 20),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _cleanTextField({
    required TextEditingController controller,
    required Color fillColor,
    required TextAlign textAlign,
    required Color textColor,
  }) {
    return TextFormField(
      controller: controller,
      textAlign: textAlign,
      maxLines: null,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // ─── Botón "Agregar otro elemento" ────────────────────────────────────────

  Widget _buildAddItemButton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: _AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: const Text(
          'AGREGAR OTRO ELEMENTO',
          style: TextStyle(
            color: Color(0x8A57636C),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // ─── Botón "Agregar subdivisión" ───────────────────────────────────────────

  Widget _buildAddSubdivisionButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: _AppColors.primaryBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _AppColors.secondaryText, width: 2),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Agregar subdivisión de gastos',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  // ─── Bottom bar ────────────────────────────────────────────────────────────

  Widget _buildBottomBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.secondaryBackground,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: 200,
        height: 40,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: _AppColors.error,
            foregroundColor: _AppColors.primaryBackground,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Lista desactivada'),
        ),
      ),
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Widget _groupsIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: _AppColors.orange,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(2),
      child: const Icon(Icons.groups_2, color: _AppColors.primaryBackground, size: 20),
    );
  }
}

// ─── Modelos de datos (hardcoded) ─────────────────────────────────────────────

class _GroupData {
  final String title;
  final String participants;
  final List<_ItemData> items;
  const _GroupData({required this.title, required this.participants, required this.items});
}

class _ItemData {
  final String name;
  final String amount;
  final String? avatarUrl;
  final IconData icon;
  const _ItemData({
    required this.name,
    required this.amount,
    this.avatarUrl,
    this.icon = Icons.person_off,
  });
}