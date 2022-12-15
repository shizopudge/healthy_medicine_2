import 'package:flutter/foundation.dart';

class UserTimes {
  final bool isStandart;
  final List<DateTime> times;
  final String title;
  final String id;
  UserTimes({
    required this.isStandart,
    required this.times,
    required this.title,
    required this.id,
  });

  UserTimes copyWith({
    bool? isStandart,
    List<DateTime>? times,
    String? title,
    String? id,
  }) {
    return UserTimes(
      isStandart: isStandart ?? this.isStandart,
      times: times ?? this.times,
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isStandart': isStandart,
      'times': times.map((x) => x.millisecondsSinceEpoch).toList(),
      'title': title,
      'id': id,
    };
  }

  factory UserTimes.fromMap(Map<String, dynamic> map) {
    return UserTimes(
      isStandart: map['isStandart'] as bool,
      times: List<DateTime>.from(
        (map['times']).map<DateTime>(
          (x) => DateTime.fromMillisecondsSinceEpoch(x),
        ),
      ),
      title: map['title'] as String,
      id: map['id'] as String,
    );
  }

  @override
  String toString() {
    return 'UserTimes(isStandart: $isStandart, times: $times, title: $title, id: $id)';
  }

  @override
  bool operator ==(covariant UserTimes other) {
    if (identical(this, other)) return true;

    return other.isStandart == isStandart &&
        listEquals(other.times, times) &&
        other.title == title &&
        other.id == id;
  }

  @override
  int get hashCode {
    return isStandart.hashCode ^ times.hashCode ^ title.hashCode ^ id.hashCode;
  }
}
