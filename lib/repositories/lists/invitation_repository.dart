import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/lists/invitation.dart';

class InvitationRepository {
  final FirebaseFirestore _db;

  InvitationRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  // ── Generar invitación ───────────────────────────────────────────────────

  Future<Invitation> createInvitation(String listId) async {
    final token = _generateToken();
    final now = DateTime.now();

    final data = {
      'token': token,
      'expiresAt': Timestamp.fromDate(now.add(const Duration(hours: 48))),
      'status': InvitationStatus.pending.name,
    };

    final ref = await _db
        .collection('lists')
        .doc(listId)
        .collection('invitations')
        .add(data);

    return Invitation.fromMap(ref.id, data);
  }

  // ── Verificar token ──────────────────────────────────────────────────────

  /// Devuelve la invitación si es válida (pending + no expirada), null en caso contrario.
  Future<Invitation?> verifyToken(String listId, String token) async {
    final snap = await _db
        .collection('lists')
        .doc(listId)
        .collection('invitations')
        .where('token', isEqualTo: token)
        .limit(1)
        .get();

    if (snap.docs.isEmpty) return null;

    final doc = snap.docs.first;
    final invitation = Invitation.fromMap(doc.id, doc.data());

    // Si ha expirado por tiempo pero el status sigue siendo pending, lo marcamos
    if (invitation.status == InvitationStatus.pending &&
        DateTime.now().isAfter(invitation.expiresAt)) {
      await doc.reference.update({'status': InvitationStatus.expired.name});
      return null;
    }

    return invitation.isValid ? invitation : null;
  }

  // ── Usar token ───────────────────────────────────────────────────────────

  /// Marca el token como used y agrega al usuario como miembro.
  /// Retorna false si el token ya no es válido o el usuario ya es miembro.
  Future<bool> redeemInvitation({
    required String listId,
    required String token,
    required String userId,
  }) async {
    final invitation = await verifyToken(listId, token);
    if (invitation == null) return false;

    final listSnap = await _db.collection('lists').doc(listId).get();
    if (!listSnap.exists) return false;
    final collaborators = List<String>.from(listSnap.data()?['collaborators'] ?? []);
    if (collaborators.contains(userId)) return true;

    // Escritura atómica: marcar used + crear miembro
    final batch = _db.batch();

    batch.update(
      _db
          .collection('lists')
          .doc(listId)
          .collection('invitations')
          .doc(invitation.id),
      {'status': InvitationStatus.used.name},
    );

    batch.update(
      _db.collection('lists').doc(listId),
      {
        'collaborators': FieldValue.arrayUnion([userId]),
      },
    );

    await batch.commit();
    return true;
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String _generateToken() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rng = Random.secure();
    return List.generate(32, (_) => chars[rng.nextInt(chars.length)]).join();
  }
}