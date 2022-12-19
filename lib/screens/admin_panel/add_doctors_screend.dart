import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/widgets/app_bars/admin_entry_appbar.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/experience.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/add_doctor_textfield.dart';
import 'package:uuid/uuid.dart';

final selectedItemIndexProvider = StateProvider.autoDispose<int>((ref) => 0);

const List<String> specs = [
  'Хирург',
  'Педиатр',
  'Терапевт',
  'Окулист',
  'Уролог',
  'Дантист',
];

const List<String> cities = [
  'Москва',
  'Уфа',
  'Санкт-Петербург',
  'Казань',
];

class AddDoctorScreen extends ConsumerStatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddDoctorScreenState();
}

class _AddDoctorScreenState extends ConsumerState<AddDoctorScreen> {
  late FixedExtentScrollController _expirienceController;
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController specController = TextEditingController();
  TextEditingController serviceCostController = TextEditingController();

  String clinicId = '';

  File? profileFile;
  Uint8List? profileWebFile;

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          profileWebFile = res.files.first.bytes;
        });
      } else {
        setState(() {
          profileFile = File(res.files.first.path!);
        });
      }
    }
  }

  void addDoctor() {
    String doctorId = const Uuid().v1();
    ref.read(doctorControllerProvider.notifier).createDoctor(
          context,
          Doctor(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            patronymic: patronymicController.text.trim(),
            image: '',
            clinicId: clinicId,
            id: doctorId,
            city: cityValue,
            spec: specValue,
            experience: _expirienceController.selectedItem,
            rating: [0],
            comments: [],
            serviceCost: int.parse(serviceCostController.text.trim()),
          ),
          profileFile,
          profileWebFile,
        );
  }

  @override
  void dispose() {
    super.dispose();
    specController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    patronymicController.dispose();
    serviceCostController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _expirienceController = FixedExtentScrollController();
  }

  String specValue = specs.first;
  String cityValue = cities.first;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final selectedItemIndex = ref.watch(selectedItemIndexProvider);
    final isLoading = ref.watch(doctorControllerProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              addDoctor();
            }
            if (clinicId == '') {
              showSnackBar(context, 'Вы не выбрали клинику!');
            }
          },
          borderRadius: BorderRadius.circular(21),
          child: Container(
            padding: const EdgeInsets.all(8),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(32),
              color: Colors.grey.shade200,
            ),
            child: const Icon(
              Icons.save_rounded,
              size: 42,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Loader()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      children: [
                        const AdminEntryAppBar(title: 'Добавление врача'),
                        InkWell(
                          onTap: () => selectProfileImage(),
                          radius: 60,
                          borderRadius: BorderRadius.circular(60),
                          child: profileWebFile != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: MemoryImage(profileWebFile!),
                                  radius: 85,
                                )
                              : profileFile != null
                                  ? CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      backgroundImage: FileImage(profileFile!),
                                      radius: 85,
                                    )
                                  : CircleAvatar(
                                      backgroundColor: Colors.grey.shade200,
                                      radius: 85,
                                      child: const Icon(
                                        Icons.add_a_photo_rounded,
                                        size: 42,
                                        color: AppTheme.indigoColor,
                                      ),
                                    ),
                        ),
                        AddDoctorTextField(
                          controller: lastNameController,
                          title: 'Фамилия',
                          isNumber: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Введите ФАМИЛИЮ';
                            } else {
                              return null;
                            }
                          },
                        ),
                        AddDoctorTextField(
                          controller: firstNameController,
                          title: 'Имя',
                          isNumber: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Введите ИМЯ';
                            } else {
                              return null;
                            }
                          },
                        ),
                        AddDoctorTextField(
                          controller: patronymicController,
                          title: 'Отчество',
                          isNumber: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Введите ОТЧЕСТВО';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade400,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Специальность',
                                    style: AppTheme.titleTextStyle,
                                  ),
                                  DropdownButton<String>(
                                    value: specValue,
                                    icon: const RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: AppTheme.indigoColor,
                                      ),
                                    ),
                                    elevation: 16,
                                    style: AppTheme.dedicatedIndigoTextStyle,
                                    underline: Container(
                                      height: 2,
                                      color: AppTheme.indigoColor,
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        specValue = value!;
                                      });
                                    },
                                    items: specs.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Опыт работы (лет)',
                              style: AppTheme.dedicatedIndigoTextStyle,
                            ),
                            SizedBox(
                              height: 150,
                              child: SizedBox(
                                width: 70,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _expirienceController,
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 1.2,
                                  onSelectedItemChanged: (value) {
                                    setState(() {
                                      ref
                                          .read(selectedItemIndexProvider
                                              .notifier)
                                          .state = value;
                                    });
                                  },
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 61,
                                    builder: (context, index) {
                                      return Experience(
                                        experience: index,
                                        color: selectedItemIndex == index
                                            ? AppTheme.secondColor
                                            : Colors.grey.shade200,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            AddDoctorTextField(
                              controller: serviceCostController,
                              title: 'Стоимость приема',
                              isNumber: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Введите СТОИМОСТЬ ПРИЕМА';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.grey.shade400,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Укажите город',
                                    style: AppTheme.titleTextStyle,
                                  ),
                                  DropdownButton<String>(
                                    value: cityValue,
                                    icon: const RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Icons.arrow_back_ios_new_outlined,
                                        color: AppTheme.indigoColor,
                                      ),
                                    ),
                                    elevation: 16,
                                    style: AppTheme.dedicatedIndigoTextStyle,
                                    underline: Container(
                                      height: 2,
                                      color: AppTheme.indigoColor,
                                    ),
                                    onChanged: (String? value) {
                                      setState(() {
                                        cityValue = value!;
                                        clinicId = '';
                                      });
                                    },
                                    items: cities.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Выберите клинику',
                                style: AppTheme.dedicatedIndigoTextStyle,
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: ref
                                  .watch(getCityClinicsProvider(cityValue))
                                  .when(
                                    data: (data) {
                                      return Container(
                                        color: Colors.grey.shade200,
                                        child: ListView.builder(
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final clinic = data[index];
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  clinicId = clinic.id;
                                                });
                                              },
                                              child: Card(
                                                elevation: 16,
                                                color: clinicId == clinic.id
                                                    ? AppTheme.secondColor
                                                    : Colors.white,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Center(
                                                    child: Text(
                                                      clinic.address,
                                                      style: AppTheme
                                                          .dedicatedIndigoTextStyle,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}