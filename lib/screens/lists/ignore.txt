import 'package:flutter/material.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

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
      child: Stack(
        children: [
          // Lista de contenido
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Text(
                  'Listas activas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    _buildSectionDivider(context, 'Mis listas'),
                    _buildListCard(
                      color: const Color(0xFFFEAD28),
                      icon: Icons.restart_alt,
                      title: 'Gastos de casa de esos que tienen el nombre exageradamente largo y de',
                      subtitle1: '12 items',
                      subtitle2: '10 días para el cobro',
                    ),
                    _buildListCard(
                      color: const Color(0xFFFEAD28),
                      icon: Icons.restart_alt,
                      title: 'Gastos de otra casa',
                      subtitle1: '3 items',
                      subtitle2: 'DESACTIVADA',
                    ),
                    _buildListCard(
                      color: const Color(0xFFFE4370),
                      icon: Icons.groups_2,
                      title: 'Barbacoa',
                      subtitle1: '7 items',
                      subtitle2: '3 supermercados',
                    ),
                    _buildListCard(
                      color: const Color(0xFF0588FE),
                      icon: Icons.shopping_cart_outlined,
                      title: 'Compras de la semana',
                      subtitle1: '1 item',
                      subtitle2: 'SiSoloHay Una Tienda Se Pone El Nombre De La Misma',
                    ),
                    _buildSectionDivider(context, 'Nombre muy largo a ver que termina'),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'CREA LISTAS DE LA COMPRA, LISTAS COLABORATIVAS O GASTOS RECURRENTES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
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

          // Botón "+" flotante
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFFEE8B60),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 48),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionDivider(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
          // El texto del divisor tiene ancho máximo para no comerse la línea derecha
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.6,
            ),
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
            ),
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

  Widget _buildListCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle1,
    required String subtitle2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(icon, color: color, size: 80),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 5),
                      Text('- $subtitle1',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14)),
                      const SizedBox(height: 5),
                      Text('- $subtitle2',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.more_vert, size: 32),
              ),
            ],
          ),
        ),
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
          _buildNavItem(Icons.filter_list, 'Listas', active: true),
          _buildNavItem(Icons.money_off_csred, 'Pagos'),
          _buildNavItem(Icons.star_rounded, 'Notas'),
          _buildNavItem(Icons.flag_sharp, 'Scout'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool active = false}) {
    // El item activo usa el color naranja, los demás usan el color por defecto
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