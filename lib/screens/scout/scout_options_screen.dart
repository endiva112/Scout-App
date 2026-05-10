import 'package:flutter/material.dart';

class ScoutOptionsScreen extends StatefulWidget {
  const ScoutOptionsScreen({super.key});

  @override
  State<ScoutOptionsScreen> createState() => _ScoutOptionsScreenState();
}

class _ScoutOptionsScreenState extends State<ScoutOptionsScreen> {
  // Los TextEditingController gestionan el texto de cada campo
  // Equivalen al useState de React pero específico para inputs
  final _paisController    = TextEditingController(text: 'País');
  final _regionController  = TextEditingController(text: 'Región');
  final _ciudadController  = TextEditingController(text: 'Ciudad');

  // Estado de cada checkbox
  bool _mercadona = true;
  bool _lidl      = true;
  bool _dia       = true;

  @override
  void dispose() {
    // Siempre liberar los controllers cuando el widget se destruye
    _paisController.dispose();
    _regionController.dispose();
    _ciudadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              Expanded(child: _buildBody()),
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Buenas tardes!'),
              Text('Scout001'),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              'https://picsum.photos/seed/758/600',
              width: 50, height: 50, fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Botón atrás
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, size: 32),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Título + botón de ayuda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tiendas por tu zona',
                      style: TextStyle(fontSize: 24)),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFEE8B60),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(Icons.question_mark_rounded,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Lista de tiendas con checkboxes
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: [
                      _buildStoreCheckbox('Mercadona', _mercadona,
                          (v) => setState(() => _mercadona = v!)),
                      const SizedBox(height: 10),
                      _buildStoreCheckbox('Lidl', _lidl,
                          (v) => setState(() => _lidl = v!)),
                      const SizedBox(height: 10),
                      _buildStoreCheckbox('Dia', _dia,
                          (v) => setState(() => _dia = v!)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Sección de ubicación
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text('== UBICACIÓN ACTUAL =='),
                    const SizedBox(height: 10),
                    _buildLocationField(_paisController),
                    const SizedBox(height: 10),
                    _buildLocationField(_regionController),
                    const SizedBox(height: 10),
                    _buildLocationField(_ciudadController),
                    const SizedBox(height: 10),

                    // Botón confirmar
                    GestureDetector(
                      onTap: () {
                        // aquí irá la lógica de guardar
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF7CD2B9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: const Text(
                          'ESTABLECER NUEVA UBICACIÓN',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF4E7566),
                          ),
                        ),
                      ),
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

  // Fila tienda + checkbox
  Widget _buildStoreCheckbox(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFFEE8B60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }

  // Campo de texto para ubicación, sin borde visible (igual que en FF)
  Widget _buildLocationField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // sin borde visible
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.filter_list, 'Listas'),
          _buildNavItem(Icons.money_off_csred, 'Pagos'),
          _buildNavItem(Icons.star_rounded, 'Notas'),
          _buildNavItem(Icons.flag_sharp, 'Scout', active: true),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool active = false}) {
    final color = active ? const Color(0xFFEE8B60) : Colors.black;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 32, color: color),
        Text(label,
            style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w300, color: color)),
      ],
    );
  }
}