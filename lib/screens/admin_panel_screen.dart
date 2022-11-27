import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/widgets/cards/admin_panel_menus.dart';
import 'package:healthy_medicine_2/widgets/cards/doctor_card.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:routemaster/routemaster.dart';

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

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen> {
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Панель управления',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
              clinicId == ''
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            clinicId = '';
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 32,
                          color: Colors.red,
                        ),
                      ),
                    ),
            ],
          ),
          clinicId == ''
              ? DropdownButton<String>(
                  value: cityValue,
                  icon: const RotatedBox(
                    quarterTurns: 3,
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Constants.textColor,
                    ),
                  ),
                  dropdownColor: Constants.primaryColor,
                  elevation: 16,
                  style: const TextStyle(
                    color: Constants.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  underline: Container(
                    height: 2,
                    color: Constants.textColor,
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
                      color: Constants.textColor,
                    ),
                  ),
                  dropdownColor: Constants.primaryColor,
                  elevation: 16,
                  style: const TextStyle(
                    color: Constants.textColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                  underline: Container(
                    height: 2,
                    color: Constants.textColor,
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
              : Expanded(
                  child: ref.watch(getDoctorsByClinicIdProvider(clinicId)).when(
                        data: (data) {
                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final doctor = data[index];
                              return spec == 'Все'
                                  ? DoctorsCard(doctor: doctor)
                                  : doctor.spec == spec
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
                      ),
                ),
        ],
      ),
    );
  }
}
