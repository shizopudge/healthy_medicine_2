import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/widgets/app_bars/doctors_appbar.dart';
import 'package:healthy_medicine_2/widgets/screen_widgets/doctors_screen_info_widget.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';

class DoctorScreen extends ConsumerWidget {
  final String doctorId;
  const DoctorScreen({
    super.key,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ref.watch(getDoctorByIdProvider(doctorId)).when(
                  data: (doctor) {
                    return DoctorsScreenInfo(doctor: doctor);
                  },
                  error: ((error, stackTrace) => ErrorText(
                        error: error.toString(),
                      )),
                  loading: () => const Loader(),
                ),
            DoctorsAppBar(
              doctorId: doctorId,
            ),
          ],
        ),
      ),
    );
  }
}
