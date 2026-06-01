import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/app_user.dart';

class Mission {
  final String id;
  final String storeId;
  final String productName;
  final double suggestedPrice;
  final String unit;
  final bool isActive;
  final DateTime createdAt;
  final ScoutLocation location;

  const Mission({
    required this.id,
    required this.storeId,
    required this.productName,
    required this.suggestedPrice,
    required this.unit,
    required this.isActive,
    required this.createdAt,
    required this.location,
  });

  factory Mission.fromMap(String id, Map<String, dynamic> map) {
    return Mission(
      id: id,
      storeId: map['storeId'] as String,
      productName: map['productName'] as String,
      suggestedPrice: (map['suggestedPrice'] as num).toDouble(),
      unit: map['unit'] as String,
      isActive: map['isActive'] as bool? ?? true,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      location: ScoutLocation.fromMap(map['location'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'productName': productName,
      'suggestedPrice': suggestedPrice,
      'unit': unit,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'location': location.toMap(),
    };
  }
}