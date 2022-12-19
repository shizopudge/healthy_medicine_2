import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/widgets/app_bars/admin_entry_appbar.dart';
import 'package:healthy_medicine_2/widgets/cards/admin_panel_menus.dart';
import 'package:healthy_medicine_2/widgets/cards/doctor_card.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';

const List<String> cities = [
  'Москва',
  'Уфа',
  'Санкт-Петербург',
  'Казань',
];

const List<String> specs = [
  'Все',
  'Хирург',
  'Окулист',
];

class DoctorsAdminPanel extends ConsumerStatefulWidget {
  const DoctorsAdminPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorsAdminPanelState();
}

class _DoctorsAdminPanelState extends ConsumerState<DoctorsAdminPanel> {
  String cityValue = '';
  String spec = specs.first;

  @override
  void initState() {
    super.initState();
    cityValue = ref.read(userProvider)!.city;
  }

  String clinicId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: clinicId != ''
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    clinicId = '';
                    spec = specs.first;
                  });
                },
                child: const Icon(
                  Icons.cancel_rounded,
                  size: 42,
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            const AdminEntryAppBar(title: 'Панель управления врачами'),
            clinicId == ''
                ? DropdownButton<String>(
                    value: cityValue,
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
                    underline: Container(
                      height: 2,
                      color: AppTheme.indigoColor,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        cityValue = value!;
                      });
                    },
                    items: cities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : DropdownButton<String>(
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
                    underline: Container(
                      height: 2,
                      color: AppTheme.indigoColor,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        spec = value!;
                      });
                    },
                    items: specs.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
            clinicId == ''
                ? Expanded(
                    child: ref.watch(getCityClinicsProvider(cityValue)).when(
                          data: (data) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                final clinic = data[index];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      clinicId = clinic.id;
                                    });
                                  },
                                  child: AdminClinicMenuWidget(
                                    clinic: clinic,
                                  ),
                                );
                              },
                            );
                          },
                          error: ((error, stackTrace) => Center(
                                child: ErrorText(
                                  error: error.toString(),
                                ),
                              )),
                          loading: () => const Loader(),
                        ),
                  )
                : spec == 'Все'
                    ? Expanded(
                        child: ref
                            .watch(getDoctorsByClinicIdProvider(clinicId))
                            .when(
                              data: (data) {
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final doctor = data[index];
                                    return DoctorsCard(doctor: doctor);
                                  },
                                );
                              },
                              error: ((error, stackTrace) => Center(
                                    child: ErrorText(
                                      error: error.toString(),
                                    ),
                                  )),
                              loading: () => const Loader(),
                            ),
                      )
                    : Expanded(
                        child: ref
                            .watch(
                              getDoctorsByClinicIdAndSpecProvider(
                                DoctorsParametrs(
                                    clinicId: clinicId, spec: spec),
                              ),
                            )
                            .when(
                              data: (data) {
                                return ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final doctor = data[index];
                                    return DoctorsCard(doctor: doctor);
                                  },
                                );
                              },
                              error: ((error, stackTrace) => Center(
                                    child: ErrorText(
                                      error: error.toString(),
                                    ),
                                  )),
                              loading: () => const Loader(),
                            ),
                      ),
          ],
        ),
      ),
    );
  }
}
