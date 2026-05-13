import 'package:flutter/material.dart';

class RegistrarPagoMenuSheet extends StatefulWidget {
  const RegistrarPagoMenuSheet({super.key});

  @override
  State<RegistrarPagoMenuSheet> createState() => _RegistrarPagoMenuSheetState();
}

class _RegistrarPagoMenuSheetState extends State<RegistrarPagoMenuSheet> {
  int _cantidad = 4; // valor inicial del contador

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // El gradiente va de naranja arriba a blanco abajo
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
        mainAxisSize: MainAxisSize.min, // ocupa solo lo necesario
        children: [
          // Pregunta
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              '¿Cuántos miembros externos han hecho su pago?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),

          // Contador: - | número | +
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón menos
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      if (_cantidad > 0) setState(() => _cantidad--);
                    },
                    icon: const Icon(Icons.remove_rounded,
                        color: Colors.white, size: 50),
                  ),
                ),

                // Número actual
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$_cantidad',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                ),

                // Botón más
                Expanded(
                  child: IconButton(
                    onPressed: () => setState(() => _cantidad++),
                    icon: const Icon(Icons.add_rounded,
                        color: Colors.white, size: 50),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Botones cancelar / confirmar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton(
                context,
                label: 'CANCELAR',
                backgroundColor: const Color(0xFFEE8B60),
                textColor: Colors.white,
                onPressed: () => Navigator.of(context).pop(),
              ),
              _buildButton(
                context,
                label: 'CONFIRMAR',
                backgroundColor: Colors.white,
                textColor: const Color(0xFFEE8B60),
                onPressed: () {
                  // aquí irá la lógica de confirmar con _cantidad
                  Navigator.of(context).pop(_cantidad);
                },
              ),
            ],
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
      width: MediaQuery.of(context).size.width * 0.42,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor)),
      ),
    );
  }
}

/*
Así es como se invoca:

// El pop() del botón CONFIRMAR devuelve _cantidad
// Puedes capturarla aquí si la necesitas en la pantalla padre
final pagos = await showModalBottomSheet<int>(
  context: context,
  backgroundColor: Colors.transparent, // para que se vea el gradiente
  builder: (context) => const RegistrarPagoMenuSheet(),
);

// pagos tendrá el número confirmado, o null si cancelaron
if (pagos != null) {
  // hacer algo con pagos
}

*/