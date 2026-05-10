import 'package:flutter/material.dart';

class CollaborativeBalancesScreen extends StatelessWidget {
  const CollaborativeBalancesScreen({super.key});

  static const _miembros = [
    _Miembro(nombre: 'Enrique (Yo)', importe: '+ 30,00 €', positivo: true, borderColor: Color(0xFF7CD2B9)),
    _Miembro(nombre: 'Paco', importe: '- 40,00 €', positivo: false, borderColor: Color(0xFFEE8B60)),
    _Miembro(nombre: 'Felix', importe: '+ 10,00 €', positivo: true, borderColor: Color(0xFFEE8B60)),
  ];

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back, size: 40),
          Material(
            elevation: 1.2,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.info_outline_rounded, size: 38),
            ),
          ),
        ],
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
            child: Text('Saldos', style: TextStyle(fontSize: 28)),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Gestiona quién debe a quién de manera simple',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card "Te deben"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildTeDeben(),
                ),
                const SizedBox(height: 10),
                // Card "Saldo de integrantes fuera de la lista"
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildSaldoFuera(),
                ),
                const SizedBox(height: 10),
                // Label lista
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Saldos de los integrantes de la lista',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                // Lista miembros
                Expanded(
                  flex: 4,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: _miembros.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (_, i) => _buildMiembroCard(_miembros[i]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeDeben() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEE8B60), width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Icon(Icons.thumb_up, color: Color(0xFFEE8B60), size: 36),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text('Te deben', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(width: 5),
                    Text('30,00 €', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ],
                ),
                const Text(
                  'Consulta lo que te deben',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            flex: 1,
            child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 34),
          ),
        ],
      ),
    );
  }

  Widget _buildSaldoFuera() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEE8B60), width: 2),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Saldo de integrantes fuera de la lista'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Total por pagar', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                SizedBox(width: 10),
                Text('18,00 €', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Miembros restantes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                SizedBox(width: 10),
                Text('9', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          // Sub-card "Cada uno debe"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEE8B60), width: 2),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Text('Cada uno debe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                            SizedBox(width: 5),
                            Text('2,00 €', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const Text(
                          'Anota quienes han hecho ya su aportación',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 34),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiembroCard(_Miembro miembro) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: miembro.borderColor, width: 2),
      ),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          const SizedBox(width: 2),
          ClipOval(
            child: Image.network(
              'https://picsum.photos/seed/50/600',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                miembro.nombre,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: Text(
              miembro.importe,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: miembro.positivo ? Colors.green : Colors.red,
              ),
            ),
          ),
          const SizedBox(width: 2),
        ],
      ),
    );
  }
}

// — Modelos hardcodeados —

class _Miembro {
  final String nombre;
  final String importe;
  final bool positivo;
  final Color borderColor;

  const _Miembro({
    required this.nombre,
    required this.importe,
    required this.positivo,
    required this.borderColor,
  });
}