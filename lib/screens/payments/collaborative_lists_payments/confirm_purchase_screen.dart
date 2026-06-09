import 'package:flutter/material.dart';

class ConfirmPurchaseScreen extends StatefulWidget {
  const ConfirmPurchaseScreen({super.key});

  @override
  State<ConfirmPurchaseScreen> createState() =>
      _ConfirmPurchaseScreenState();
}

class _ConfirmPurchaseScreenState extends State<ConfirmPurchaseScreen> {
  final _descCtrl = TextEditingController(text: 'Compra 21 Abril...');
  final _importeCtrl = TextEditingController(text: 'IMPORTE');

  static const _items = [
    _Item(name: 'Coca Cola 2L', qty: '3 botellas'),
    _Item(name: 'Zanahorias', qty: '4 Kg'),
    _Item(name: 'Item con un nombre muy largo para ver como se comportan los estilos de flutter.', qty: '2 unidades'),
    _Item(name: 'Item con un nombre muy largo para ver como se comportan los estilos de flutter.', qty: ''),
    _Item(name: 'Rabanillos', qty: ''),
  ];

  @override
  void dispose() {
    _descCtrl.dispose();
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
            child: Text('Liquidación', style: TextStyle(fontSize: 28)),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Lunes 21 Abril 14:44',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(flex: 4, child: _buildItemsCard()),
                  const SizedBox(height: 10),
                  Expanded(flex: 2, child: _buildLiquidacionCard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsCard() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF7CD2B9), width: 2),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
          children: _items.map(_buildItemRow).toList(),
        ),
      ),
    );
  }

  Widget _buildItemRow(_Item item) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Text(
                item.name,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                item.qty,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiquidacionCard() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF7CD2B9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Descripción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildGreenTextField(_descCtrl),
            ),
            const SizedBox(height: 10),
            // Importe + cámara
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: _buildGreenTextField(_importeCtrl),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: _buildDarkButton(
                      child: const Icon(
                        Icons.photo_camera_sharp,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Botón compra terminada
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildDarkButton(
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Compra terminada',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildGreenTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
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
    );
  }

  Widget _buildDarkButton({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4E7566),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}

class _Item {
  final String name;
  final String qty;
  const _Item({required this.name, required this.qty});
}