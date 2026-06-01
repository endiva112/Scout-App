import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/app_user.dart';
import 'package:scout_app/models/mission.dart';

class MissionRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Mission>> getMissions(ScoutLocation location) {
    return _db
        .collection('missions')
        //.where('isActive', isEqualTo: true)
        .where('location.country', isEqualTo: location.country)
        .where('location.region', isEqualTo: location.region)
        .where('location.city', isEqualTo: location.city)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => Mission.fromMap(doc.id, doc.data()))
              .toList();
        });
  }
}