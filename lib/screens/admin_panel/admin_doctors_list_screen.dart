import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/widgets/cards/doctor_card.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/lists/doctors.dart';
import 'package:routemaster/routemaster.dart';

const List<String> specs = [
  'Все',
  'Хирург',
  'Окулист',
  'Терапевт',
  'Педиатр',
  'Дантист',
  'Уролог',
];

class AdminDoctorsListScreen extends ConsumerStatefulWidget {
  final String clinicId;
  const AdminDoctorsListScreen({
    super.key,
    required this.clinicId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminDoctorsListScreenState();
}

class _AdminDoctorsListScreenState
    extends ConsumerState<AdminDoctorsListScreen> {
  void deleteDoctor(Doctor doctor) {
    ref.read(doctorControllerProvider.notifier).deleteDoctor(doctor, context);
  }

  String spec = specs.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Routemaster.of(context).pop(),
          borderRadius: BorderRadius.circular(21),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 24,
            color: AppTheme.indigoColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Выберите врача',
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
              style: AppTheme.headerTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.grey.shade200,
                ),
                padding: const EdgeInsets.all(8),
                child: DropdownButton<String>(
                  value: spec,
                  icon: const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppTheme.indigoColor,
                    ),
                  ),
                  dropdownColor: Colors.grey.shade100,
                  elevation: 16,
                  style: AppTheme.dedicatedIndigoTextStyle,
                  onChanged: (String? value) {
                    setState(() {
                      spec = value!;
                    });
                  },
                  underline: const SizedBox(),
                  items: specs.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              const Gap(15),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(32),
                    gradient: AppTheme.gradientIndigoToRed,
                  ),
                  child: const Icon(
                    Icons.search,
                    size: 36,
                  ),
                ),
              ),
            ],
          ),
          spec == 'Все'
              ? Expanded(
                  child: ref
                      .watch(getDoctorsByClinicIdProvider(widget.clinicId))
                      .when(
                        data: ((data) {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final doctor = data[index];
                              return Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) =>
                                            deleteDoctor(doctor),
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        borderRadius: BorderRadius.circular(21),
                                        label: 'Удалить',
                                      ),
                                    ],
                                  ),
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          Clipboard.setData(
                                            ClipboardData(text: doctor.id),
                                          );
                                          showSnackBar(context, 'Скопировано');
                                        },
                                        backgroundColor: Colors.indigo,
                                        foregroundColor: Colors.white,
                                        icon: Icons.copy_rounded,
                                        borderRadius: BorderRadius.circular(12),
                                        label: 'Скопировать DocID',
                                      ),
                                    ],
                                  ),
                                  child: DoctorsCard(doctor: doctor));
                            },
                          );
                        }),
                        error: ((error, stackTrace) => Center(
                              child: ErrorText(
                                error: error.toString(),
                              ),
                            )),
                        loading: () => const Loader(),
                      ),
                )
              : Expanded(
                  child: Doctors(clinicId: widget.clinicId, spec: spec),
                ),
        ],
      ),
    );
  }
}
