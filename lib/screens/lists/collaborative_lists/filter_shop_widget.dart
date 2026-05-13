import 'package:flutter/material.dart';

class FiltrarTiendasSheet extends StatefulWidget {
  const FiltrarTiendasSheet({super.key});

  @override
  State<FiltrarTiendasSheet> createState() => _FiltrarTiendasSheetState();
}

class _FiltrarTiendasSheetState extends State<FiltrarTiendasSheet> {
  // Map tienda → seleccionada, fácil de extender cuando vengan de Firebase
  final Map<String, bool> _tiendas = {
    'Mercadona': true,
    'Lidl':      true,
    'Dia':       true,
    'El Jamon':  true,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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

          // Título + botón ayuda
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Comparación de precios',
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

          // Lista de tiendas con checkboxes generada desde el Map
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _tiendas.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final nombre = _tiendas.keys.elementAt(index);
                return _buildTiendaRow(nombre, _tiendas[nombre]!);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTiendaRow(String nombre, bool seleccionada) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nombre,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
            Checkbox(
              value: seleccionada,
              onChanged: (v) => setState(() => _tiendas[nombre] = v!),
              activeColor: const Color(0xFFEE8B60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }
}

/*

final seleccion = await showModalBottomSheet<Map<String, bool>>(
  context: context,
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (context) => const FiltrarTiendasSheet(),
);

*/