import 'package:flutter/material.dart';

class InfoCollaborativePurchaseScreen extends StatefulWidget {
  const InfoCollaborativePurchaseScreen({super.key});

  @override
  State<InfoCollaborativePurchaseScreen> createState() => _InfoCollaborativePurchaseScreenState();
}

class _InfoCollaborativePurchaseScreenState extends State<InfoCollaborativePurchaseScreen> {
  final _importeCtrl = TextEditingController(text: '32,65 €');

  static const _items = [
    _Item(name: 'Coca Cola 2L', qty: '3 botellas de las grandes, de esas que le gustan a tu hermano'),
    _Item(name: 'Zanahorias', qty: '4 Kg'),
    _Item(name: 'Item con un nombre muy largooooooooooooooooooooooooooooooooo para ver como se comportan los estilos de flutter.', qty: '1 gramo'),
    _Item(name: 'Item con un nombre muy largo para ver como se comportan los estilos de flutter.', qty: '2 unidades'),
    _Item(name: 'Rabanillos', qty: ''),
  ];

  static const _historial = [
    _HistorialEntry(actor: 'Enrique (Yo)', accion: 'modificó el precio, el ', fecha: 'Miércoles 22 Abril'),
    _HistorialEntry(actor: 'Paco Antonio Manuel de la Rosa', accion: 'modificó el precio, el ', fecha: 'Martes 21 Abril'),
    _HistorialEntry(actor: 'Paco Antonio Manuel de la Rosa', accion: 'modificó el precio, el ', fecha: 'Martes 21 Abril'),
    _HistorialEntry(actor: 'Mike', accion: 'eliminó la foto, el ', fecha: 'Martes 21 Abril'),
    _HistorialEntry(actor: 'Pedro', accion: 'agregó una foto, el ', fecha: 'Martes 21 Abril'),
  ];

  @override
  void dispose() {
    _importeCtrl.dispose();
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.arrow_back, size: 40),
          Row(
            children: const [
              Row(
                children: [
                  Icon(Icons.chevron_left_rounded, size: 40),
                  SizedBox(width: 5),
                  Icon(Icons.chevron_right_rounded, size: 40),
                ],
              ),
              SizedBox(width: 20),
              Icon(Icons.more_vert_rounded, size: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            // Título
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Compra 21 Abril probando un nombre largo para resaltar el comportamiento en textos largos limitar por codigo',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 28),
              ),
            ),
            const SizedBox(height: 10),
            // Historial
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _historial.map(_buildHistorialEntry).toList(),
            ),
            const SizedBox(height: 10),
            // Card items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildItemsCard(),
            ),
            const SizedBox(height: 10),
            // Card verde importe + recibo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _buildImporteCard(),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorialEntry(_HistorialEntry entry) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '${entry.actor} ',
              style: const TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
            ),
            TextSpan(text: entry.accion),
            TextSpan(
              text: entry.fecha,
              style: const TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsCard() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7CD2B9), width: 2),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            ..._items.expand((item) => [
                  _buildItemRow(item),
                  const SizedBox(height: 10),
                ]),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(_Item item) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            item.name,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 2,
          child: Text(
            item.qty,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildImporteCard() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFF7CD2B9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Text(
              'IMPORTE DE LA COMPRA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _importeCtrl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
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
            const SizedBox(height: 10),
            const Text(
              'RECIBO DE COMPRA',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            // Estado: con imagen
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.network(
                'https://picsum.photos/seed/62/600',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            _buildDarkButton('Cambiar imágen'),
            const SizedBox(height: 10),
            // Estado: sin imagen
            const Icon(Icons.image, size: 200),
            const SizedBox(height: 10),
            _buildDarkButton('Agregar imágen'),
          ],
        ),
      ),
    );
  }

  Widget _buildDarkButton(String label) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4E7566),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label),
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
          SizedBox(
            width: 200,
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Aplicar cambios'),
            ),
          ),
        ],
      ),
    );
  }
}

// — Modelos hardcodeados —

class _Item {
  final String name;
  final String qty;
  const _Item({required this.name, required this.qty});
}

class _HistorialEntry {
  final String actor;
  final String accion;
  final String fecha;
  const _HistorialEntry({required this.actor, required this.accion, required this.fecha});
}