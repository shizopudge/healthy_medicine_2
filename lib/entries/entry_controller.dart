import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/entries/entry_repository.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';
import 'package:healthy_medicine_2/models/entry_model.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

final entryControllerProvider =
    StateNotifierProvider<EntryController, bool>((ref) {
  final entryRepository = ref.watch(entryRepositoryProvider);
  return EntryController(
    entryRepository: entryRepository,
    ref: ref,
  );
});

final getUserEntriesProvider = StreamProvider.family((ref, String uid) {
  final entryController = ref.watch(entryControllerProvider.notifier);
  return entryController.getUserEntries(uid);
});

class EntryController extends StateNotifier<bool> {
  final EntryRepository _entryRepository;
  final Ref _ref;
  EntryController({
    required EntryRepository entryRepository,
    required Ref ref,
  })  : _entryRepository = entryRepository,
        _ref = ref,
        super(false);

  void createEntry(Doctor doctor, String date, String time, String entryCellId,
      BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    String entryId = const Uuid().v1();
    EntryModel entry = EntryModel(
      clinicId: doctor.clinicId,
      date: date,
      doctorImage: doctor.image,
      doctorLastName: doctor.lastName,
      doctorFirstName: doctor.firstName,
      doctorPatronymic: doctor.patronymic,
      doctorSpec: doctor.spec,
      serviceCost: doctor.serviceCost,
      doctorId: doctor.id,
      id: entryId,
      time: time,
      uid: uid,
    );
    final res =
        await _entryRepository.createEntry(entry, doctor.id, entryCellId);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Вы записались на прием!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<EntryModel>> getUserEntries(String uid) {
    return _entryRepository.getUserEntries(uid);
  }

  // void deleteEntryTime(String entryCellId, String time, String doctorId) async {
  //   _entryRepository.deleteEntryTime(entryCellId, time, doctorId);
  // }
}
