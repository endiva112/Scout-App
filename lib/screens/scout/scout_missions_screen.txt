import 'package:flutter/material.dart';

class ScoutMissionsScreen extends StatefulWidget {
  const ScoutMissionsScreen({super.key});

  @override
  State<ScoutMissionsScreen> createState() => _ScoutMissionsScreenState();
}

class _ScoutMissionsScreenState extends State<ScoutMissionsScreen> {
  // Cada tarjeta tiene su propio controller y su modo de edición
  final _precio1 = TextEditingController(text: '8,23');
  final _precio2 = TextEditingController(text: '8,23');

  bool _editando1 = false;
  bool _editando2 = false;

  @override
  void dispose() {
    _precio1.dispose();
    _precio2.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header simplificado: solo botón atrás, sin usuario
              Container(
                constraints: const BoxConstraints(minHeight: 70),
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back, size: 40),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Text('Mercadona',
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView(
                            padding: const EdgeInsets.only(bottom: 60),
                            children: [
                              _buildMisionCard(
                                controller: _precio1,
                                editando: _editando1,
                                onCorregir: () =>
                                    setState(() => _editando1 = true),
                                onCancelar: () =>
                                    setState(() => _editando1 = false),
                                onConfirmar: () =>
                                    setState(() => _editando1 = false),
                              ),
                              const SizedBox(height: 20),
                              _buildMisionCard(
                                controller: _precio2,
                                editando: _editando2,
                                onCorregir: () =>
                                    setState(() => _editando2 = true),
                                onCancelar: () =>
                                    setState(() => _editando2 = false),
                                onConfirmar: () =>
                                    setState(() => _editando2 = false),
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildMisionCard({
    required TextEditingController controller,
    required bool editando,
    required VoidCallback onCorregir,
    required VoidCallback onCancelar,
    required VoidCallback onConfirmar,
  }) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEE8B60), width: 2),
        ),
        child: Column(
          children: [
            // Nombre del producto
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Huevos camperos, 200mg super naturales con nombre largo creado a drede para que el conte...',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),

            // Fila precio + ayuda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Placeholder vacío para mantener el spaceBetween
                  const SizedBox(),

                  // Campo de precio con unidad
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      // En modo edición el borde es naranja, en lectura invisible
                      border: Border.all(
                        color: editando
                            ? const Color(0xFFEE8B60)
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            // readOnly cuando no estamos editando
                            readOnly: !editando,
                            textAlign: TextAlign.end,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text('€/Kg',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600])),
                        ),
                      ],
                    ),
                  ),

                  // Botón de ayuda
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

            // Botones — cambian según el modo
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: editando
                    ? [
                        // Modo edición: Cancelar + Corregido
                        _buildButton(
                          label: 'Cancelar',
                          onPressed: onCancelar,
                          backgroundColor: Colors.white,
                          textColor: const Color(0xFFEE8B60),
                          borderColor: const Color(0xFFEE8B60),
                        ),
                        _buildButton(
                          label: 'Corregido',
                          onPressed: onConfirmar,
                          backgroundColor: const Color(0xFF7CD2B9),
                          textColor: const Color(0xFF4E7566),
                          borderColor: const Color(0xFF7CD2B9),
                        ),
                      ]
                    : [
                        // Modo lectura: Corregir precio + Precio correcto
                        _buildButton(
                          label: 'Corregir precio',
                          onPressed: onCorregir,
                          backgroundColor: const Color(0xFFEE8B60),
                          textColor: Colors.white,
                          borderColor: const Color(0xFFEE8B60),
                        ),
                        _buildButton(
                          label: 'Precio correcto',
                          onPressed: onConfirmar,
                          backgroundColor: const Color(0xFF7CD2B9),
                          textColor: const Color(0xFF4E7566),
                          borderColor: const Color(0xFF7CD2B9),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 2,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor)),
      ),
    );
  }
}