import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/drawers/profile_drawer.dart';
import 'package:healthy_medicine_2/widgets/app_bars/doctor_doctors_appbar.dart';
import 'package:healthy_medicine_2/widgets/screen_widgets/doctors_screen_info_widget.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';

class DoctorsDoctorScreen extends ConsumerWidget {
  const DoctorsDoctorScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDocId = ref.watch(userProvider)!.doctorId;
    return Scaffold(
      endDrawer: const ProfileDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            ref.watch(getDoctorByIdProvider(userDocId)).when(
                  data: (doctor) {
                    return DoctorsScreenInfo(doctor: doctor);
                  },
                  error: ((error, stackTrace) => ErrorText(
                        error: error.toString(),
                      )),
                  loading: () => const Loader(),
                ),
            Builder(builder: (context) {
              return DoctorDoctorsAppBar(
                doctorId: userDocId,
              );
            }),
          ],
        ),
      ),
    );
  }
}
