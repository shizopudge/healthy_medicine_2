import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';

final doctorRepositoryProvider = Provider((ref) {
  return DoctorRepository(firestore: ref.watch(firestoreProvider));
});

class DoctorRepository {
  final FirebaseFirestore _firestore;
  DoctorRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

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

  Stream<Doctor> getDoctorById(String doctorId) {
    return _doctors
        .doc(doctorId)
        .snapshots()
        .map((event) => Doctor.fromMap(event.data() as Map<String, dynamic>));
  }
}
