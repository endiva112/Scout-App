import 'package:flutter/material.dart';

// Modelo de datos para cada deuda — cuando llegue Firebase vendrá de Firestore
class _Deuda {
  final String deudor;
  final String acreedor;
  final String cantidad;

  const _Deuda({
    required this.deudor,
    required this.acreedor,
    required this.cantidad,
  });
}

class GestionarPagosScreen extends StatelessWidget {
  const GestionarPagosScreen({super.key});

  static const List<_Deuda> _deudas = [
    _Deuda(deudor: 'Guillermo', acreedor: 'Enrique (yo)', cantidad: '50,85 €'),
    _Deuda(deudor: 'Enrique (yo)', acreedor: 'Guillermo', cantidad: '50,85 €'),
  ];

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
              // Header: solo botón atrás
              Container(
                constraints: const BoxConstraints(minHeight: 70),
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),

                      // ── Resumen de saldos ────────────────────────
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Todo el mundo te ha pagado y no les debes nada',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 5),

                      _buildBadge('0,00 €', const Color(0xFF8A8C8F)),
                      const SizedBox(height: 5),

                      const Text('Te deben',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),

                      _buildBadge('50,85 €', const Color(0xFF60D394)),
                      const SizedBox(height: 5),

                      const Text('Debes',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 5),

                      _buildBadge('50,85 €', const Color(0xFFEE6055)),
                      const SizedBox(height: 5),

                      // ── Lista de deudas ──────────────────────────
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemCount: _deudas.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) =>
                              _buildDeudaCard(context, _deudas[index]),
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

  // Píldora de color con cantidad — gris, verde o rojo
  Widget _buildBadge(String amount, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        amount,
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
    );
  }

  Widget _buildDeudaCard(BuildContext context, _Deuda deuda) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          // Texto enriquecido: "Guillermo debe a Enrique (yo)"
          // RichText permite mezclar estilos dentro de una misma línea
          RichText(
            textAlign: TextAlign.center,
            maxLines: 2,
            textScaler: MediaQuery.of(context).textScaler,
            text: TextSpan(
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: [
                TextSpan(
                  text: deuda.deudor,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: ' debe a '),
                TextSpan(
                  text: deuda.acreedor,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // Cantidad
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              deuda.cantidad,
              style: const TextStyle(
                  fontSize: 22, fontWeight: FontWeight.w600),
            ),
          ),

          // Botón confirmar pago
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFEE8B60),
                elevation: 2,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFEE8B60)),
                ),
              ),
              child: const Text('¡Está pagado!',
                  style: TextStyle(
                      fontSize: 18, color: Color(0xFFEE8B60))),
            ),
          ),
        ],
      ),
    );
  }
}