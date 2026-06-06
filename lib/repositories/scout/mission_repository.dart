import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/models/scout/mission.dart';

class MissionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream de misiones activas por ubicación
  Stream<List<Mission>> getMissions(ScoutLocation location) {
    return _db
        .collection('missions')
        .where('isActive', isEqualTo: true)
        .where('location.country', isEqualTo: location.country)
        .where('location.region', isEqualTo: location.region)
        .where('location.city', isEqualTo: location.city)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Mission.fromMap(doc.id, doc.data()))
            .toList());
  }

  // Misiones activas de una tienda concreta por ubicación
  Future<List<Mission>> getMissionsByStore(
      String storeId, ScoutLocation location) async {
    final snapshot = await _db
        .collection('missions')
        .where('isActive', isEqualTo: true)
        .where('storeId', isEqualTo: storeId)
        .where('location.country', isEqualTo: location.country)
        .where('location.region', isEqualTo: location.region)
        .where('location.city', isEqualTo: location.city)
        .get();
    return snapshot.docs
        .map((doc) => Mission.fromMap(doc.id, doc.data()))
        .toList();
  }

  // Verificar si el usuario ya respondió una misión
  Future<bool> hasResponded(String missionId) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await _db
        .collection('missions')
        .doc(missionId)
        .collection('responses')
        .where('userId', isEqualTo: uid)
        .get();
    return snapshot.docs.isNotEmpty;
  }

  // Crear respuesta
  Future<void> respond(String missionId, double price) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _db
        .collection('missions')
        .doc(missionId)
        .collection('responses')
        .add({
      'userId': uid,
      'price': price,
      'createdAt': Timestamp.now(),
    });
  }
}