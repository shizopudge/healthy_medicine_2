import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/clinics/clinic_repository.dart';
import 'package:healthy_medicine_2/core/models/clinic_model.dart';

final clinicControllerProvider =
    StateNotifierProvider<ClinicController, bool>((ref) {
  final clinicRepository = ref.watch(clinicRepositoryProvider);
  return ClinicController(
    clinicRepository: clinicRepository,
    ref: ref,
  );
});

final getCityClinicsProvider = StreamProvider.family((ref, String city) {
  return ref.watch(clinicControllerProvider.notifier).getCityClinics(city);
});

final getClinicByIdProvider = StreamProvider.family((ref, String clinicId) {
  final clinicController = ref.watch(clinicControllerProvider.notifier);
  return clinicController.getClinicById(clinicId);
});

class ClinicController extends StateNotifier<bool> {
  final ClinicRepository _clinicRepository;
  final Ref _ref;
  ClinicController({
    required ClinicRepository clinicRepository,
    required Ref ref,
  })  : _clinicRepository = clinicRepository,
        _ref = ref,
        super(false);

  Stream<List<Clinic>> getCityClinics(String city) {
    return _clinicRepository.getCityClinics(city);
  }

  Stream<Clinic> getClinicById(String clinicId) {
    return _clinicRepository.getClinicById(clinicId);
  }
}
