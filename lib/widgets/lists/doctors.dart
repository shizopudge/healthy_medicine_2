import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/widgets/cards/doctor_card.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';

class Doctors extends ConsumerWidget {
  final String clinicId;
  final String spec;
  const Doctors({
    super.key,
    required this.clinicId,
    required this.spec,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //getDoctorsByClinicIdAndSpecProvider
    return ref.watch(getDoctorsByClinicIdProvider(clinicId)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final doctor = data[index];
                return doctor.spec == spec
                    ? DoctorsCard(doctor: doctor)
                    : const SizedBox();
              },
            );
          },
          error: ((error, stackTrace) => Center(
                child: ErrorText(
                  error: error.toString(),
                ),
              )),
          loading: () => const Loader(),
        );
  }
}
