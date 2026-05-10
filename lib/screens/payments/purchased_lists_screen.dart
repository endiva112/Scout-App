import 'package:flutter/material.dart';

class PurchasedListsScreen extends StatelessWidget {
  const PurchasedListsScreen({super.key});

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
              Expanded(child: _buildBody(context)),
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
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
            child: Text(
              'Listas por pagar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),

          // Saldo estimado
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Saldo estimado:', style: TextStyle(fontSize: 18)),
              SizedBox(width: 10),
              Text(
                '- 20€',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),

          // Separador punteado — sustituye al StyledDivider de FlutterFlow
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: CustomPaint(painter: _DashedLinePainter()),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 150),
              children: [
                // Tarjetas activas
                _buildPaymentCard(
                  color: const Color(0xFFFEAD28),
                  icon: Icons.restart_alt,
                  title: 'Gastos de casa',
                  date: '30 de Junio',
                  statusLabel: 'Abonado: 24 Ago',
                  amount: '- 30 €',
                  amountColor: Colors.red,
                ),
                _buildPaymentCard(
                  color: const Color(0xFFFEAD28),
                  icon: Icons.restart_alt,
                  title: 'Gastos de casa',
                  date: '31 de Julio',
                  statusLabel: 'Cargo: 31 Julio',
                  amount: 'POR ABONAR!',
                  amountColor: Colors.red,
                ),
                _buildPaymentCard(
                  color: const Color(0xFFFE4370),
                  icon: Icons.groups_2,
                  title: 'Barbacoa',
                  statusLabel: 'Comprado: 24 Ago',
                  amount: '+ 10 €',
                  amountColor: Colors.green,
                ),

                // Separador historial
                _buildSectionDivider(context, 'Historial (pagados)'),

                // Tarjeta pagada (fondo gris, sin color de acento)
                _buildPaymentCard(
                  color: Colors.grey[300]!,
                  icon: Icons.groups_2,
                  title: 'Fiesta en la piscina',
                  statusLabel: 'Comprado: 14 Ago',
                  amount: 'PAGADO',
                  amountColor: Colors.grey,
                  paid: true,
                ),

                // Textos informativos al fondo
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    'PARECE QUE NO QUEDAN LISTAS POR PAGAR',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text(
                    'INICIA SESIÓN PARA PODER CREAR LISTAS COLABORATIVAS Y REPARTIR LOS GASTOS FÁCILMENTE',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ),
              ].map((w) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: w,
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({
    required Color color,
    required IconData icon,
    required String title,
    String? date,
    required String statusLabel,
    required String amount,
    required Color amountColor,
    bool paid = false,
  }) {
    // Las tarjetas pagadas tienen fondo gris, las activas fondo blanco con borde de color
    final cardColor = paid ? Colors.grey[200]! : Colors.white;
    final textColor = paid ? Colors.grey : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: paid ? 1 : 2),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Icon(icon, color: color, size: 60),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // Fecha opcional (solo algunas tarjetas la tienen)
                      if (date != null) ...[
                        Text(date, style: TextStyle(color: textColor)),
                        const SizedBox(height: 5),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            statusLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: textColor),
                          ),
                          Text(
                            amount,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: amountColor,
                            ),
                          ),
                        ],
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

  Widget _buildSectionDivider(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
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
          _buildNavItem(Icons.money_off_csred, 'Pagos', active: true),
          _buildNavItem(Icons.star_rounded, 'Notas'),
          _buildNavItem(Icons.flag_sharp, 'Scout'),
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
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w300,
              color: color,
            )),
      ],
    );
  }
}

// Sustituye al paquete styled_divider — dibuja una línea punteada simple
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