import 'package:cloud_firestore/cloud_firestore.dart';

enum ItemStatus { available, locked, purchased }

class ListItem {
  final String id;
  final String name;
  final String? unit;
  final ItemStatus itemStatus;
  final String? checkedBy;   // solo colaborativas
  final DateTime? expiresAt; // solo colaborativas

  const ListItem({
    required this.id,
    required this.name,
    this.unit,
    required this.itemStatus,
    this.checkedBy,
    this.expiresAt,
  });

  /// Reglas de negocio
  bool get isPurchased => itemStatus == ItemStatus.purchased;
  bool get isLocked => itemStatus == ItemStatus.locked;
  bool get isAvailable => itemStatus == ItemStatus.available;

  factory ListItem.fromMap(String id, Map<String, dynamic> map) {
    return ListItem(
      id: id,
      name: map['name'] as String? ?? '',
      unit: map['unit'] as String?,
      itemStatus: ItemStatus.values.firstWhere(
        (e) => e.name == map['itemStatus'],
        orElse: () => ItemStatus.available,
      ),
      checkedBy: map['checkedBy'] as String?,
      expiresAt: map['expiresAt'] != null
          ? (map['expiresAt'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'unit': unit,
      'itemStatus': itemStatus.name,
      'checkedBy': checkedBy,
      'expiresAt': expiresAt != null
          ? Timestamp.fromDate(expiresAt!)
          : null,
    };
  }

  ListItem copyWith({
    String? id,
    String? name,
    String? unit,
    ItemStatus? itemStatus,
    String? checkedBy,
    DateTime? expiresAt,
  }) {
    return ListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      itemStatus: itemStatus ?? this.itemStatus,
      checkedBy: checkedBy ?? this.checkedBy,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }
}