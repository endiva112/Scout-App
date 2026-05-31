import 'package:cloud_firestore/cloud_firestore.dart';

class ScoutLocation {
  final String country;
  final String region;
  final String city;

  const ScoutLocation({
    required this.country,
    required this.region,
    required this.city,
  });

  factory ScoutLocation.fromMap(Map<String, dynamic> map) {
    return ScoutLocation(
      country: map['country'] as String? ?? '',
      region: map['region'] as String? ?? '',
      city: map['city'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'region': region,
      'city': city,
    };
  }

  ScoutLocation copyWith({
    String? country,
    String? region,
    String? city,
  }) {
    return ScoutLocation(
      country: country ?? this.country,
      region: region ?? this.region,
      city: city ?? this.city,
    );
  }
}

class ScoutProfile {
  final int level;
  final int points;
  final String rank;
  final ScoutLocation location;

  const ScoutProfile({
    required this.level,
    required this.points,
    required this.rank,
    required this.location,
  });

  factory ScoutProfile.fromMap(Map<String, dynamic> map) {
    return ScoutProfile(
      level: map['level'] as int? ?? 1,
      points: map['points'] as int? ?? 0,
      rank: map['rank'] as String? ?? 'hierro',
      location: map['location'] != null
          ? ScoutLocation.fromMap(map['location'] as Map<String, dynamic>)
          : const ScoutLocation(country: '', region: '', city: ''),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'points': points,
      'rank': rank,
      'location': location.toMap(),
    };
  }

  ScoutProfile copyWith({
    int? level,
    int? points,
    String? rank,
    ScoutLocation? location,
  }) {
    return ScoutProfile(
      level: level ?? this.level,
      points: points ?? this.points,
      rank: rank ?? this.rank,
      location: location ?? this.location,
    );
  }
}

class AppUser {
  final String uid;
  final DateTime createdAt;
  final bool isAnonymous;
  final String? alias;
  final String? photoUrl;
  final ScoutProfile? scout;

  const AppUser({
    required this.uid,
    required this.createdAt,
    required this.isAnonymous,
    this.alias,
    this.photoUrl,
    this.scout,
  });

  factory AppUser.fromMap(String uid, Map<String, dynamic> map) {
    return AppUser(
      uid: uid,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      isAnonymous: map['isAnonymous'] as bool? ?? true,
      alias: map['alias'] as String?,
      photoUrl: map['photoUrl'] as String?,
      scout: map['scout'] != null
          ? ScoutProfile.fromMap(map['scout'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isAnonymous': isAnonymous,
      'alias': alias,
      'photoUrl': photoUrl,
      'scout': scout?.toMap(),
    };
  }

  AppUser copyWith({
    bool? isAnonymous,
    String? alias,
    String? photoUrl,
    ScoutProfile? scout,
  }) {
    return AppUser(
      uid: uid,
      createdAt: createdAt,
      isAnonymous: isAnonymous ?? this.isAnonymous,
      alias: alias ?? this.alias,
      photoUrl: photoUrl ?? this.photoUrl,
      scout: scout ?? this.scout,
    );
  }
}