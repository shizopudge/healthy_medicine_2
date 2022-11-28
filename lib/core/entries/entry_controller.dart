import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/core/entries/entry_repository.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

class UserEntriesParameters extends Equatable {
  const UserEntriesParameters({
    required this.limit,
    required this.uid,
  });

  final String uid;
  final int limit;

  @override
  List<Object> get props => [uid, limit];
}

final entryControllerProvider =
    StateNotifierProvider<EntryController, bool>((ref) {
  final entryRepository = ref.watch(entryRepositoryProvider);
  return EntryController(
    entryRepository: entryRepository,
    ref: ref,
  );
});

final getUserEntriesProvider = StreamProvider.autoDispose
    .family<List<EntryModel>, UserEntriesParameters>((ref, parametr) {
  final entryController = ref.watch(entryControllerProvider.notifier);
  return entryController.getUserEntries(parametr.uid, parametr.limit);
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

  void createEntry(Doctor doctor, DateTime date, DateTime time,
      String entryCellId, BuildContext context) async {
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
      showSnackBar(context,
          'Вы записались на прием ${date.day}/${date.month}/${date.year} в ${time.hour}:${time.minute}!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<EntryModel>> getUserEntries(String uid, int limit) {
    return _entryRepository.getUserEntries(uid, limit);
  }
}
