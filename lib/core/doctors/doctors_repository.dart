import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/core/type_defs.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/models/date_entry_model.dart';

final doctorRepositoryProvider = Provider((ref) {
  return DoctorRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class DoctorRepository {
  final FirebaseFirestore _firestore;
  DoctorRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _doctors =>
      _firestore.collection(FirebaseConstants.doctorsCollection);

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

  Stream<List<Doctor>> getDoctorsByClinicIdAndSpec(
      String clinicId, String spec) {
    return _doctors
        .where('clinicId', isEqualTo: clinicId)
        .where('spec', isEqualTo: spec)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Doctor.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<List<Doctor>> getDoctors() {
    return _doctors.snapshots().map(
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

  FutureVoid createDoctor(Doctor doctor) async {
    try {
      return right(_doctors.doc(doctor.id).set(doctor.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
      // throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid editDoctor(Doctor doctor) async {
    try {
      return right(_doctors.doc(doctor.id).update(doctor.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deleteDoctor(Doctor doctor) async {
    try {
      final batch = _firestore.batch();
      var collection = _doctors
          .doc(doctor.id)
          .collection(FirebaseConstants.entryCellsCollection);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      batch.commit();
      return right(_doctors.doc(doctor.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
