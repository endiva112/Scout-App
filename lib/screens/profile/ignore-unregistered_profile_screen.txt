import 'package:flutter/material.dart';

class UnregisteredProfileScreen extends StatelessWidget {
  const UnregisteredProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Perfil', style: TextStyle(fontSize: 20)),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        // Avatar
                        ClipOval(
                          child: Image.network(
                            'https://picsum.photos/seed/390/600',
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.width * 0.2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Entrar',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Guarda tus listas en la nube y llevatelas a cualquier dispositivo de manera fácil.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Botón Google
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://picsum.photos/seed/703/600',
                                height: MediaQuery.of(context).size.height * 0.04,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Inicia sesión con Google',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Preferencias label
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Preferencias',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Preferencias card
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300, width: 2),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              _buildPreferenciasRow('Idioma'),
                              Divider(thickness: 2, color: Colors.grey[300]),
                              _buildPreferenciasRow('Modo oscuro'),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          '1.0.0',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildBottomNav(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenciasRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.filter_list, 'Listas'),
          _buildNavItem(Icons.money_off_csred, 'Pagos'),
          _buildNavItem(Icons.star_rounded, 'Notas'),
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