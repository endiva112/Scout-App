import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/note.dart';

// Su funcion es decir -> id vacio? creo un documento, id valido? lo actualizo
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

  // Obtener los datos de 1 unica nota
  Future<Note?> getNote(String noteId) async {
    final doc = await _db.collection('notes').doc(noteId).get();
    if (!doc.exists) return null;
    return Note.fromMap(doc.id, doc.data()!);
  }

  // Guarda los datos de una nota, creando una nueva o editando una existente
  Future<Note> saveNote(Note note) async {

    final now = DateTime.now();

    // Crear
    if (note.id.isEmpty) {

      final doc = await _db.collection('notes').add({
        'userId': note.userId,
        'title': note.title,
        'icon': note.icon.name,
        'content': note.content,
        'createdAt': Timestamp.fromDate(note.createdAt),
        'updatedAt': Timestamp.fromDate(now),
      });

      return note.copyWith(
        id: doc.id,
        updatedAt: now,
      );
    }

    // Actualizar
    await _db.collection('notes').doc(note.id).update({
      'title': note.title,
      'icon': note.icon.name,
      'content': note.content,
      'updatedAt': Timestamp.fromDate(now),
    });

    return note.copyWith(
      updatedAt: now,
    );
  }

  // Borrar nota
  Future<void> deleteNote(String noteId) async {
    await _db.collection('notes').doc(noteId).delete();
  }
}