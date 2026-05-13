import 'package:flutter/material.dart';

class AgregarTiendaSheet extends StatefulWidget {
  const AgregarTiendaSheet({super.key});

  @override
  State<AgregarTiendaSheet> createState() => _AgregarTiendaSheetState();
}

class _AgregarTiendaSheetState extends State<AgregarTiendaSheet> {
  final _controller = TextEditingController(text: 'Mer');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEE8B60), Colors.white],
          stops: [0.8, 1.0],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Agregar supermercado',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Colors.white)),
          const SizedBox(height: 10),

          // Campo de texto
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              controller: _controller,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Botones
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  context,
                  label: 'CANCELAR',
                  backgroundColor: const Color(0xFFD67A31),
                  textColor: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                _buildButton(
                  context,
                  label: 'GUARDAR',
                  backgroundColor: Colors.white,
                  textColor: const Color(0xFFEE8B60),
                  onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 5,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
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

/*

final tienda = await showModalBottomSheet<String>(
  context: context,
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (context) => const AgregarTiendaSheet(),
);

if (tienda != null && tienda.isNotEmpty) {
  // añadir tienda a la lista
}

 */