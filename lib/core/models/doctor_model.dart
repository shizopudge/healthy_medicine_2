import 'package:flutter/foundation.dart';

class Doctor {
  final String firstName;
  final String lastName;
  final String patronymic;
  final String image;
  final String clinicId;
  final String id;
  final String city;
  final String spec;
  final int experience;
  final List<dynamic> rating;
  final List<String> comments;
  final int serviceCost;
  Doctor({
    required this.firstName,
    required this.lastName,
    required this.patronymic,
    required this.image,
    required this.clinicId,
    required this.id,
    required this.city,
    required this.spec,
    required this.experience,
    required this.rating,
    required this.comments,
    required this.serviceCost,
  });

  Doctor copyWith({
    String? firstName,
    String? lastName,
    String? patronymic,
    String? image,
    String? clinicId,
    String? id,
    String? city,
    String? spec,
    int? experience,
    List<dynamic>? rating,
    List<String>? comments,
    int? serviceCost,
  }) {
    return Doctor(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      patronymic: patronymic ?? this.patronymic,
      image: image ?? this.image,
      clinicId: clinicId ?? this.clinicId,
      id: id ?? this.id,
      city: city ?? this.city,
      spec: spec ?? this.spec,
      experience: experience ?? this.experience,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
      serviceCost: serviceCost ?? this.serviceCost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'patronymic': patronymic,
      'image': image,
      'clinicId': clinicId,
      'id': id,
      'city': city,
      'spec': spec,
      'experience': experience,
      'rating': rating,
      'comments': comments,
      'serviceCost': serviceCost,
    };
  }

  factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      patronymic: map['patronymic'] as String,
      image: map['image'] as String,
      clinicId: map['clinicId'] as String,
      id: map['id'] as String,
      city: map['city'] as String,
      spec: map['spec'] as String,
      experience: map['experience'] as int,
      rating: List<dynamic>.from(
        (map['rating']),
      ),
      comments: List<String>.from(
        (map['comments']),
      ),
      serviceCost: map['serviceCost'] as int,
    );
  }

  @override
  String toString() {
    return 'Doctor(firstName: $firstName, lastName: $lastName, patronymic: $patronymic, image: $image, clinicId: $clinicId, id: $id, city: $city, spec: $spec, experience: $experience, rating: $rating, comments: $comments, serviceCost: $serviceCost)';
  }

  @override
  bool operator ==(covariant Doctor other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.patronymic == patronymic &&
        other.image == image &&
        other.clinicId == clinicId &&
        other.id == id &&
        other.city == city &&
        other.spec == spec &&
        other.experience == experience &&
        listEquals(other.rating, rating) &&
        listEquals(other.comments, comments) &&
        other.serviceCost == serviceCost;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        patronymic.hashCode ^
        image.hashCode ^
        clinicId.hashCode ^
        id.hashCode ^
        city.hashCode ^
        spec.hashCode ^
        experience.hashCode ^
        rating.hashCode ^
        comments.hashCode ^
        serviceCost.hashCode;
  }
}
