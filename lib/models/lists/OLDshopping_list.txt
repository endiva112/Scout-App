
/*import 'package:cloud_firestore/cloud_firestore.dart';

enum ListType { simple, collaborative, recurring }
enum ListStatus { active, completed, settled }

class ShoppingList {
  static const _sentinel = Object();

  final String id;
  final String userId;
  final ListType type;
  final ListStatus status;
  final String title;
  final DateTime updatedAt;
  final DateTime createdAt;
  final DateTime? completedAt;
  //final bool isFavorite;
  final String? templateSourceId;
  final String noteTitle;
  final String noteContent;
  final DateTime noteUpdatedAt;
  final int? externalCount;

  const ShoppingList({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.title,
    required this.updatedAt,
    required this.createdAt,
    this.completedAt,
    required this.isFavorite,
    this.templateSourceId,
    required this.noteTitle,
    required this.noteContent,
    required this.noteUpdatedAt,
    this.externalCount,
  });

  /// Reglas de negocio
  bool get isCollaborative => type == ListType.collaborative;
  bool get isActive => status == ListStatus.active;

  String get displayTitle =>
      title.trim().isEmpty ? 'Sin título' : title.trim();

  bool get hasNote =>
      noteTitle.trim().isNotEmpty || noteContent.trim().isNotEmpty;

  factory ShoppingList.fromMap(String id, Map<String, dynamic> map) {
    return ShoppingList(
      id: id,
      userId: map['userId'] as String,
      type: ListType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => ListType.simple,
      ),
      status: ListStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ListStatus.active,
      ),
      title: map['title'] as String? ?? '',
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      completedAt: map['completedAt'] != null
          ? (map['completedAt'] as Timestamp).toDate()
          : null,
      isFavorite: map['isFavorite'] as bool? ?? false,
      templateSourceId: map['templateSourceId'] as String?,
      noteTitle: (map['note'] as Map<String, dynamic>?)?['title'] as String? ?? '',
      noteContent: (map['note'] as Map<String, dynamic>?)?['content'] as String? ?? '',
      noteUpdatedAt: map['note'] != null
          ? ((map['note'] as Map<String, dynamic>)['updatedAt'] as Timestamp).toDate()
          : DateTime.now(),
      externalCount: map['externalCount'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type.name,
      'status': status.name,
      'title': title,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'createdAt': Timestamp.fromDate(createdAt),
      'completedAt': completedAt != null
          ? Timestamp.fromDate(completedAt!)
          : null,
      'isFavorite': isFavorite,
      'templateSourceId': templateSourceId,
      'note': {
        'title': noteTitle,
        'content': noteContent,
        'updatedAt': Timestamp.fromDate(noteUpdatedAt),
      },
      if (externalCount != null) 'externalCount': externalCount,
    };
  }

  ShoppingList copyWith({
    String? id,
    ListType? type,
    ListStatus? status,
    String? title,
    DateTime? updatedAt,
    Object? completedAt = _sentinel,
    bool? isFavorite,
    String? templateSourceId,
    String? noteTitle,
    String? noteContent,
    DateTime? noteUpdatedAt,
    int? externalCount,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      userId: userId,
      type: type ?? this.type,
      status: status ?? this.status,
      title: title ?? this.title,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt,
      completedAt: identical(completedAt, _sentinel)
          ? this.completedAt
          : completedAt as DateTime?,
      isFavorite: isFavorite ?? this.isFavorite,
      templateSourceId: templateSourceId ?? this.templateSourceId,
      noteTitle: noteTitle ?? this.noteTitle,
      noteContent: noteContent ?? this.noteContent,
      noteUpdatedAt: noteUpdatedAt ?? this.noteUpdatedAt,
      externalCount: externalCount ?? this.externalCount,
    );
  }
}*/