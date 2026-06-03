import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/constants/note_icons.dart';

class Note {
  final String id;
  final String userId;
  final String title;
  final NoteIcon icon;
  final String content;
  final DateTime updatedAt;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.userId,
    required this.title,
    required this.icon,
    required this.content,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Note.fromMap(String id, Map<String, dynamic> map) {
    return Note(
      id: id,
      userId: map['userId'] as String,
      title: map['title'] as String? ?? '',
      icon: NoteIcon.values.firstWhere(
        (e) => e.name == map['icon'],
        orElse: () => defaultNoteIcon,
      ),
      content: map['content'] as String? ?? '',
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'icon': icon.name,
      'content': content,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Note copyWith({
    String? title,
    NoteIcon? icon,
    String? content,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id,
      userId: userId,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      content: content ?? this.content,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt,
    );
  }
}