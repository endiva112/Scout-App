import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/constants/note_icons.dart';
import 'package:scout_app/models/note.dart';

class NoteRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream de notas en tiempo real
  Stream<List<Note>> getNotes(String userId) {
    return _db
        .collection('notes')
        .where('userId', isEqualTo: userId)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Note.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Crear nota nueva
  Future<String> createNote(String userId) async {
    final doc = await _db.collection('notes').add({
      'userId': userId,
      'title': '',
      'icon': defaultNoteIcon.name,
      'content': '',
      'updatedAt': Timestamp.now(),
    });
    return doc.id;
  }

  // Actualizar nota
  Future<void> updateNote(Note note) async {
    await _db.collection('notes').doc(note.id).update({
      'title': note.title,
      'icon': note.icon.name,
      'content': note.content,
      'updatedAt': Timestamp.now(),
    });
  }

  // Borrar nota
  Future<void> deleteNote(String noteId) async {
    await _db.collection('notes').doc(noteId).delete();
  }
}