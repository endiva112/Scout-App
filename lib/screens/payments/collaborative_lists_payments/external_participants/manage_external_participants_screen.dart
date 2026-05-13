import 'package:flutter/material.dart';

class GestionarPagosExternosScreen extends StatelessWidget {
  const GestionarPagosExternosScreen({super.key});

  // Lista de miembros hardcodeada — cuando conectes Firebase
  // esto vendrá de un stream/future y el ListView se generará dinámicamente
  static const List<String> _miembros = [
    'Integrante 1',
    'Integrante 2',
    'Markus',
    'El primo de Markus que conocimos aquel dia en la playa cuando nos fuimos de vacaciones',
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
              // Header: solo botón atrás, sin navbar
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
                    children: [
                      const SizedBox(height: 10),

                      // ── Tarjeta superior: progreso de pagos ────────
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: Colors.grey[300]!, width: 2),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text('Miembros por pagar',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(height: 10),

                              // Barra de progreso — sustituye LinearPercentIndicator
                              ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: LinearProgressIndicator(
                                  value: 0.7,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey[200],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFEE8B60)),
                                ),
                              ),
                              const SizedBox(height: 10),

                              // Contador "7 / 10"
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('7',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFEE8B60))),
                                  SizedBox(width: 5),
                                  Text('/ 10',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFEE8B60))),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Botones
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildButton(
                                    context,
                                    label: 'Registra pago',
                                    backgroundColor: Colors.white,
                                    textColor: const Color(0xFFEE8B60),
                                    borderColor: const Color(0xFFEE8B60),
                                    onPressed: () {},
                                  ),
                                  _buildButton(
                                    context,
                                    label: 'Todos han pagado',
                                    backgroundColor: const Color(0xFFEE8B60),
                                    textColor: Colors.white,
                                    borderColor: const Color(0xFFEE8B60),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ── Tarjeta inferior: lista de miembros ────────
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.grey[300]!, width: 2),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('Miembros abonados',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500)),
                                    Icon(Icons.draw_rounded, size: 32),
                                  ],
                                ),

                                // Separador punteado — sustituye StyledDivider
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8),
                                  child: CustomPaint(
                                    size: const Size(double.infinity, 2),
                                    painter: _DashedLinePainter(),
                                  ),
                                ),

                                // Lista de miembros generada desde la constante
                                // Cuando llegue Firebase, este map vendrá de un snapshot
                                Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.zero,
                                    itemCount: _miembros.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (context, index) =>
                                        _buildMemberRow(_miembros[index]),
                                  ),
                                ),
                              ],
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
      ),
    );
  }

  Widget _buildMemberRow(String name) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('-',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onPressed,
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
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor)),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 2;
    const dashWidth = 6.0;
    const dashSpace = 4.0;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x + dashWidth, 0), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}