class Division {
  final String id;
  final String name;

  const Division({
    required this.id,
    required this.name,
  });

  factory Division.fromMap(String id, Map<String, dynamic> map) {
    return Division(
      id: id,
      name: map['name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  Division copyWith({
    String? id,
    String? name,
  }) {
    return Division(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}