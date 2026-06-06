class Item {
  final String id;
  final String name;
  final String quantity;
  final bool checked;

  const Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.checked,
  });

  factory Item.fromMap(String id, Map<String, dynamic> map) {
    return Item(
      id: id,
      name: map['name'] as String? ?? '',
      quantity: map['quantity'] as String? ?? '',
      checked: map['checked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'checked': checked,
    };
  }

  Item copyWith({
    String? id,
    String? name,
    String? quantity,
    bool? checked,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      checked: checked ?? this.checked,
    );
  }
}