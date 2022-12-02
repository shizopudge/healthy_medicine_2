import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/widgets/app_bars/top_appbar.dart';
import 'package:healthy_medicine_2/widgets/lists/doctors.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            children: [
              TopAppBar(onSearchTap: () {}, title: 'Выберите врача'),
              ref.watch(getClinicByIdProvider(widget.clinic)).when(
                    data: (clinic) {
                      return Text(
                        clinic.address,
                        textAlign: TextAlign.left,
                        style: AppTheme.titleTextStyle,
                      );
                    },
                    error: ((error, stackTrace) => Center(
                          child: ErrorText(
                            error: error.toString(),
                          ),
                        )),
                    loading: () => const Loader(),
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
