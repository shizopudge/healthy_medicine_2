import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/models/user_times_model.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/core/type_defs.dart';
import 'package:healthy_medicine_2/core/models/user_model.dart';
import 'package:uuid/uuid.dart';

List<DateTime> firstChangeTimeList = [
  DateTime(1970, 1, 1, 9, 20),
  DateTime(1970, 1, 1, 9, 50),
  DateTime(1970, 1, 1, 10, 20),
  DateTime(1970, 1, 1, 10, 50),
  DateTime(1970, 1, 1, 11, 20),
  DateTime(1970, 1, 1, 11, 50),
  DateTime(1970, 1, 1, 13, 20),
  DateTime(1970, 1, 1, 13, 50),
];

List<DateTime> secondChangeTimeList = [
  DateTime(1970, 1, 1, 14, 20),
  DateTime(1970, 1, 1, 14, 50),
  DateTime(1970, 1, 1, 15, 20),
  DateTime(1970, 1, 1, 15, 50),
  DateTime(1970, 1, 1, 17, 10),
  DateTime(1970, 1, 1, 17, 40),
  DateTime(1970, 1, 1, 18, 10),
  DateTime(1970, 1, 1, 18, 40),
];

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String patronymic,
    String avatar,
    String gender,
    String phone,
    String city,
    DateTime birthday,
  ) async {
    UserCredential userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel = UserModel(
        firstName: firstName,
        lastName: lastName,
        patronymic: patronymic,
        email: email,
        avatar: avatar,
        gender: gender,
        phone: phone,
        city: city,
        uid: userCredential.user!.uid,
        birthday: birthday,
        isAdmin: false,
      );
      await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      String firstChangeTimesId = const Uuid().v1();
      String secondChangeTimesId = const Uuid().v1();
      UserTimes firstChangeTimes = UserTimes(
          isStandart: true,
          times: firstChangeTimeList,
          title: '1 смена',
          id: firstChangeTimesId);
      UserTimes secondChangeTimes = UserTimes(
          isStandart: true,
          times: secondChangeTimeList,
          title: '2 смена',
          id: secondChangeTimesId);
      await _users
          .doc(userCredential.user!.uid)
          .collection('times')
          .doc(firstChangeTimesId)
          .set(firstChangeTimes.toMap());
      await _users
          .doc(userCredential.user!.uid)
          .collection('times')
          .doc(secondChangeTimesId)
          .set(secondChangeTimes.toMap());
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signIn(
    String email,
    String password,
  ) async {
    UserCredential userCredential;
    try {
      UserModel userModel;
      userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userModel = await getUserData(userCredential.user!.uid).first;

      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  void logOut() async {
    await _auth.signOut();
  }
}
