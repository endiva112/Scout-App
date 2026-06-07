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

  //Expansión
  final int divisionCount;
  final int itemCount;
  final String annotation;

  const ShoppingList({
    required this.id,
    required this.ownerId,
    required this.type,
    required this.title,
    this.collaborators = const [],
    required this.status,
    required this.createdAt,
    required this.updatedAt,

    //Expansión de funciones
    this.divisionCount = 0,
    this.itemCount = 0,
    this.annotation = ''
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

      //Expansión
      divisionCount: map['divisionCount'] as int? ?? 0,
      itemCount: map['itemCount'] as int? ?? 0,
      annotation: map['annotation'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'type': type.name,
      'title': title,
      'collaborators': collaborators,
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

    //Expansión
    int? divisionCount,
    int? itemCount,
    String? annotation,

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

      //Expansión
      divisionCount: divisionCount ?? this.divisionCount,
      itemCount: itemCount ?? this.itemCount,
      annotation: annotation ?? this.annotation,
    );
  }
}