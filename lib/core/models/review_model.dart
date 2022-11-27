class ReviewModel {
  final String userAvatar;
  final DateTime createdAt;
  final String doctorId;
  final String userFirstName;
  final String userGender;
  final String id;
  final String userLastName;
  final String userPatronymic;
  final String reviewText;
  final String uid;
  final int rating;
  ReviewModel({
    required this.userAvatar,
    required this.createdAt,
    required this.doctorId,
    required this.userFirstName,
    required this.userGender,
    required this.id,
    required this.userLastName,
    required this.userPatronymic,
    required this.reviewText,
    required this.uid,
    required this.rating,
  });

  ReviewModel copyWith({
    String? userAvatar,
    DateTime? createdAt,
    String? doctorId,
    String? userFirstName,
    String? userGender,
    String? id,
    String? userLastName,
    String? userPatronymic,
    String? reviewText,
    String? uid,
    int? rating,
  }) {
    return ReviewModel(
      userAvatar: userAvatar ?? this.userAvatar,
      createdAt: createdAt ?? this.createdAt,
      doctorId: doctorId ?? this.doctorId,
      userFirstName: userFirstName ?? this.userFirstName,
      userGender: userGender ?? this.userGender,
      id: id ?? this.id,
      userLastName: userLastName ?? this.userLastName,
      userPatronymic: userPatronymic ?? this.userPatronymic,
      reviewText: reviewText ?? this.reviewText,
      uid: uid ?? this.uid,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userAvatar': userAvatar,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'doctorId': doctorId,
      'userFirstName': userFirstName,
      'userGender': userGender,
      'id': id,
      'userLastName': userLastName,
      'userPatronymic': userPatronymic,
      'reviewText': reviewText,
      'uid': uid,
      'rating': rating,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      userAvatar: map['userAvatar'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      doctorId: map['doctorId'] as String,
      userFirstName: map['userFirstName'] as String,
      userGender: map['userGender'] as String,
      id: map['id'] as String,
      userLastName: map['userLastName'] as String,
      userPatronymic: map['userPatronymic'] as String,
      reviewText: map['reviewText'] as String,
      uid: map['uid'] as String,
      rating: map['rating'] as int,
    );
  }

  @override
  String toString() {
    return 'ReviewModel(userAvatar: $userAvatar, createdAt: $createdAt, doctorId: $doctorId, userFirstName: $userFirstName, userGender: $userGender, id: $id, userLastName: $userLastName, userPatronymic: $userPatronymic, reviewText: $reviewText, uid: $uid, rating: $rating)';
  }

  @override
  bool operator ==(covariant ReviewModel other) {
    if (identical(this, other)) return true;

    return other.userAvatar == userAvatar &&
        other.createdAt == createdAt &&
        other.doctorId == doctorId &&
        other.userFirstName == userFirstName &&
        other.userGender == userGender &&
        other.id == id &&
        other.userLastName == userLastName &&
        other.userPatronymic == userPatronymic &&
        other.reviewText == reviewText &&
        other.uid == uid &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return userAvatar.hashCode ^
        createdAt.hashCode ^
        doctorId.hashCode ^
        userFirstName.hashCode ^
        userGender.hashCode ^
        id.hashCode ^
        userLastName.hashCode ^
        userPatronymic.hashCode ^
        reviewText.hashCode ^
        uid.hashCode ^
        rating.hashCode;
  }
}
