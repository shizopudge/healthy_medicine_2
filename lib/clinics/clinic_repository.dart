import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/models/clinic_model.dart';

final clinicRepositoryProvider = Provider((ref) {
  return ClinicRepository(firestore: ref.watch(firestoreProvider));
});

class ClinicRepository {
  final FirebaseFirestore _firestore;
  ClinicRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _clinics =>
      _firestore.collection(FirebaseConstants.clinicsCollection);

  Stream<List<Clinic>> getCityClinics(String city) {
    return _clinics.where('city', isEqualTo: city).snapshots().map(
          (event) => event.docs
              .map(
                (e) => Clinic.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  Stream<Clinic> getClinicById(String clinicId) {
    return _clinics
        .doc(clinicId)
        .snapshots()
        .map((event) => Clinic.fromMap(event.data() as Map<String, dynamic>));
  }

  // Stream<List<Clinic>> getUserCommunities(String city) {
  //   return _clinics.where('city', isEqualTo: city).snapshots().map((event) {
  //     List<Clinic> clinics = [];
  //     for (var doc in event.docs) {
  //       clinics.add(Clinic.fromMap(doc.data() as Map<String, dynamic>));
  //     }
  //     return clinics;
  //   });
  // }
}
