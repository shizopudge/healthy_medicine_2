import 'package:flutter/foundation.dart';

class DateTimeEntryModel {
  final DateTime date;
  final List<DateTime> time;
  final String id;
  final int month;
  final int year;
  final int day;
  DateTimeEntryModel({
    required this.date,
    required this.time,
    required this.id,
    required this.month,
    required this.year,
    required this.day,
  });

  DateTimeEntryModel copyWith({
    DateTime? date,
    List<DateTime>? time,
    String? id,
    int? month,
    int? year,
    int? day,
  }) {
    return DateTimeEntryModel(
      date: date ?? this.date,
      time: time ?? this.time,
      id: id ?? this.id,
      month: month ?? this.month,
      year: year ?? this.year,
      day: day ?? this.day,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date.millisecondsSinceEpoch,
      'time': time.map((x) => x.millisecondsSinceEpoch).toList(),
      'id': id,
      'month': month,
      'year': year,
      'day': day,
    };
  }

  factory DateTimeEntryModel.fromMap(Map<String, dynamic> map) {
    return DateTimeEntryModel(
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      time: List<DateTime>.from(
        (map['time']).map<DateTime>(
          (x) => DateTime.fromMillisecondsSinceEpoch(x),
        ),
      ),
      id: map['id'] as String,
      month: map['month'] as int,
      year: map['year'] as int,
      day: map['day'] as int,
    );
  }

  @override
  String toString() {
    return 'DateTimeEntryModel(date: $date, time: $time, id: $id, month: $month, year: $year, day: $day)';
  }

  @override
  bool operator ==(covariant DateTimeEntryModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        listEquals(other.time, time) &&
        other.id == id &&
        other.month == month &&
        other.year == year &&
        other.day == day;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        time.hashCode ^
        id.hashCode ^
        month.hashCode ^
        year.hashCode ^
        day.hashCode;
  }
}
