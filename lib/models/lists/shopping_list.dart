import 'package:cloud_firestore/cloud_firestore.dart';

enum ListType { simple, collaborative, recurring }
enum ListStatus { shopping, settling, archived }

class ShoppingList {
  final String id;
  final String ownerId;
  final ListType type;
  final String title;
  final List<String> collaborators;
  final ListStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ShoppingList({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.title,
    this.collaborators = const [],
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShoppingList.fromMap(String id, Map<String, dynamic> map) {
    return ShoppingList(
      id: id,
      ownerId: map['ownerId'] as String,
      type: ListType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => ListType.simple,
      ),
      title: map['title'] as String? ?? '',
      collaborators: List<String>.from(map['collaborators'] ?? []),
      status: ListStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ListStatus.shopping,
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'type': type.name,
      'title': title,
      'collaborators': collaborators,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  ShoppingList copyWith({
    String? id,
    String? ownerId,
    ListType? type,
    String? title,
    List<String>? collaborators,
    ListStatus? status,
    DateTime? updatedAt,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      type: type ?? this.type,
      title: title ?? this.title,
      collaborators: collaborators ?? this.collaborators,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}