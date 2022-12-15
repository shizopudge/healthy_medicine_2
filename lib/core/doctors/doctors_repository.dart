import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/models/user_times_model.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/core/type_defs.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/models/date_entry_model.dart';

final doctorRepositoryProvider = Provider((ref) {
  return DoctorRepository(firestore: ref.watch(firestoreProvider));
});

class DoctorRepository {
  final FirebaseFirestore _firestore;
  DoctorRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _doctors =>
      _firestore.collection(FirebaseConstants.doctorsCollection);
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<List<Doctor>> getDoctorsByClinicId(String clinicId) {
    return _doctors.where('clinicId', isEqualTo: clinicId).snapshots().map(
          (event) => event.docs
              .map(
                (e) => Doctor.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<Doctor> getDoctorById(String doctorId) {
    return _doctors
        .doc(doctorId)
        .snapshots()
        .map((event) => Doctor.fromMap(event.data() as Map<String, dynamic>));
  }

  // Stream<List<DateTimeEntryModel>> getEntryCells(String doctorId) {
  //   return _doctors
  //       .doc(doctorId)
  //       .collection(FirebaseConstants.entryCellsCollection)
  //       .orderBy(
  //         'date',
  //         descending: false,
  //       )
  //       .snapshots()
  //       .map(
  //         (event) => event.docs
  //             .map(
  //               (e) => DateTimeEntryModel.fromMap(
  //                 e.data(),
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

//ПОКА ПРОСТО МЫСЛИ
  Stream<List<DateTimeEntryModel>> getEntryCellsByMonthAndYear(
      String doctorId, int monthNumber, int year, int day) {
    return _doctors
        .doc(doctorId)
        .collection(FirebaseConstants.entryCellsCollection)
        .where('month', isEqualTo: monthNumber)
        .where('year', isEqualTo: year)
        .where('day', isGreaterThan: day)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => DateTimeEntryModel.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  FutureVoid createEntryCell(DateTimeEntryModel entry, String doctorId) async {
    try {
      var entryCellDoc = await _doctors
          .doc(doctorId)
          .collection(FirebaseConstants.entryCellsCollection)
          .doc(entry.id)
          .get();
      if (entryCellDoc.exists) {
        _doctors
            .doc(doctorId)
            .collection(FirebaseConstants.entryCellsCollection)
            .doc(entry.id)
            .delete();
      }
      return right(_doctors
          .doc(doctorId)
          .collection(FirebaseConstants.entryCellsCollection)
          .doc(entry.id)
          .set(entry.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
      // throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<UserTimes>> getUserTimes(String uid) {
    return _users.doc(uid).collection('times').snapshots().map(
          (event) => event.docs
              .map(
                (e) => UserTimes.fromMap(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  // Stream<List<DateModel>> getEntryCells(String doctorId) {
  //   return _entryCells.where('doctorId', isEqualTo: doctorId).snapshots().map(
  //         (event) => event.docs
  //             .map(
  //               (e) => DateModel.fromMap(
  //                 e.data() as Map<String, dynamic>,
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

  // Stream<List<TimeModel>> getEntryTimeCells(String dateId) {
  //   return _entryCells
  //       .doc(dateId)
  //       .collection(FirebaseConstants.entryCellTimeCollection)
  //       .where('isAvailable', isEqualTo: true)
  //       .snapshots()
  //       .map(
  //         (event) => event.docs
  //             .map(
  //               (e) => TimeModel.fromMap(
  //                 e.data(),
  //               ),
  //             )
  //             .toList(),
  //       );
  // }

}
