import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/app_user.dart';

class Mission {
  final String id;
  final String storeId;
  final String productName;
  final double suggestedPrice;
  final String unit;
  final String status;
  final DateTime createdAt;
  final ScoutLocation location;
  final String? completedBy;
  final double? resolvedPrice;
  final DateTime? resolvedAt;
  final List<String> auditLog;

  const Mission({
    required this.id,
    required this.storeId,
    required this.productName,
    required this.suggestedPrice,
    required this.unit,
    required this.status,
    required this.createdAt,
    required this.location,
    this.completedBy,
    this.resolvedPrice,
    this.resolvedAt,
    this.auditLog = const [],
  });

  factory Mission.fromMap(String id, Map<String, dynamic> map) {
    return Mission(
      id: id,
      storeId: map['storeId'] as String,
      productName: map['productName'] as String,
      suggestedPrice: (map['suggestedPrice'] as num).toDouble(),
      unit: map['unit'] as String,
      status: map['status'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      location: ScoutLocation.fromMap(map['location'] as Map<String, dynamic>),
      completedBy: map['completedBy'] as String?,
      resolvedPrice: (map['resolvedPrice'] as num?)?.toDouble(),
      resolvedAt: map['resolvedAt'] != null
          ? (map['resolvedAt'] as Timestamp).toDate()
          : null,
      auditLog: List<String>.from(map['auditLog'] as List? ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storeId': storeId,
      'productName': productName,
      'suggestedPrice': suggestedPrice,
      'unit': unit,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'location': location.toMap(),
      'completedBy': completedBy,
      'resolvedPrice': resolvedPrice,
      'resolvedAt': resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
      'auditLog': auditLog,
    };
  }
}