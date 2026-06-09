import 'package:flutter/material.dart';

// ── Colores ───────────────────────────────────────────────────────────────────
class _AppColors {
  static const background    = Color(0xFFF1F4F8); // primaryBackground
  static const surface       = Colors.white;       // secondaryBackground
  static const textPrimary   = Color(0xFF14181B);
  static const textSecondary = Color(0xFF57636C);
  static const accent        = Color(0xFF7CD2B9);
  static const accentDark    = Color(0xFF4E7566);
  //static const error         = Color(0xFFFF5963);
}

// ── Widget principal ──────────────────────────────────────────────────────────
class AbonarGastoPage extends StatefulWidget {
  const AbonarGastoPage({super.key});

  @override
  State<AbonarGastoPage> createState() => _AbonarGastoPageState();
}

class _AbonarGastoPageState extends State<AbonarGastoPage> {
  final _importeController = TextEditingController(text: '32,65 €');

  // Simula si ya hay imagen subida o no
  final bool _tieneImagen = true;

  @override
  void dispose() {
    _importeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _AppColors.surface,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(),
              Expanded(child: _buildBody()),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Top bar ────────────────────────────────────────────────────────────────
  Widget _buildTopBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Icon(Icons.arrow_back, size: 40, color: _AppColors.textPrimary),
      ),
    );
  }

  // ── Cuerpo ─────────────────────────────────────────────────────────────────
  Widget _buildBody() {
    return Container(
      color: _AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            const Text(
              'Luz y agua',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 28, color: _AppColors.textPrimary),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Agrega el importe de este coste y agrega una imágen para justificarlo ante tus colaboradores',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: _AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Tarjeta verde
            Material(
              color: Colors.transparent,
              elevation: 5,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  color: _AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // Importe
                    const Text(
                      'IMPORTE DEL ABONO',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: _AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _importeController,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _AppColors.textSecondary,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: _AppColors.background,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Recibo
                    const Text(
                      'RECIBO DE COMPRA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: _AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Estado: con imagen
                    if (_tieneImagen) ...[
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
                      _buildBotonImagen('Cambiar imágen'),
                    ],

                    // Estado: sin imagen
                    if (!_tieneImagen) ...[
                      const Icon(Icons.image, size: 200, color: _AppColors.textPrimary),
                      const SizedBox(height: 10),
                      _buildBotonImagen('Agregar imágen'),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildBotonImagen(String label) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: _AppColors.accentDark,
          foregroundColor: _AppColors.background,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label),
      ),
    );
  }

  // ── Bottom bar ─────────────────────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      constraints: const BoxConstraints(minHeight: 70),
      color: _AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _AppColors.accentDark,
              foregroundColor: _AppColors.background,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Importe pagado'),
          ),
        ),
      ),
    );
  }
}