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
    required this.descendingType,
  });

  final String uid;
  final int limit;
  final bool descendingType;

  @override
  List<Object> get props => [uid, limit, descendingType];
}

final entryControllerProvider =
    StateNotifierProvider<EntryController, bool>((ref) {
  final entryRepository = ref.watch(entryRepositoryProvider);
  return EntryController(
    entryRepository: entryRepository,
    ref: ref,
  );
});

final getAllUserEntriesProvider = StreamProvider.autoDispose
    .family<List<EntryModel>, UserEntriesParameters>((ref, parametr) {
  final entryController = ref.watch(entryControllerProvider.notifier);
  return entryController.getAllUserEntries(
      parametr.uid, parametr.limit, parametr.descendingType);
});

final getComingInTimeUserEntriesProvider = StreamProvider.autoDispose
    .family<List<EntryModel>, UserEntriesParameters>((ref, parametr) {
  final entryController = ref.watch(entryControllerProvider.notifier);
  return entryController.getComingInTimeUserEntries(
      parametr.uid, parametr.limit, parametr.descendingType);
});

final getUpcomingUserEntriesProvider = StreamProvider.autoDispose
    .family<List<EntryModel>, UserEntriesParameters>((ref, parametr) {
  final entryController = ref.watch(entryControllerProvider.notifier);
  return entryController.getUpcomingUserEntries(
      parametr.uid, parametr.limit, parametr.descendingType);
});

final getPastUserEntriesProvider = StreamProvider.autoDispose
    .family<List<EntryModel>, UserEntriesParameters>((ref, parametr) {
  final entryController = ref.watch(entryControllerProvider.notifier);
  return entryController.getPastUserEntries(
      parametr.uid, parametr.limit, parametr.descendingType);
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

  void createEntry(Doctor doctor, DateTime dateTime, DateTime exTime,
      DateTime exDate, String entryCellId, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    String entryId = const Uuid().v1();
    EntryModel entry = EntryModel(
      clinicId: doctor.clinicId,
      dateTime: dateTime,
      exTime: exTime,
      exDate: exDate,
      doctorImage: doctor.image,
      doctorLastName: doctor.lastName,
      doctorFirstName: doctor.firstName,
      doctorPatronymic: doctor.patronymic,
      doctorSpec: doctor.spec,
      serviceCost: doctor.serviceCost,
      doctorId: doctor.id,
      id: entryId,
      uid: uid,
    );
    final res =
        await _entryRepository.createEntry(entry, doctor.id, entryCellId);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context,
          'Вы записались на прием ${dateTime.day}/${dateTime.month}/${dateTime.year} в ${dateTime.hour}:${dateTime.minute}!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<EntryModel>> getAllUserEntries(
      String uid, int limit, bool descendingType) {
    return _entryRepository.getAllUserEntries(uid, limit, descendingType);
  }

  Stream<List<EntryModel>> getComingInTimeUserEntries(
      String uid, int limit, bool descendingType) {
    return _entryRepository.getComingInTimeUserEntries(
        uid, limit, descendingType);
  }

  Stream<List<EntryModel>> getUpcomingUserEntries(
      String uid, int limit, bool descendingType) {
    return _entryRepository.getUpcomingUserEntries(uid, limit, descendingType);
  }

  Stream<List<EntryModel>> getPastUserEntries(
      String uid, int limit, bool descendingType) {
    return _entryRepository.getPastUserEntries(uid, limit, descendingType);
  }
}
