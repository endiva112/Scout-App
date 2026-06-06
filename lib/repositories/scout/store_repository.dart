import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/scout/store.dart';

class StoreRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Store?> getStore(String storeId) async {
    final doc = await _db.collection('stores').doc(storeId).get();
    if (!doc.exists) return null;
    return Store.fromMap(doc.id, doc.data()!);
  }

  Future<List<Store>> getAllStores() async {
  final snapshot = await _db.collection('stores').get();
  return snapshot.docs
      .map((doc) => Store.fromMap(doc.id, doc.data()))
      .toList();
  }
}