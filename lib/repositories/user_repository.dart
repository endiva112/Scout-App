import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout_app/models/app_user.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Crear documento de usuario en Firestore
  Future<void> createUser(String uid, {bool isAnonymous = true}) async {
    await _db.collection('users').doc(uid).set({
      'createdAt': Timestamp.now(),
      'isAnonymous': isAnonymous,
      'alias': null,
      'photoUrl': null,
      'scout': isAnonymous ? null : {
        'level': 1,
        'points': 0,
        'rank': 'hierro',
        'location': {
          'country': '',
          'region': '',
          'city': '',
        },
      },
    });
  }

  // Leer usuario
  Future<AppUser?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return AppUser.fromMap(doc.id, doc.data()!);
  }

  // Verificar si el documento ya existe
  Future<bool> userExists(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.exists;
  }

  // Actualizar campos de perfil
  Future<void> updateProfile(String uid, {
    String? alias,
    String? photoUrl,
  }) async {
    final data = <String, dynamic>{};
    if (alias != null) data['alias'] = alias;
    if (photoUrl != null) data['photoUrl'] = photoUrl;
    if (data.isEmpty) return;
    await _db.collection('users').doc(uid).update(data);
  }

  // Actualizar tiendas seleccionadas
  Future<void> updateSelectedStores(String uid, List<String> storeIds) async {
    await _db.collection('users').doc(uid).update({
      'scout.selectedStores': storeIds,
    });
  }

  // Actualizar ubicación
  Future<void> updateLocation(String uid, ScoutLocation location) async {
    await _db.collection('users').doc(uid).update({
      'scout.location': location.toMap(),
    });
  }

  // Actualizar usuario anónimo a registrado
  Future<void> upgradeToRegistered(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    
    // Si ya existe el documento y tiene datos scout, no sobreescribas
    if (doc.exists) {
      await _db.collection('users').doc(uid).update({
        'isAnonymous': false,
      });
      return;
    }

    // Solo si es la primera vez que vincula con Google
    await _db.collection('users').doc(uid).set({
      'createdAt': Timestamp.now(),
      'isAnonymous': false,
      'alias': null,
      'photoUrl': null,
      'scout': {
        'level': 1,
        'points': 0,
        'rank': 'hierro',
        'location': {
          'country': '',
          'region': '',
          'city': '',
        },
      },
    });
  }

  // Eliminar usuario
  Future<void> deleteUser(String uid) async {
    await _db.collection('users').doc(uid).delete();
  }
}