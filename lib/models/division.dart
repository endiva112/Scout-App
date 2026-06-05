class Division {
  final String id;
  final String name;
  final String? storeId;
  final bool isDefault;
  final int sortOrder;

  const Division({
    required this.id,
    required this.name,
    this.storeId,
    required this.isDefault,
    required this.sortOrder,
  });

  factory Division.fromMap(String id, Map<String, dynamic> map) {
    return Division(
      id: id,
      name: map['name'] as String? ?? '',
      storeId: map['storeId'] as String?,
      isDefault: map['isDefault'] as bool? ?? false,
      sortOrder: map['sortOrder'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'storeId': storeId,
      'isDefault': isDefault,
      'sortOrder': sortOrder,
    };
  }

  Division copyWith({
    String? id,
    String? name,
    String? storeId,
    bool? isDefault,
    int? sortOrder,
  }) {
    return Division(
      id: id ?? this.id,
      name: name ?? this.name,
      storeId: storeId ?? this.storeId,
      isDefault: isDefault ?? this.isDefault,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}