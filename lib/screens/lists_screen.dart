import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  Future<void> _crearLista(String uid) async {
    // Crea un documento nuevo en la colección 'lists'.
    // El uid del creador va en ownerUid y también en collaboratorIds,
    // para que su propia query (.where arrayContains) lo devuelva.
    await FirebaseFirestore.instance.collection('lists').add({
      'title': 'Lista ${DateTime.now().millisecondsSinceEpoch}',
      'ownerUid': uid,
      'collaboratorIds': [uid],
      'texto': '',
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis listas')),
      body: Column(
        children: [

          // ── UID propio, visible siempre para copiar/pegar en otra demo ──
          Container(
            width: double.infinity,
            color: Colors.amber.shade100,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TU UID:', style: TextStyle(fontWeight: FontWeight.bold)),
                SelectableText(uid, style: const TextStyle(fontFamily: 'monospace')),
              ],
            ),
          ),

          // ── Lista de listas en tiempo real ──────────────────────────────
          // La query filtra por collaboratorIds arrayContains uid.
          // Cuando alguien te añade como colaborador, este StreamBuilder
          // se reconstruye y la nueva lista aparece automáticamente.
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('lists')
                  .where('collaboratorIds', arrayContains: uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data?.docs ?? [];

                if (docs.isEmpty) {
                  return const Center(child: Text('No tienes listas todavía.'));
                }

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, i) {
                    final doc = docs[i];
                    final data = doc.data() as Map<String, dynamic>;
                    final esOwner = data['ownerUid'] == uid;

                    return ListTile(
                      title: Text(data['title'] ?? '(sin título)'),
                      subtitle: Text(
                        'ID: ${doc.id}\n'
                        'Owner: ${esOwner ? "tú" : data['ownerUid']}\n'
                        'Colaboradores: ${(data['collaboratorIds'] as List).join(', ')}',
                        style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                      // Navega a la pantalla de detalle pasando el listId
                      onTap: () => context.go('/list/${doc.id}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _crearLista(uid),
        child: const Icon(Icons.add),
      ),
    );
  }
}