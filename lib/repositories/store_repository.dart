import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/store.dart';

class StoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Store?> getStore(String storeId) async {
    final doc = await _db.collection('stores').doc(storeId).get();
    if (!doc.exists) return null;
    return Store.fromMap(doc.id, doc.data()!);
  }
}