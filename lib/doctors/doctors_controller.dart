import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/doctors/doctors_repository.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';
import 'package:healthy_medicine_2/models/entry_date_time_model.dart';

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

final getEntryCellsProvider = StreamProvider.family((ref, String doctorId) {
  final doctorController = ref.watch(doctorControllerProvider.notifier);
  return doctorController.getEntryCells(doctorId);
});

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

  Stream<List<EntryDateTimeModel>> getEntryCells(String doctorId) {
    return _doctorRepository.getEntryCells(doctorId);
  }
}
