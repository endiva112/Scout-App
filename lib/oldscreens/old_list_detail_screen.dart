import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OldListDetailScreen extends StatefulWidget {
  final String listId;
  const OldListDetailScreen({super.key, required this.listId});

  @override
  State<OldListDetailScreen> createState() => _OldListDetailScreenState();
}

class _OldListDetailScreenState extends State<OldListDetailScreen> {
  late final DocumentReference _docRef;
  final _textoController = TextEditingController();
  final _colaboradorController = TextEditingController();
  bool _estaEditando = false;

  @override
  void initState() {
    super.initState();
    _docRef = FirebaseFirestore.instance.collection('lists').doc(widget.listId);
  }

  @override
  void dispose() {
    _textoController.dispose();
    _colaboradorController.dispose();
    super.dispose();
  }

  // Igual que tu sandbox: sube el texto cada vez que el usuario escribe
  void _onTextoChanged(String valor) {
    _estaEditando = true;
    _docRef.update({'texto': valor});
    Future.delayed(const Duration(milliseconds: 500), () {
      _estaEditando = false;
    });
  }

  // Añade un uid al array collaboratorIds usando arrayUnion.
  // arrayUnion evita duplicados automáticamente.
  Future<void> _anadirColaborador() async {
    final nuevoUid = _colaboradorController.text.trim();
    if (nuevoUid.isEmpty) return;

    await _docRef.update({
      'collaboratorIds': FieldValue.arrayUnion([nuevoUid]),
    });

    _colaboradorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final miUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: Text('Lista: ${widget.listId}')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _docRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Lista no encontrada.'));
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final colaboradores = List<String>.from(data['collaboratorIds'] ?? []);

          // Sincroniza el texto remoto con el campo local
          // (mismo patrón que tu sandbox original)
          if (!_estaEditando) {
            final textoRemoto = data['texto'] ?? '';
            if (_textoController.text != textoRemoto) {
              _textoController.text = textoRemoto;
              _textoController.selection = TextSelection.collapsed(
                offset: _textoController.text.length,
              );
            }
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                // ── Info de debug, visible para entender el estado ──────────
                Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.amber.shade100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('DEBUG', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('listId: ${widget.listId}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                      Text('miUid: $miUid', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                      Text('owner: ${data['ownerUid']}', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                      Text('colaboradores:', style: const TextStyle(fontFamily: 'monospace', fontSize: 11)),
                      ...colaboradores.map((c) => Text(
                        '  - $c${c == miUid ? " (tú)" : ""}',
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                      )),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── El mismo sandbox de texto que ya conoces ─────────────────
                TextField(
                  controller: _textoController,
                  onChanged: _onTextoChanged,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Escribe algo... se sincroniza en tiempo real',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),

                // ── Añadir colaborador por UID ───────────────────────────────
                const Text('Añadir colaborador (pega su UID):'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _colaboradorController,
                        decoration: const InputDecoration(
                          hintText: 'UID del otro usuario',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _anadirColaborador,
                      child: const Text('Añadir'),
                    ),
                  ],
                ),

                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.go('/lists'),
                  child: const Text('Volver a mis listas'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}