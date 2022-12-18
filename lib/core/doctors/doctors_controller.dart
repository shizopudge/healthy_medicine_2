import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/models/user_times_model.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_repository.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/models/date_entry_model.dart';

class MyParameter2 extends Equatable {
  const MyParameter2({
    required this.monthNumber,
    required this.doctorId,
    required this.year,
    required this.day,
  });

  final String doctorId;
  final int monthNumber;
  final int year;
  final int day;

  @override
  List<Object> get props => [doctorId, monthNumber, year, day];
}

final getEntryCellsByMonthAndYearProvider = StreamProvider.autoDispose
    .family<List<DateTimeEntryModel>, MyParameter2>((ref, myParameter) {
  final reviewController = ref.watch(doctorControllerProvider.notifier);
  return reviewController.getEntryCellsByMonthAndYear(myParameter.doctorId,
      myParameter.monthNumber, myParameter.year, myParameter.day);
});

final doctorControllerProvider =
    StateNotifierProvider<DoctorController, bool>((ref) {
  final doctorRepository = ref.watch(doctorRepositoryProvider);
  return DoctorController(
    doctorRepository: doctorRepository,
    ref: ref,
  );
});

final getDoctorByIdProvider = StreamProvider.family((ref, String doctorId) {
  final doctorController = ref.watch(doctorControllerProvider.notifier);
  return doctorController.getDoctorById(doctorId);
});

final getDoctorsByClinicIdProvider =
    StreamProvider.family((ref, String clinicId) {
  return ref
      .watch(doctorControllerProvider.notifier)
      .getDoctorsByClinicId(clinicId);
});

// final getEntryCellsProvider = StreamProvider.family((ref, String doctorId) {
//   final doctorController = ref.watch(doctorControllerProvider.notifier);
//   return doctorController.getEntryCells(doctorId);
// });

// final getEntryTimeCellsProvider = StreamProvider.family((ref, String dateId) {
//   final doctorController = ref.watch(doctorControllerProvider.notifier);
//   return doctorController.getEntryTimeCells(dateId);
// });

// final getEntryCellsProvider = StreamProvider.family((ref, String doctorId) {
//   final doctorController = ref.watch(doctorControllerProvider.notifier);
//   return doctorController.getEntryCells(doctorId);
// });

class DoctorController extends StateNotifier<bool> {
  final DoctorRepository _doctorRepository;
  final Ref _ref;
  DoctorController({
    required DoctorRepository doctorRepository,
    required Ref ref,
  })  : _doctorRepository = doctorRepository,
        _ref = ref,
        super(false);

  Stream<List<Doctor>> getDoctorsByClinicId(String clinicId) {
    return _doctorRepository.getDoctorsByClinicId(clinicId);
  }

  Stream<Doctor> getDoctorById(String doctorId) {
    return _doctorRepository.getDoctorById(doctorId);
  }

  // Stream<List<DateModel>> getEntryCells(String doctorId) {
  //   return _doctorRepository.getEntryCells(doctorId);
  // }

  // Stream<List<TimeModel>> getEntryTimeCells(String dateId) {
  //   return _doctorRepository.getEntryTimeCells(dateId);
  // }

  // Stream<List<DateTimeEntryModel>> getEntryCells(String doctorId) {
  //   return _doctorRepository.getEntryCells(doctorId);
  // }

  Stream<List<DateTimeEntryModel>> getEntryCellsByMonthAndYear(
      String doctorId, int monthNumber, int year, int day) {
    return _doctorRepository.getEntryCellsByMonthAndYear(
        doctorId, monthNumber, year, day);
  }

  void createEntryCells(
    BuildContext context,
    String doctorId,
    DateTime date,
    List<DateTime> time,
  ) async {
    state = true;
    // String entryId = const Uuid().v1();
    String entryId = '${date.day}.${date.month}.${date.year}';
    DateTimeEntryModel entry = DateTimeEntryModel(
      date: date,
      time: time,
      id: entryId,
      day: date.day,
      month: date.month,
      year: date.year,
    );
    final res = await _doctorRepository.createEntryCell(entry, doctorId);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context,
          'Вы добавили ячейки на ${date.day}/${date.month}/${date.year} записи!');
      // Routemaster.of(context).pop();
    });
  }
}
