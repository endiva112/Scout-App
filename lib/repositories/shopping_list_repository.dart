import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/shopping_list.dart';
import 'package:scout_app/models/division.dart';
import 'package:scout_app/models/list_item.dart';

class ShoppingListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ─── ShoppingList ────────────────────────────────────────────────

  Stream<List<ShoppingList>> getActiveLists(String userId) {
    return _db
        .collection('lists')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'active')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((s) => s.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<ShoppingList>> getCompletedLists(String userId) {
    return _db
        .collection('lists')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'completed')
        .orderBy('completedAt', descending: true)
        .snapshots()
        .map((s) => s.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<ShoppingList>> getSettledLists(String userId) {
    return _db
        .collection('lists')
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'settled')
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((s) => s.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<ShoppingList?> getList(String listId) async {
    final doc = await _db.collection('lists').doc(listId).get();
    if (!doc.exists) return null;
    return ShoppingList.fromMap(doc.id, doc.data()!);
  }

  Future<ShoppingList> createList(ShoppingList list) async {
    final now = DateTime.now();
    final doc = await _db.collection('lists').add({
      ...list.toMap(),
      'createdAt': Timestamp.fromDate(now),
      'updatedAt': Timestamp.fromDate(now),
    });
    return list.copyWith(id: doc.id, updatedAt: now);
  }

  Future<ShoppingList> updateListTitle(ShoppingList list) async {
    final now = DateTime.now();
    await _db.collection('lists').doc(list.id).update({
      'title': list.title,
      'updatedAt': Timestamp.fromDate(now),
    });
    return list.copyWith(updatedAt: now);
  }

  Future<void> deleteList(String listId) async {
    await _db.collection('lists').doc(listId).delete();
  }

  // ─── Divisions ───────────────────────────────────────────────────

  Stream<List<Division>> getDivisions(String listId) {
    return _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .orderBy('sortOrder')
        .snapshots()
        .map((s) => s.docs
            .map((doc) => Division.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<Division> createDivision(String listId, Division division) async {
    final doc = await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .add(division.toMap());
    return division.copyWith(id: doc.id);
  }

  Future<void> updateDivision(String listId, Division division) async {
    await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(division.id)
        .update(division.toMap());
  }

  Future<void> deleteDivisionWithItems(String listId, String divisionId) async {
    // Borrar todos los ítems de la división
    final items = await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items')
        .get();

    final batch = _db.batch();
    for (final item in items.docs) {
      batch.delete(item.reference);
    }

    // Borrar la división
    batch.delete(
      _db.collection('lists').doc(listId).collection('divisions').doc(divisionId),
    );

    await batch.commit();
  }

  // ─── Items ───────────────────────────────────────────────────────

  Stream<List<ListItem>> getItems(String listId, String divisionId) {
    return _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items')
        .snapshots()
        .map((s) => s.docs
            .map((doc) => ListItem.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<ListItem> createItem(
      String listId, String divisionId, ListItem item) async {
    final doc = await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items')
        .add(item.toMap());
    return item.copyWith(id: doc.id);
  }

  Future<void> updateItem(
      String listId, String divisionId, ListItem item) async {
    await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items')
        .doc(item.id)
        .update(item.toMap());
  }

  Future<void> deleteItem(
      String listId, String divisionId, String itemId) async {
    await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items')
        .doc(itemId)
        .delete();
  }
}