import 'package:flutter/material.dart';

class CollaborativeExpensesScreen extends StatefulWidget {
  const CollaborativeExpensesScreen({super.key});

  @override
  State<CollaborativeExpensesScreen> createState() => _CollaborativeExpensesScreenState();
}

class _CollaborativeExpensesScreenState extends State<CollaborativeExpensesScreen> {
  final _personasCtrl = TextEditingController(text: '0');

  static const _grupos = [
    _GrupoGastos(
      fecha: 'Hoy',
      gastos: [
        _Gasto(
          titulo: 'Cubiertos y extras con un nombre largo',
          pagadoPor: 'Enrique (yo)',
          importe: '11,10 €',
          borderColor: Color(0xFF7CD2B9),
        ),
        _Gasto(
          titulo: 'Cubiertos y extras para que ocu',
          pagadoPor: 'Paco Nombre Muy pero que',
          importe: '111,10 €',
          borderColor: Color(0xFFD67A31),
        ),
      ],
    ),
    _GrupoGastos(
      fecha: '19 de abril de 2026',
      gastos: [
        _Gasto(
          titulo: 'Cubiertos y extras para que ocu',
          pagadoPor: 'Paco Nombre Muy pero que',
          importe: '111,10 €',
          borderColor: Color(0xFFD67A31),
        ),
      ],
    ),
  ];

  @override
  void dispose() {
    _personasCtrl.dispose();
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
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Row(
        children: [Icon(Icons.arrow_back, size: 40)],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text('Gastos', style: TextStyle(fontSize: 28)),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Historial de gastos relacionados con esta lista',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildResumenCard(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildPersonasCard(),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
              children: [
                for (int i = 0; i < _grupos.length; i++) ...[
                  if (i > 0) const SizedBox(height: 10),
                  _buildGrupoGastos(_grupos[i]),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumenCard() {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(child: _buildResumenItem('Mis Gastos', '2.061.111,23 €')),
            Expanded(child: _buildResumenItem('Gastos Totales', '2.062.333,53 €')),
          ],
        ),
      ),
    );
  }

  Widget _buildResumenItem(String label, String importe) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Text(importe, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildPersonasCard() {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                'Número de personas adicionales',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: TextField(
                controller: _personasCtrl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  isDense: true,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrupoGastos(_GrupoGastos grupo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            grupo.fecha,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        for (final gasto in grupo.gastos)
          Padding(
            padding: const EdgeInsets.all(10),
            child: _buildGastoCard(gasto),
          ),
      ],
    );
  }

  Widget _buildGastoCard(_Gasto gasto) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: gasto.borderColor, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gasto.titulo,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Row(
                    children: [
                      const Text('Pagado por '),
                      Expanded(
                        child: Text(
                          gasto.pagadoPor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                gasto.importe,
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              constraints: const BoxConstraints(minHeight: 50),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Gestionar saldos',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// — Modelos hardcodeados —

class _Gasto {
  final String titulo;
  final String pagadoPor;
  final String importe;
  final Color borderColor;

  const _Gasto({
    required this.titulo,
    required this.pagadoPor,
    required this.importe,
    required this.borderColor,
  });
}

class _GrupoGastos {
  final String fecha;
  final List<_Gasto> gastos;

  const _GrupoGastos({required this.fecha, required this.gastos});
}