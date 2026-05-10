import 'package:flutter/material.dart';

// Convertido de FlutterFlow a Flutter puro.
// StatelessWidget porque de momento no tenemos lógica de estado.
class MainListScreen extends StatelessWidget {
  const MainListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Cierra el teclado si tocas fuera de un campo de texto
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── CABECERA ────────────────────────────────────────
              _buildHeader(),

              // ── CONTENIDO PRINCIPAL ─────────────────────────────
              Expanded(
                child: Container(
                  color: Colors.white, // ← aquí sí blanco
                  child: _buildBody(context),
                ),
              ),
              // ── BARRA DE NAVEGACIÓN INFERIOR ────────────────────
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  // Separamos cada sección en su propio método para que sea más legible
  Widget _buildHeader() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Saludo y nombre de usuario
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Buenas tardes!', style: TextStyle(fontSize: 14)),
              Text('Scout001', style: TextStyle(fontSize: 14)),
            ],
          ),
          // Avatar circular
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
    return Stack(
      children: [
        // Botón "+" flotante abajo centrado
        const Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Center(
            child: _AddButton(),
          ),
        ),

        // Lista de contenido encima
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título de sección
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Text(
                'Listas activas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),

            // Lista scrolleable
            Expanded(
              child: ListView(
                // Padding abajo para que el botón "+" no tape el último item
                padding: const EdgeInsets.only(bottom: 100),
                children: [
                  // ── Separador "Mis listas" ──
                  _buildSectionDivider(context, 'Mis listas'),

                  // ── Tarjetas de lista ──
                  _buildListCard(
                    color: const Color(0xFFFEAD28),
                    icon: Icons.timer_sharp,
                    title: 'Compras de la semana',
                    subtitle1: '12 items',
                    subtitle2: 'Mercadona & Lidl',
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
                    subtitle2: 'LaTiendaConElNombreLar...',
                  ),

                  // ── Separadores de contactos compartidos ──
                  _buildSectionDivider(context, 'Alex (mi Brother)'),
                  _buildSectionDivider(context, 'Tía Paola'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Devuelve una fila con línea + texto + línea (el divisor de sección)
  Widget _buildSectionDivider(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        children: [
          // Línea pequeña a la izquierda
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
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 10),
          // Línea que ocupa el resto
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

  // Cada tarjeta de lista con icono, título, subtítulos y menú
  Widget _buildListCard({
    required Color color,
    required IconData icon,
    required String title,
    required String subtitle1,
    required String subtitle2,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            // Icono grande a la izquierda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(icon, color: Colors.white, size: 80),
            ),

            // Textos en el centro
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('- $subtitle1',
                        style: const TextStyle(color: Colors.white, fontSize: 14)),
                    const SizedBox(height: 5),
                    Text('- $subtitle2',
                        style: const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),

            // Menú "tres puntos" a la derecha
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.more_vert, color: Colors.white, size: 32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.filter_list, 'Listas'),
          _buildNavItem(Icons.money_off_csred, 'Gastos'),
          _buildNavItem(Icons.star_rounded, 'Deseados'),
          _buildNavItem(Icons.flag_sharp, 'Scout'),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 32),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
      ],
    );
  }
}

// Botón "+" separado en su propio widget (buena práctica)
class _AddButton extends StatelessWidget {
  const _AddButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        // Usamos el color del tema en lugar de hardcoded
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 48),
    );
  }
}