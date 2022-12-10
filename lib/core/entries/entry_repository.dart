import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';
import 'package:healthy_medicine_2/core/firebase_constants.dart';
import 'package:healthy_medicine_2/core/providers/firebase_providers.dart';
import 'package:healthy_medicine_2/core/type_defs.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';

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
        'time': FieldValue.arrayRemove([
          DateTime(0, 0, 0, entry.dateTime.hour, entry.dateTime.minute, 0)
              .millisecondsSinceEpoch
        ]),
      });
      return right(_entries.doc(entry.id).set(entry.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<EntryModel>> getAllUserEntries(
      String uid, int limit, bool descendingType) {
    return _entries
        .limit(limit)
        .where('uid', isEqualTo: uid)
        .orderBy(
          'dateTime',
          descending: descendingType,
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

  Stream<List<EntryModel>> getComingInTimeUserEntries(
      String uid, int limit, bool descendingType) {
    return _entries
        .limit(limit)
        .where('uid', isEqualTo: uid)
        .where('exDate',
            isEqualTo: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 0, 0, 0)
                .millisecondsSinceEpoch)
        .where(
          'exTime',
          isGreaterThanOrEqualTo:
              DateTime(0, 0, 0, DateTime.now().hour, DateTime.now().minute, 0)
                  .millisecondsSinceEpoch,
        )
        .orderBy(
          'exTime',
          descending: descendingType,
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

  Stream<List<EntryModel>> getUpcomingUserEntries(
      String uid, int limit, bool descendingType) {
    return _entries
        .limit(limit)
        .where('uid', isEqualTo: uid)
        .where('exDate',
            isGreaterThan: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 0, 0, 0)
                .millisecondsSinceEpoch)
        .orderBy(
          'exDate',
          descending: descendingType,
        )
        .orderBy(
          'exTime',
          descending: descendingType,
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

  Stream<List<EntryModel>> getPastUserEntries(
      String uid, int limit, bool descendingType) {
    return _entries
        .limit(limit)
        .where('uid', isEqualTo: uid)
        .where('dateTime', isLessThan: DateTime.now().millisecondsSinceEpoch)
        .orderBy(
          'dateTime',
          descending: descendingType,
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
}
