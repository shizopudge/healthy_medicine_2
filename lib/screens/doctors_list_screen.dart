import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/common/doctors.dart';
import 'package:healthy_medicine_2/core/common/error_text.dart';
import 'package:healthy_medicine_2/core/common/loader.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class DoctorsListScreen extends ConsumerStatefulWidget {
  final String spec;
  final String clinic;
  const DoctorsListScreen({
    super.key,
    required this.spec,
    required this.clinic,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends ConsumerState<DoctorsListScreen> {
  String docSpec = '';

  getSpec() {
    switch (widget.spec) {
      case 'Surgeon':
        docSpec = 'Хирург';
        break;
      case 'Ophtalmologyst':
        docSpec = 'Окулист';
        break;
      case 'Urologist':
        docSpec = 'Уролог';
        break;
      case 'Therapist':
        docSpec = 'Терапевт';
        break;
      case 'Pediatrician':
        docSpec = 'Педиатр';
        break;
      case 'Dentist':
        docSpec = 'Дантист';
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    getSpec();
  }

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              ref.watch(getClinicByIdProvider(widget.clinic)).when(
                    data: (clinic) {
                      return Text(
                        clinic.address,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Constants.textColor,
                          fontSize: 22,
                        ),
                      );
                    },
                    error: ((error, stackTrace) => Center(
                          child: ErrorText(
                            error: error.toString(),
                          ),
                        )),
                    loading: () => const Loader(),
                  ),
              const Gap(25),
              const Text(
                'Выберите врача',
                style: TextStyle(
                  color: Constants.textColor,
                  fontSize: 36,
                ),
              ),
              Expanded(
                child: Doctors(
                  clinicId: widget.clinic,
                  spec: docSpec,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
