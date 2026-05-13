import 'package:flutter/material.dart';

class RegisteredProfileScreen extends StatelessWidget {
  const RegisteredProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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

                        // Avatar circular
                        Center(
                          child: ClipOval(
                            child: Image.network(
                              'https://picsum.photos/seed/390/600',
                              width: 80, height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),

                        const Text('Enrique Díaz',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 20),

                        // ── Tarjeta datos de cuenta ──────────────────
                        _buildCard(children: [
                          _buildInfoRow(label: 'ID',
                              value: 'dhjghdsghjdgsj2727',
                              editable: false),
                          _buildDivider(),
                          _buildInfoRow(label: 'Alias',
                              value: 'Enrique Díaz'),
                          _buildDivider(),
                          _buildInfoRow(label: 'Correo electrónico',
                              value: 'micorreodemail@gmail.com'),
                        ]),
                        const SizedBox(height: 30),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Preferencias',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(height: 5),

                        // ── Tarjeta preferencias ─────────────────────
                        _buildCard(children: [
                          _buildMenuRow('Notificaciones'),
                          _buildDivider(),
                          _buildMenuRow('Idioma'),
                          _buildDivider(),
                          _buildMenuRow('Modo oscuro'),
                        ]),
                        const SizedBox(height: 30),

                        // ── Botones ──────────────────────────────────
                        Center(
                          child: _buildOutlineButton(
                            label: 'Cerrar sesión',
                            textColor: const Color(0xFFEE8B60),
                            borderColor: const Color(0xFFEE8B60),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: _buildOutlineButton(
                            label: 'Eliminar perfil',
                            textColor: Colors.grey,
                            borderColor: Colors.transparent,
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(height: 30),

                        const Text('1.0.0',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300)),
                        const SizedBox(height: 20),
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

  // Contenedor con borde gris — reutilizado para datos y preferencias
  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 2),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          ...children,
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Fila con etiqueta pequeña + valor grande, con flecha opcional
  Widget _buildInfoRow({
    required String label,
    required String value,
    bool editable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w300)),
                const SizedBox(height: 2),
                Text(value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
          if (editable)
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
    );
  }

  // Fila simple con texto + flecha (para preferencias)
  Widget _buildMenuRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18)),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(thickness: 2, color: Colors.grey[200], height: 1);
  }

  Widget _buildOutlineButton({
    required String label,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: textColor,
          elevation: borderColor == Colors.transparent ? 0 : 2,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: textColor)),
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
          _buildNavItem(Icons.star_rounded, 'Notas'),
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
                color: color)),
      ],
    );
  }
}