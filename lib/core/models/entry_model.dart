class EntryModel {
  final String clinicId;
  final DateTime dateTime;
  final DateTime exTime;
  final DateTime exDate;
  final String doctorImage;
  final String doctorLastName;
  final String doctorFirstName;
  final String doctorPatronymic;
  final String doctorSpec;
  final int serviceCost;
  final String doctorId;
  final String id;
  final String uid;
  EntryModel({
    required this.clinicId,
    required this.dateTime,
    required this.exTime,
    required this.exDate,
    required this.doctorImage,
    required this.doctorLastName,
    required this.doctorFirstName,
    required this.doctorPatronymic,
    required this.doctorSpec,
    required this.serviceCost,
    required this.doctorId,
    required this.id,
    required this.uid,
  });

  EntryModel copyWith({
    String? clinicId,
    DateTime? dateTime,
    DateTime? exTime,
    DateTime? exDate,
    String? doctorImage,
    String? doctorLastName,
    String? doctorFirstName,
    String? doctorPatronymic,
    String? doctorSpec,
    int? serviceCost,
    String? doctorId,
    String? id,
    String? uid,
  }) {
    return EntryModel(
      clinicId: clinicId ?? this.clinicId,
      dateTime: dateTime ?? this.dateTime,
      exTime: exTime ?? this.exTime,
      exDate: exDate ?? this.exDate,
      doctorImage: doctorImage ?? this.doctorImage,
      doctorLastName: doctorLastName ?? this.doctorLastName,
      doctorFirstName: doctorFirstName ?? this.doctorFirstName,
      doctorPatronymic: doctorPatronymic ?? this.doctorPatronymic,
      doctorSpec: doctorSpec ?? this.doctorSpec,
      serviceCost: serviceCost ?? this.serviceCost,
      doctorId: doctorId ?? this.doctorId,
      id: id ?? this.id,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinicId': clinicId,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'exTime': exTime.millisecondsSinceEpoch,
      'exDate': exDate.millisecondsSinceEpoch,
      'doctorImage': doctorImage,
      'doctorLastName': doctorLastName,
      'doctorFirstName': doctorFirstName,
      'doctorPatronymic': doctorPatronymic,
      'doctorSpec': doctorSpec,
      'serviceCost': serviceCost,
      'doctorId': doctorId,
      'id': id,
      'uid': uid,
    };
  }

  factory EntryModel.fromMap(Map<String, dynamic> map) {
    return EntryModel(
      clinicId: map['clinicId'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      exTime: DateTime.fromMillisecondsSinceEpoch(map['exTime'] as int),
      exDate: DateTime.fromMillisecondsSinceEpoch(map['exDate'] as int),
      doctorImage: map['doctorImage'] as String,
      doctorLastName: map['doctorLastName'] as String,
      doctorFirstName: map['doctorFirstName'] as String,
      doctorPatronymic: map['doctorPatronymic'] as String,
      doctorSpec: map['doctorSpec'] as String,
      serviceCost: map['serviceCost'] as int,
      doctorId: map['doctorId'] as String,
      id: map['id'] as String,
      uid: map['uid'] as String,
    );
  }

  @override
  String toString() {
    return 'EntryModel(clinicId: $clinicId, dateTime: $dateTime, exTime: $exTime, exDate: $exDate, doctorImage: $doctorImage, doctorLastName: $doctorLastName, doctorFirstName: $doctorFirstName, doctorPatronymic: $doctorPatronymic, doctorSpec: $doctorSpec, serviceCost: $serviceCost, doctorId: $doctorId, id: $id, uid: $uid)';
  }

  @override
  bool operator ==(covariant EntryModel other) {
    if (identical(this, other)) return true;

    return other.clinicId == clinicId &&
        other.dateTime == dateTime &&
        other.exTime == exTime &&
        other.exDate == exDate &&
        other.doctorImage == doctorImage &&
        other.doctorLastName == doctorLastName &&
        other.doctorFirstName == doctorFirstName &&
        other.doctorPatronymic == doctorPatronymic &&
        other.doctorSpec == doctorSpec &&
        other.serviceCost == serviceCost &&
        other.doctorId == doctorId &&
        other.id == id &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return clinicId.hashCode ^
        dateTime.hashCode ^
        exTime.hashCode ^
        exDate.hashCode ^
        doctorImage.hashCode ^
        doctorLastName.hashCode ^
        doctorFirstName.hashCode ^
        doctorPatronymic.hashCode ^
        doctorSpec.hashCode ^
        serviceCost.hashCode ^
        doctorId.hashCode ^
        id.hashCode ^
        uid.hashCode;
  }
}

// class EntryModel {
//   final String clinicId;
//   final DateTime date;
//   final String doctorImage;
//   final String doctorLastName;
//   final String doctorFirstName;
//   final String doctorPatronymic;
//   final String doctorSpec;
//   final int serviceCost;
//   final String doctorId;
//   final String id;
//   final DateTime time;
//   final String uid;
//   EntryModel({
//     required this.clinicId,
//     required this.date,
//     required this.doctorImage,
//     required this.doctorLastName,
//     required this.doctorFirstName,
//     required this.doctorPatronymic,
//     required this.doctorSpec,
//     required this.serviceCost,
//     required this.doctorId,
//     required this.id,
//     required this.time,
//     required this.uid,
//   });

//   EntryModel copyWith({
//     String? clinicId,
//     DateTime? date,
//     String? doctorImage,
//     String? doctorLastName,
//     String? doctorFirstName,
//     String? doctorPatronymic,
//     String? doctorSpec,
//     int? serviceCost,
//     String? doctorId,
//     String? id,
//     DateTime? time,
//     String? uid,
//   }) {
//     return EntryModel(
//       clinicId: clinicId ?? this.clinicId,
//       date: date ?? this.date,
//       doctorImage: doctorImage ?? this.doctorImage,
//       doctorLastName: doctorLastName ?? this.doctorLastName,
//       doctorFirstName: doctorFirstName ?? this.doctorFirstName,
//       doctorPatronymic: doctorPatronymic ?? this.doctorPatronymic,
//       doctorSpec: doctorSpec ?? this.doctorSpec,
//       serviceCost: serviceCost ?? this.serviceCost,
//       doctorId: doctorId ?? this.doctorId,
//       id: id ?? this.id,
//       time: time ?? this.time,
//       uid: uid ?? this.uid,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'clinicId': clinicId,
//       'date': date.millisecondsSinceEpoch,
//       'doctorImage': doctorImage,
//       'doctorLastName': doctorLastName,
//       'doctorFirstName': doctorFirstName,
//       'doctorPatronymic': doctorPatronymic,
//       'doctorSpec': doctorSpec,
//       'serviceCost': serviceCost,
//       'doctorId': doctorId,
//       'id': id,
//       'time': time.millisecondsSinceEpoch,
//       'uid': uid,
//     };
//   }

//   factory EntryModel.fromMap(Map<String, dynamic> map) {
//     return EntryModel(
//       clinicId: map['clinicId'] as String,
//       date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
//       doctorImage: map['doctorImage'] as String,
//       doctorLastName: map['doctorLastName'] as String,
//       doctorFirstName: map['doctorFirstName'] as String,
//       doctorPatronymic: map['doctorPatronymic'] as String,
//       doctorSpec: map['doctorSpec'] as String,
//       serviceCost: map['serviceCost'] as int,
//       doctorId: map['doctorId'] as String,
//       id: map['id'] as String,
//       time: DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
//       uid: map['uid'] as String,
//     );
//   }

//   @override
//   String toString() {
//     return 'EntryModel(clinicId: $clinicId, date: $date, doctorImage: $doctorImage, doctorLastName: $doctorLastName, doctorFirstName: $doctorFirstName, doctorPatronymic: $doctorPatronymic, doctorSpec: $doctorSpec, serviceCost: $serviceCost, doctorId: $doctorId, id: $id, time: $time, uid: $uid)';
//   }

//   @override
//   bool operator ==(covariant EntryModel other) {
//     if (identical(this, other)) return true;

//     return other.clinicId == clinicId &&
//         other.date == date &&
//         other.doctorImage == doctorImage &&
//         other.doctorLastName == doctorLastName &&
//         other.doctorFirstName == doctorFirstName &&
//         other.doctorPatronymic == doctorPatronymic &&
//         other.doctorSpec == doctorSpec &&
//         other.serviceCost == serviceCost &&
//         other.doctorId == doctorId &&
//         other.id == id &&
//         other.time == time &&
//         other.uid == uid;
//   }

//   @override
//   int get hashCode {
//     return clinicId.hashCode ^
//         date.hashCode ^
//         doctorImage.hashCode ^
//         doctorLastName.hashCode ^
//         doctorFirstName.hashCode ^
//         doctorPatronymic.hashCode ^
//         doctorSpec.hashCode ^
//         serviceCost.hashCode ^
//         doctorId.hashCode ^
//         id.hashCode ^
//         time.hashCode ^
//         uid.hashCode;
//   }
// }
