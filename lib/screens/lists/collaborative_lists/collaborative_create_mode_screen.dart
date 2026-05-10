import 'package:flutter/material.dart';

class CollaborativeCreateModeScreen extends StatefulWidget {
  const CollaborativeCreateModeScreen({super.key});

  @override
  State<CollaborativeCreateModeScreen> createState() =>
      _CollaborativeCreateModeScreenState();
}

class _CollaborativeCreateModeScreenState
    extends State<CollaborativeCreateModeScreen> {
  // Cada store tiene: label, color de borde, y lista de items
  // Cada item tiene: nameController, qtyController, lockState
  final List<_StoreData> _stores = [
    _StoreData(
      label: 'Sin tienda asignada',
      borderColor: Colors.grey,
      items: [
        _ItemData(name: 'Patatas fritas', qty: '.', lock: _LockState.hidden),
      ],
    ),
    _StoreData(
      label: 'Mercadona',
      borderColor: Color(0xFFFEAD28),
      items: [
        _ItemData(name: 'Zanahorias', qty: '.', lock: _LockState.hidden),
        _ItemData(name: 'Coca Cola 2L, test de como se comportan textos largos', qty: '3 botellas', lock: _LockState.hidden),
        _ItemData(name: 'Salchichas', qty: '2 paquetes', lock: _LockState.visible),
      ],
    ),
    _StoreData(
      label: 'Aldi',
      borderColor: Colors.green,
      items: [
        _ItemData(name: 'Rabanillos', qty: '4 Kg', lock: _LockState.hidden),
      ],
    ),
  ];

  @override
  void dispose() {
    for (final store in _stores) {
      for (final item in store.items) {
        item.nameCtrl.dispose();
        item.qtyCtrl.dispose();
      }
    }
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
            children: [
              _buildHeaderIcon(Icons.attach_money_sharp),
              const SizedBox(width: 10),
              _buildHeaderIcon(Icons.event_note_rounded),
              const SizedBox(width: 10),
              _buildHeaderIcon(Icons.person),
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
                ..._stores.map((store) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _buildStoreCard(store),
                    )),
                _buildAddStoreCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreCard(_StoreData store) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: store.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(store.label),
            const SizedBox(height: 2),
            for (int i = 0; i < store.items.length; i++) ...[
              if (i > 0) _buildDottedDivider(),
              _buildItemRow(store.items[i]),
            ],
            const SizedBox(height: 10),
            _buildAddElementButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(_ItemData item) {
    return Row(
      children: [
        Icon(
          Icons.lock,
          size: 24,
          color: item.lock == _LockState.visible
              ? Colors.grey
              : Colors.transparent,
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 4,
          child: _buildTextField(item.nameCtrl, fillColor: Colors.white),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 2,
          child: _buildTextField(
            item.qtyCtrl,
            fillColor: Colors.grey[100]!,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller, {
    required Color fillColor,
    TextAlign textAlign = TextAlign.start,
  }) {
    return TextField(
      controller: controller,
      maxLines: null,
      textAlign: textAlign,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildDottedDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
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
      ),
    );
  }

  Widget _buildAddElementButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'AGREGAR OTRO ELEMENTO',
          style: TextStyle(fontWeight: FontWeight.w600, color: Color(0x8A57636C)),
        ),
      ),
    );
  }

  Widget _buildAddStoreCard() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 2),
        ),
        child: const Center(
          child: Text(
            'Agregar tienda',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
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
          _buildFooterOrganizar(),
          _buildFooterIconButton(Icons.shopping_cart_checkout),
        ],
      ),
    );
  }

  Widget _buildFooterOrganizar() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.settings_sharp, size: 40),
            ),
            Container(width: 1, height: 50, color: Colors.grey),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Organizar', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIconButton(IconData icon) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 40),
      ),
    );
  }
}

// — Modelos de datos hardcodeados —

enum _LockState { hidden, visible }

class _ItemData {
  final TextEditingController nameCtrl;
  final TextEditingController qtyCtrl;
  final _LockState lock;

  _ItemData({
    required String name,
    required String qty,
    required this.lock,
  })  : nameCtrl = TextEditingController(text: name),
        qtyCtrl = TextEditingController(text: qty);
}

class _StoreData {
  final String label;
  final Color borderColor;
  final List<_ItemData> items;

  const _StoreData({
    required this.label,
    required this.borderColor,
    required this.items,
  });
}