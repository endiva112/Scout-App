import 'package:flutter/material.dart';

class SimplePlanningModeScreen extends StatefulWidget {
  const SimplePlanningModeScreen({super.key});

  @override
  State<SimplePlanningModeScreen> createState() =>
      _SimplePlanningModeScreenState();
}

class _SimplePlanningModeScreenState
    extends State<SimplePlanningModeScreen> {
  // Controllers: índices pares = nombre, índices impares = cantidad
  final _items = [
    TextEditingController(text: 'Patatas fritas'),
    TextEditingController(text: '.'),
    TextEditingController(text: 'Zanahorias'),
    TextEditingController(text: '.'),
    TextEditingController(text: 'Coca Cola 2L'),
    TextEditingController(text: '3 botellas'),
    TextEditingController(text: 'Rabanillos'),
    TextEditingController(text: '4 Kg'),
  ];

  @override
  void dispose() {
    for (final c in _items) {
      c.dispose();
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
          Material(
            elevation: 1.2,
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(Icons.event_note_rounded, size: 38),
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
                  nameController: _items[0],
                  qtyController: _items[1],
                  showDivider: false,
                ),
                const SizedBox(height: 10),
                _buildStoreCard(
                  label: 'Mercadona',
                  borderColor: const Color(0xFFFEAD28),
                  nameController: _items[2],
                  qtyController: _items[3],
                  extraNameController: _items[4],
                  extraQtyController: _items[5],
                  showDivider: true,
                ),
                const SizedBox(height: 10),
                _buildStoreCard(
                  label: 'Aldi',
                  borderColor: Colors.green,
                  nameController: _items[6],
                  qtyController: _items[7],
                  showDivider: false,
                ),
                const SizedBox(height: 10),
                _buildAddStoreCard(),
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
    required TextEditingController nameController,
    required TextEditingController qtyController,
    TextEditingController? extraNameController,
    TextEditingController? extraQtyController,
    required bool showDivider,
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
            _buildItemRow(nameController, qtyController),
            if (showDivider && extraNameController != null) ...[
              const SizedBox(height: 2),
              _buildDottedDivider(),
              const SizedBox(height: 2),
              _buildItemRow(extraNameController, extraQtyController!),
            ],
            const SizedBox(height: 10),
            _buildAddElementButton(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(
      TextEditingController nameCtrl, TextEditingController qtyCtrl) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: _buildTextField(nameCtrl, fillColor: Colors.white),
        ),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: _buildTextField(qtyCtrl, fillColor: Colors.grey[100]!),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller,
      {required Color fillColor}) {
    return TextField(
      controller: controller,
      maxLines: null,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
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
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0x8A57636C),
          ),
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
          _buildFooterButton(
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
          _buildFooterButton(
            child: const Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.shopping_cart_checkout, size: 40),
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