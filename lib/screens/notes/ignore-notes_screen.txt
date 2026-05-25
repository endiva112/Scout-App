import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

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

  Widget _buildBody() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
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

          // Contenido
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: Text(
                  'Mis notas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 100),
                  children: [
                    _buildNoteCard(
                      icon: Icons.cake_rounded,
                      title: 'Regalos para Alex',
                      date: '9 Mayo 2026',
                    ),
                    _buildNoteCard(
                      icon: Icons.phone_sharp,
                      title: 'Compañias teléfono',
                      date: '4 Abril 2026',
                    ),
                    _buildNoteCard(
                      icon: Icons.work_rounded,
                      title: 'Compras para Empresas Tanaka',
                      date: '3 Abril 2020',
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'CREA Y GESTIONA FÁCILMENTE COMPARACIONES DE PRECIO O LISTAS DE DESEADOS',
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
        ],
      ),
    );
  }

  Widget _buildNoteCard({
    required IconData icon,
    required String title,
    required String date,
  }) {
    // En FlutterFlow estas tarjetas usan "alternate" y "accent3",
    // que en el tema por defecto son grises claros.
    // Usamos grey[200] para el fondo y grey[400] para el borde,
    // que es el equivalente visual más cercano.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[400]!, width: 2),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Icon(icon, size: 60),
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
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(date, maxLines: 1, overflow: TextOverflow.ellipsis),
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

  Widget _buildBottomNav() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.filter_list, 'Listas'),
          _buildNavItem(Icons.money_off_csred, 'Pagos'),
          _buildNavItem(Icons.star_rounded, 'Notas', active: true),
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