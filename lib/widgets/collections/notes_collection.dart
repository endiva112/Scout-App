import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/repositories/note_repository.dart';
import 'package:scout_app/models/note.dart';
import 'package:scout_app/widgets/cards/note_card.dart';
import 'package:scout_app/widgets/common/default_tip_text.dart';

class NotesCollection extends StatefulWidget {
  const NotesCollection({super.key});

  @override
  State<NotesCollection> createState() => _NotesCollectionState();
}

class _NotesCollectionState extends State<NotesCollection> {
  final _repository = NoteRepository();
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  bool _cleaning = true;

  @override
  void initState() {
    super.initState();
    _cleanOnLoad();
  }

  Future<void> _cleanOnLoad() async {
    final notes = await _repository.getNotes(_userId).first;
    _cleanEmptyNotes(notes);
    if (!mounted) return;
    setState(() => _cleaning = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_cleaning) return const Center(child: CircularProgressIndicator());

    return StreamBuilder<List<Note>>(
      stream: _repository.getNotes(_userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const DefaultTipText(
            tip: 'PARECE QUE ALGO SALIO MAL [ERROR EN LA CONEXION AL SERVIDOR DE DATOS]',
          );
        }

        final notes = snapshot.data ?? [];

        if (notes.isEmpty) {
          return const DefaultTipText(
            tip: 'CREA LISTAS DE DESEADOS Y ORGANIZA FÁCILMENTE COMPARACIONES DE PRECIOS',
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(bottom: 150),
          itemCount: notes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) {
            final note = notes[index];
            return NoteCard(
              noteId: note.id,
              title: note.title.isEmpty ? 'Sin título' : note.title,
              date: _formatDate(note.updatedAt),
              icon: note.icon,
              onDelete: () => _repository.deleteNote(note.id),
            );
          },
        );
      },
    );
  }

  void _cleanEmptyNotes(List<Note> notes) {
    final now = DateTime.now();
    for (final note in notes) {
      final isEmpty = note.title.trim().isEmpty && note.content.trim().isEmpty;
      final isOld = now.difference(note.createdAt).inSeconds > 1;
      if (isEmpty && isOld) _repository.deleteNote(note.id);
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }
}