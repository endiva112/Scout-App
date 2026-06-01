class Store {
  final String id;
  final String name;
  final String? logoUrl;

  const Store({
    required this.id,
    required this.name,
    this.logoUrl,
  });

  factory Store.fromMap(String id, Map<String, dynamic> map) {
    return Store(
      id: id,
      name: map['name'] as String,
      logoUrl: map['logoUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logoUrl': logoUrl,
    };
  }
}