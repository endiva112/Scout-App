import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/lists/shopping_list.dart';
import 'package:scout_app/models/lists/division.dart';
import 'package:scout_app/models/lists/item.dart';

class ShoppingListRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // --- ShoppingList ---

  Stream<List<ShoppingList>> getLists(String ownerId) {
    return _db
        .collection('lists')
        .where('ownerId', isEqualTo: ownerId)
        .where('status', isEqualTo: ListStatus.shopping.name)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<ShoppingList?> getList(String listId) async {
    final doc = await _db.collection('lists').doc(listId).get();
    if (!doc.exists) return null;
    return ShoppingList.fromMap(doc.id, doc.data()!);
  }

  //#region Obtener listas por su atributo
    Stream<List<ShoppingList>> getShoppingLists(String ownerId) {
    return _db
        .collection('lists')
        .where('ownerId', isEqualTo: ownerId)
        .where('status', isEqualTo: ListStatus.shopping.name)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<ShoppingList>> getSettlingLists(String ownerId) {
    return _db
        .collection('lists')
        .where('ownerId', isEqualTo: ownerId)
        .where('status', isEqualTo: ListStatus.settling.name)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }

  Stream<List<ShoppingList>> getArchivedLists(String ownerId) {
    return _db
        .collection('lists')
        .where('ownerId', isEqualTo: ownerId)
        .where('status', isEqualTo: ListStatus.archived.name)
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ShoppingList.fromMap(doc.id, doc.data()))
            .toList());
  }
  //#endregion


  Future<ShoppingList?> saveList(ShoppingList list) async {
    final now = DateTime.now();

    if (list.id.isEmpty) {
      final doc = await _db.collection('lists').add({
        ...list.toMap(),
        'createdAt': Timestamp.fromDate(now),
        'updatedAt': Timestamp.fromDate(now),
      });
      return list.copyWith(id: doc.id, updatedAt: now);
    }

    await _db.collection('lists').doc(list.id).update({
      ...list.toMap(),
      'updatedAt': Timestamp.fromDate(now),
    });
    return list.copyWith(updatedAt: now);
  }

  //Borrado en cascada, borra items y divisiones antes de borrar listas
  Future<void> deleteList(String listId) async {
    final divisionsRef = _db
        .collection('lists')
        .doc(listId)
        .collection('divisions');

    final divisions = await divisionsRef.get();

    for (final division in divisions.docs) {
      final itemsRef = divisionsRef.doc(division.id).collection('items');
      final items = await itemsRef.get();

      for (final item in items.docs) {
        await item.reference.delete();
      }

      await division.reference.delete();
    }

    await _db.collection('lists').doc(listId).delete();
  }

  // --- Divisions ---

  Stream<List<Division>> getDivisions(String listId) {
    return _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Division.fromMap(doc.id, doc.data()))
            .toList());
  }

  Future<Division> saveDivision(String listId, Division division) async {
    if (division.id.isEmpty) {
      final doc = await _db
          .collection('lists')
          .doc(listId)
          .collection('divisions')
          .add(division.toMap());
      return division.copyWith(id: doc.id);
    }

    await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(division.id)
        .update(division.toMap());
    return division;
  }

  //Borrado en cascada de las divisiones
  Future<void> deleteDivision(String listId, String divisionId) async {
    final itemsRef = _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items');

    final items = await itemsRef.get();
    for (final item in items.docs) {
      await item.reference.delete();
    }

    await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .delete();
  }

  // --- Items ---

  Stream<List<Item>> getItems(String listId, String divisionId) {
    return _db
      .collection('lists')
      .doc(listId)
      .collection('divisions')
      .doc(divisionId)
      .collection('items')
      .orderBy('createdAt', descending: false) // ← añade esto
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Item.fromMap(doc.id, doc.data()))
          .toList());
  }

  Future<Item> saveItem(String listId, String divisionId, Item item) async {
    if (item.id.isEmpty) {
      final now = Timestamp.fromDate(DateTime.now());
      final doc = await _db
          .collection('lists')
          .doc(listId)
          .collection('divisions')
          .doc(divisionId)
          .collection('items')
          .add({
            ...item.toMap(),
            'createdAt': now, // ← añade esto
          });
      return item.copyWith(id: doc.id);
    }
    // el update no toca createdAt
    await _db
        .collection('lists')
        .doc(listId)
        .collection('divisions')
        .doc(divisionId)
        .collection('items')
        .doc(item.id)
        .update(item.toMap());
    return item;
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

  //Expansión
  Future<void> incrementDivisionCount(String listId) async {
    await _db.collection('lists').doc(listId).update({
      'divisionCount': FieldValue.increment(1),
    });
  }

  Future<void> decrementDivisionCount(String listId) async {
    await _db.collection('lists').doc(listId).update({
      'divisionCount': FieldValue.increment(-1),
    });
  }

  Future<void> incrementItemCount(String listId) async {
    await _db.collection('lists').doc(listId).update({
      'itemCount': FieldValue.increment(1),
    });
  }

  Future<void> decrementItemCount(String listId) async {
    await _db.collection('lists').doc(listId).update({
      'itemCount': FieldValue.increment(-1),
    });
  }

  Future<void> saveAnnotation(String listId, String annotation) async {
    await _db.collection('lists').doc(listId).update({
      'annotation': annotation,
    });
  }
}