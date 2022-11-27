import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/widgets/screen_widgets/doctors_screen_info_widget.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:routemaster/routemaster.dart';

class DoctorScreen extends ConsumerStatefulWidget {
  final String doctorId;
  const DoctorScreen({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends ConsumerState<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bg,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ref.watch(getDoctorByIdProvider(widget.doctorId)).when(
          data: (doctor) {
            return DoctorsScreenInfo(doctor: doctor);
          },
          error: ((error, stackTrace) => ErrorText(error: error.toString())),
          loading: () => const Loader()),
    );
  }
}
