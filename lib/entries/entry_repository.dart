import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/core/type_defs.dart';
import 'package:healthy_medicine_2/models/entry_model.dart';

final entryRepositoryProvider = Provider((ref) {
  return EntryRepository(firestore: ref.watch(firestoreProvider));
});

class EntryRepository {
  final FirebaseFirestore _firestore;
  EntryRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _entries =>
      _firestore.collection(FirebaseConstants.entriesCollection);

  CollectionReference get _doctors =>
      _firestore.collection(FirebaseConstants.doctorsCollection);

  FutureVoid createEntry(
    EntryModel entry,
    String doctorId,
    String entryCellId,
  ) async {
    try {
      _doctors.doc(doctorId).collection('entryCells').doc(entryCellId).update({
        'time': FieldValue.arrayRemove([entry.time.millisecondsSinceEpoch]),
      });
      return right(_entries.doc(entry.id).set(entry.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<EntryModel>> getUserEntries(String uid) {
    return _entries
        .where('uid', isEqualTo: uid)
        .orderBy(
          'date',
          descending: false,
        )
        .orderBy(
          'time',
          descending: false,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => EntryModel.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  // void deleteEntryTime(String entryCellId, String time, String doctorId) async {
  //   _doctors.doc(doctorId).collection('entryCells').doc(entryCellId).update({
  //     'time': FieldValue.arrayRemove([time]),
  //   });
  // }
}
