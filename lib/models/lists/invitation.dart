import 'package:cloud_firestore/cloud_firestore.dart';

enum InvitationStatus { pending, used, expired }

class Invitation {
  final String id;
  final String token;
  final DateTime expiresAt;
  final InvitationStatus status;

  const Invitation({
    required this.id,
    required this.token,
    required this.expiresAt,
    required this.status,
  });

  factory Invitation.fromMap(String id, Map<String, dynamic> map) {
    return Invitation(
      id: id,
      token: map['token'] as String,
      expiresAt: (map['expiresAt'] as Timestamp).toDate(),
      status: InvitationStatus.values.firstWhere(
        (s) => s.name == map['status'],
        orElse: () => InvitationStatus.expired,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'expiresAt': Timestamp.fromDate(expiresAt),
      'status': status.name,
    };
  }

  bool get isValid =>
      status == InvitationStatus.pending &&
      DateTime.now().isBefore(expiresAt);
}