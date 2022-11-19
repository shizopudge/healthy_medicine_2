import 'package:flutter/foundation.dart';

class EntryDateTimeModel {
  final String date;
  final String id;
  final List<String> time;
  EntryDateTimeModel({
    required this.date,
    required this.id,
    required this.time,
  });

  EntryDateTimeModel copyWith({
    String? date,
    String? id,
    List<String>? time,
  }) {
    return EntryDateTimeModel(
      date: date ?? this.date,
      id: id ?? this.id,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'id': id,
      'time': time,
    };
  }

  factory EntryDateTimeModel.fromMap(Map<String, dynamic> map) {
    return EntryDateTimeModel(
      date: map['date'] as String,
      id: map['id'] as String,
      time: List<String>.from(
        (map['time']),
      ),
    );
  }

  @override
  String toString() => 'EntryDateTimeModel(date: $date, id: $id, time: $time)';

  @override
  bool operator ==(covariant EntryDateTimeModel other) {
    if (identical(this, other)) return true;

    return other.date == date && other.id == id && listEquals(other.time, time);
  }

  @override
  int get hashCode => date.hashCode ^ id.hashCode ^ time.hashCode;
}
