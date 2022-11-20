class UserModel {
  final String firstName;
  final String lastName;
  final String patronymic;
  final String email;
  final String avatar;
  final String gender;
  final String phone;
  final String city;
  final String uid;
  final DateTime birthday;
  final bool isAdmin;
  UserModel({
    required this.firstName,
    required this.lastName,
    required this.patronymic,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.phone,
    required this.city,
    required this.uid,
    required this.birthday,
    required this.isAdmin,
  });

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? patronymic,
    String? email,
    String? avatar,
    String? gender,
    String? phone,
    String? city,
    String? uid,
    DateTime? birthday,
    bool? isAdmin,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      patronymic: patronymic ?? this.patronymic,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      uid: uid ?? this.uid,
      birthday: birthday ?? this.birthday,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'patronymic': patronymic,
      'email': email,
      'avatar': avatar,
      'gender': gender,
      'phone': phone,
      'city': city,
      'uid': uid,
      'birthday': birthday.millisecondsSinceEpoch,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      patronymic: map['patronymic'] as String,
      email: map['email'] as String,
      avatar: map['avatar'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      city: map['city'] as String,
      uid: map['uid'] as String,
      birthday: DateTime.fromMillisecondsSinceEpoch(map['birthday'] as int),
      isAdmin: map['isAdmin'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel(firstName: $firstName, lastName: $lastName, patronymic: $patronymic, email: $email, avatar: $avatar, gender: $gender, phone: $phone, city: $city, uid: $uid, birthday: $birthday, isAdmin: $isAdmin)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.patronymic == patronymic &&
        other.email == email &&
        other.avatar == avatar &&
        other.gender == gender &&
        other.phone == phone &&
        other.city == city &&
        other.uid == uid &&
        other.birthday == birthday &&
        other.isAdmin == isAdmin;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        patronymic.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        city.hashCode ^
        uid.hashCode ^
        birthday.hashCode ^
        isAdmin.hashCode;
  }
}
