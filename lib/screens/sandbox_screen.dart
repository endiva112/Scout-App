import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SandboxScreen extends StatefulWidget {
  const SandboxScreen({super.key});

  @override
  State<SandboxScreen> createState() => _SandboxScreenState();
}

class _SandboxScreenState extends State<SandboxScreen> {
  // Referencia al documento en Firestore donde guardaremos el texto
  // 'sandbox' es la colección, 'documento_compartido' es el ID del documento
  final _docRef = FirebaseFirestore.instance
      .collection('sandbox')
      .doc('documento_compartido');

  final _controller = TextEditingController();

  // Para evitar que el stream sobreescriba lo que el usuario
  // está escribiendo en este momento
  bool _estaEditando = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Sube el texto a Firestore cada vez que el usuario escribe
  void _onTextoChanged(String valor) {
    _estaEditando = true;
    _docRef.set({'texto': valor});

    // Tras un breve delay, volvemos a escuchar el stream
    Future.delayed(const Duration(milliseconds: 500), () {
      _estaEditando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox Firebase')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // StreamBuilder escucha cambios en tiempo real del documento
            // Cada vez que alguien edita, este widget se reconstruye
            StreamBuilder<DocumentSnapshot>(
              stream: _docRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && !_estaEditando) {
                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  final textoRemoto = data?['texto'] ?? '';

                  // Solo actualizamos el campo si el texto es distinto
                  // para no mover el cursor mientras escribes
                  if (_controller.text != textoRemoto) {
                    _controller.text = textoRemoto;
                    // Mueve el cursor al final del texto
                    _controller.selection = TextSelection.collapsed(
                      offset: _controller.text.length,
                    );
                  }
                }

                return TextField(
                  controller: _controller,
                  onChanged: _onTextoChanged,
                  maxLines: null, // permite múltiples líneas
                  decoration: const InputDecoration(
                    hintText: 'Escribe algo... verás los cambios en tiempo real',
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}