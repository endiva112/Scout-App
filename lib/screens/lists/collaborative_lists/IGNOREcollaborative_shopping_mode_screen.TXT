import 'package:flutter/material.dart';

class CollaborativeShoppingModeScreen extends StatelessWidget {
  const CollaborativeShoppingModeScreen({super.key});

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
            children: [
              _buildHeaderIcon(Icons.attach_money_sharp),
              const SizedBox(width: 10),
              _buildHeaderIcon(Icons.event_note_rounded),
              const SizedBox(width: 10),
              _buildHeaderIcon(Icons.share),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Material(
      elevation: 1.2,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 38),
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
            child: Text(
              'Compras de la semana',
              style: TextStyle(fontSize: 28),
            ),
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
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 100),
              children: [
                _buildStoreCard(
                  label: 'Sin tienda asignada',
                  borderColor: Colors.grey.shade400,
                  items: const [
                    _Item(name: 'Patatas fritas', qty: ''),
                  ],
                ),
                const SizedBox(height: 10),
                _buildStoreCard(
                  label: 'Mercadona',
                  borderColor: Color(0xFFFEAD28),
                  items: const [
                    _Item(name: 'Zanahorias', qty: ''),
                    _Item(name: 'Coca Cola 2L', qty: '3 botellas', done: true),
                  ],
                ),
                const SizedBox(height: 10),
                _buildStoreCard(
                  label: 'Aldi',
                  borderColor: Colors.green,
                  items: const [
                    _Item(name: 'Rabanillos', qty: '4 Kg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard({
    required String label,
    required Color borderColor,
    required List<_Item> items,
  }) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label),
            const SizedBox(height: 2),
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0) _buildDottedDivider(),
              _buildItemRow(items[i]),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(_Item item) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: item.done ? Colors.grey : Colors.black,
                decoration: item.done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
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
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: item.done ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDottedDivider() {
    return Row(
      children: List.generate(
        40,
        (i) => Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 2,
            color: i.isEven ? Colors.grey[300] : Colors.transparent,
          ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFooterButton(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Finalizar compra', style: TextStyle(fontSize: 24)),
            ),
          ),
          _buildFooterButton(
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.draw, size: 40),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterButton({required Widget child}) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: child,
      ),
    );
  }
}

// — Modelo hardcodeado —

class _Item {
  final String name;
  final String qty;
  final bool done;

  const _Item({required this.name, required this.qty, this.done = false});
}