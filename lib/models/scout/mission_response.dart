import 'package:cloud_firestore/cloud_firestore.dart';

class MissionResponse {
  final String id;
  final String userId;
  final double price;
  final DateTime createdAt;

  const MissionResponse({
    required this.id,
    required this.userId,
    required this.price,
    required this.createdAt,
  });

  factory MissionResponse.fromMap(String id, Map<String, dynamic> map) {
    return MissionResponse(
      id: id,
      userId: map['userId'] as String,
      price: (map['price'] as num).toDouble(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'price': price,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}