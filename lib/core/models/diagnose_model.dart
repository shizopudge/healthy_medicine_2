import 'package:flutter/foundation.dart';

class Diagnose {
  final String id;
  final String diagnose;
  final String doctorId;
  final String uid;
  final String recomendations;
  final List<String> medicines;
  final DateTime createdAt;
  final bool isEdited;
  Diagnose({
    required this.id,
    required this.diagnose,
    required this.doctorId,
    required this.uid,
    required this.recomendations,
    required this.medicines,
    required this.createdAt,
    required this.isEdited,
  });

  Diagnose copyWith({
    String? id,
    String? diagnose,
    String? doctorId,
    String? uid,
    String? recomendations,
    List<String>? medicines,
    DateTime? createdAt,
    bool? isEdited,
  }) {
    return Diagnose(
      id: id ?? this.id,
      diagnose: diagnose ?? this.diagnose,
      doctorId: doctorId ?? this.doctorId,
      uid: uid ?? this.uid,
      recomendations: recomendations ?? this.recomendations,
      medicines: medicines ?? this.medicines,
      createdAt: createdAt ?? this.createdAt,
      isEdited: isEdited ?? this.isEdited,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'diagnose': diagnose,
      'doctorId': doctorId,
      'uid': uid,
      'recomendations': recomendations,
      'medicines': medicines,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isEdited': isEdited,
    };
  }

  factory Diagnose.fromMap(Map<String, dynamic> map) {
    return Diagnose(
      id: map['id'] as String,
      diagnose: map['diagnose'] as String,
      doctorId: map['doctorId'] as String,
      uid: map['uid'] as String,
      recomendations: map['recomendations'] as String,
      medicines: List<String>.from(
        (map['medicines']),
      ),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      isEdited: map['isEdited'] as bool,
    );
  }

  @override
  String toString() {
    return 'Diagnose(id: $id, diagnose: $diagnose, doctorId: $doctorId, uid: $uid, recomendations: $recomendations, medicines: $medicines, createdAt: $createdAt, isEdited: $isEdited)';
  }

  @override
  bool operator ==(covariant Diagnose other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.diagnose == diagnose &&
        other.doctorId == doctorId &&
        other.uid == uid &&
        other.recomendations == recomendations &&
        listEquals(other.medicines, medicines) &&
        other.createdAt == createdAt &&
        other.isEdited == isEdited;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        diagnose.hashCode ^
        doctorId.hashCode ^
        uid.hashCode ^
        recomendations.hashCode ^
        medicines.hashCode ^
        createdAt.hashCode ^
        isEdited.hashCode;
  }
}
