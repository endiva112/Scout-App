import 'package:flutter/material.dart';

// Modelo de datos para cada entrada del historial
class _EntradaHistorial {
  final String autor;
  final String accion;
  final String fecha;

  const _EntradaHistorial({
    required this.autor,
    required this.accion,
    required this.fecha,
  });
}

class InfoAbonoScreen extends StatefulWidget {
  const InfoAbonoScreen({super.key});

  @override
  State<InfoAbonoScreen> createState() => _InfoAbonoScreenState();
}

class _InfoAbonoScreenState extends State<InfoAbonoScreen> {
  final _importeController = TextEditingController(text: '32,65 €');

  // Controla si hay imagen de recibo o no
  // Cuando conectes Firebase esto vendrá del documento
  bool _tieneImagen = true;

  static const List<_EntradaHistorial> _historial = [
    _EntradaHistorial(autor: 'Enrique (Yo)',                     accion: 'modificó el precio, el',  fecha: 'Miércoles 22 Abril'),
    _EntradaHistorial(autor: 'Paco Antonio Manuel de la Rosa',   accion: 'modificó el precio, el',  fecha: 'Martes 21 Abril'),
    _EntradaHistorial(autor: 'Paco Antonio Manuel de la Rosa',   accion: 'modificó el precio, el',  fecha: 'Martes 21 Abril'),
    _EntradaHistorial(autor: 'Mike',                             accion: 'eliminó la foto, el',     fecha: 'Martes 21 Abril'),
    _EntradaHistorial(autor: 'Pedro',                            accion: 'agregó una foto, el',     fecha: 'Martes 21 Abril'),
  ];

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
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──────────────────────────────────────────
              Container(
                constraints: const BoxConstraints(minHeight: 70),
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back, size: 40),
                    ),
                    Row(
                      children: [
                        // Navegación entre abonos anterior/siguiente
                        Row(
                          children: const [
                            Icon(Icons.chevron_left_rounded, size: 40),
                            Icon(Icons.chevron_right_rounded, size: 40),
                          ],
                        ),
                        const SizedBox(width: 20),
                        const Icon(Icons.more_vert_rounded, size: 40),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Cuerpo ──────────────────────────────────────────
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 10),

                        // Título
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text('Luz y agua',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 28)),
                        ),
                        const SizedBox(height: 10),

                        // Historial de cambios generado desde la lista
                        ...List.generate(_historial.length, (i) {
                          final e = _historial[i];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: '${e.autor} ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  TextSpan(text: '${e.accion} '),
                                  TextSpan(
                                    text: e.fecha,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 10),

                        // ── Tarjeta verde: importe + recibo ────────
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF7CD2B9),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const Text('IMPORTE DE LA COMPRA',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 10),

                                  // Campo importe editable
                                  TextField(
                                    controller: _importeController,
                                    textAlign: TextAlign.center,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[600]),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  const Text('RECIBO DE COMPRA',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 10),

                                  // Imagen o placeholder según estado
                                  if (_tieneImagen) ...[
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(24),
                                      child: Image.network(
                                        'https://picsum.photos/seed/62/600',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    _buildImageButton(
                                      label: 'Cambiar imagen',
                                      onPressed: () {
                                        // aquí irá image_picker
                                      },
                                    ),
                                  ] else ...[
                                    const Icon(Icons.image, size: 200),
                                    const SizedBox(height: 10),
                                    _buildImageButton(
                                      label: 'Agregar imagen',
                                      onPressed: () {
                                        // aquí irá image_picker
                                        setState(() => _tieneImagen = true);
                                      },
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              // ── Footer: botón aplicar cambios ───────────────────
              Container(
                constraints: const BoxConstraints(minHeight: 70),
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                child: Center(
                  child: SizedBox(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Aplicar cambios'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageButton({
    required String label,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 200,
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4E7566),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label),
      ),
    );
  }
}