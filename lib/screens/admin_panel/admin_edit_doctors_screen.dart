import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/screens/admin_panel/add_doctors_screen.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/experience.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/edit_doctor_textfield.dart';
import 'package:routemaster/routemaster.dart';

class AdminEditDoctorsScreen extends ConsumerStatefulWidget {
  final String doctorId;
  const AdminEditDoctorsScreen({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminEditDoctorsScreenState();
}

class _AdminEditDoctorsScreenState
    extends ConsumerState<AdminEditDoctorsScreen> {
  late FixedExtentScrollController _expirienceController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController patronymicController;
  late TextEditingController specController;
  late TextEditingController serviceCostController;
  late String spec;
  late String cityValue;
  late String clinicId;
  late String image;
  late List<dynamic> rating;
  late List<String> comments;

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    patronymicController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _expirienceController = FixedExtentScrollController(
        initialItem:
            ref.read(getDoctorByIdProvider(widget.doctorId)).value!.experience);
    firstNameController = TextEditingController(
        text:
            ref.read(getDoctorByIdProvider(widget.doctorId)).value!.firstName);
    lastNameController = TextEditingController(
        text: ref.read(getDoctorByIdProvider(widget.doctorId)).value!.lastName);
    patronymicController = TextEditingController(
        text:
            ref.read(getDoctorByIdProvider(widget.doctorId)).value!.patronymic);
    specController = TextEditingController(
        text: ref.read(getDoctorByIdProvider(widget.doctorId)).value!.spec);
    serviceCostController = TextEditingController(
        text: ref
            .read(getDoctorByIdProvider(widget.doctorId))
            .value!
            .serviceCost
            .toString());
    spec = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.spec;
    cityValue = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.city;
    clinicId = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.clinicId;
    rating =
        ref.read(getDoctorByIdProvider(widget.doctorId)).value!.rating.toList();
    comments = ref
        .read(getDoctorByIdProvider(widget.doctorId))
        .value!
        .comments
        .toList();
    image = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.image;
  }

  bool isPicPicked = false;

  File? profileFile;
  Uint8List? profileWebFile;

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      if (kIsWeb) {
        setState(() {
          profileWebFile = res.files.first.bytes;
          isPicPicked = true;
          isChanged = true;
        });
      } else {
        setState(() {
          profileFile = File(res.files.first.path!);
          isPicPicked = true;
          isChanged = true;
        });
      }
    }
  }

  void editDoctor() {
    ref.read(doctorControllerProvider.notifier).editDoctor(
        profileFile: profileFile,
        profileWebFile: profileWebFile,
        context: context,
        doctor: Doctor(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            patronymic: patronymicController.text.trim(),
            image: image,
            clinicId: clinicId,
            id: widget.doctorId,
            city: cityValue,
            spec: spec,
            experience: _expirienceController.selectedItem,
            rating: rating,
            comments: comments,
            serviceCost: int.parse(serviceCostController.text.trim())),
        isPicPicked: isPicPicked);
  }

  bool isChanged = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(doctorControllerProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: isChanged
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate() &&
                      isChanged == true &&
                      clinicId != '') {
                    _formKey.currentState!.save();
                    editDoctor();
                  } else if (clinicId == '') {
                    showSnackBar(context, 'Вы не выбрали клинику');
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
            )
          : null,
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
        centerTitle: true,
        title: Text(
          'Редактирование врача',
          style: AppTheme.dedicatedIndigoTextStyle,
        ),
      ),
      body: isLoading
          ? const Loader()
          : Form(
              key: _formKey,
              child: ref.watch(getDoctorByIdProvider(widget.doctorId)).when(
                    data: (doctor) {
                      return SingleChildScrollView(
                        child: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => selectProfileImage(),
                                  radius: 60,
                                  borderRadius: BorderRadius.circular(60),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: doctor.image != '' &&
                                            profileWebFile == null &&
                                            profileFile == null
                                        ? Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage:
                                                    NetworkImage(doctor.image),
                                                backgroundColor:
                                                    Colors.grey.shade100,
                                                radius: 90,
                                              ),
                                              const Positioned(
                                                right: 10,
                                                top: 10,
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 36,
                                                ),
                                              ),
                                            ],
                                          )
                                        : profileWebFile != null
                                            ? Stack(
                                                alignment: Alignment.topRight,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                    backgroundImage:
                                                        MemoryImage(
                                                            profileWebFile!),
                                                    radius: 85,
                                                  ),
                                                  const Positioned(
                                                    right: 10,
                                                    top: 10,
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 36,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : profileFile != null
                                                ? Stack(
                                                    alignment:
                                                        Alignment.topRight,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: Colors
                                                            .grey.shade200,
                                                        backgroundImage:
                                                            FileImage(
                                                                profileFile!),
                                                        radius: 85,
                                                      ),
                                                      const Positioned(
                                                        right: 10,
                                                        top: 10,
                                                        child: Icon(
                                                          Icons.edit,
                                                          size: 36,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey.shade200,
                                                    radius: 85,
                                                    child: const Icon(
                                                      Icons.add_a_photo_rounded,
                                                      size: 42,
                                                      color:
                                                          AppTheme.indigoColor,
                                                    ),
                                                  ),
                                  ),
                                ),
                                EditDoctorTextField(
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
                                  onChanged: ((value) {
                                    setState(() {
                                      isChanged = true;
                                    });
                                  }),
                                ),
                                EditDoctorTextField(
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
                                  onChanged: ((value) {
                                    setState(() {
                                      isChanged = true;
                                    });
                                  }),
                                ),
                                EditDoctorTextField(
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
                                  onChanged: ((value) {
                                    setState(() {
                                      isChanged = true;
                                    });
                                  }),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                                Text(
                                  'Опыт работы',
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
                                      diameterRatio: 1.1,
                                      onSelectedItemChanged: (value) {
                                        setState(() {
                                          ref
                                              .read(selectedItemIndexProvider
                                                  .notifier)
                                              .state = value;
                                          isChanged = true;
                                        });
                                      },
                                      physics: const FixedExtentScrollPhysics(),
                                      childDelegate:
                                          ListWheelChildBuilderDelegate(
                                        childCount: 61,
                                        builder: (context, index) {
                                          return Experience(
                                            experience: index,
                                            color: _expirienceController
                                                        .selectedItem ==
                                                    index
                                                ? AppTheme.secondColor
                                                : Colors.grey.shade200,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                                EditDoctorTextField(
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
                                  onChanged: ((value) {
                                    setState(() {
                                      isChanged = true;
                                    });
                                  }),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Специальность',
                                        style: AppTheme.titleTextStyle,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                            color: Colors.grey.shade200,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: DropdownButton<String>(
                                            value: spec,
                                            icon: const RotatedBox(
                                              quarterTurns: 3,
                                              child: Icon(
                                                Icons
                                                    .arrow_back_ios_new_outlined,
                                                color: AppTheme.indigoColor,
                                              ),
                                            ),
                                            dropdownColor: Colors.grey.shade100,
                                            elevation: 16,
                                            style: AppTheme
                                                .dedicatedIndigoTextStyle,
                                            onChanged: (String? value) {
                                              setState(() {
                                                spec = value!;
                                                isChanged = true;
                                              });
                                            },
                                            underline: const SizedBox(),
                                            items: specs
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Город',
                                        style: AppTheme.titleTextStyle,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                            color: Colors.grey.shade200,
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: DropdownButton<String>(
                                            value: cityValue,
                                            icon: const RotatedBox(
                                              quarterTurns: 3,
                                              child: Icon(
                                                Icons
                                                    .arrow_back_ios_new_outlined,
                                                color: AppTheme.indigoColor,
                                              ),
                                            ),
                                            elevation: 16,
                                            style: AppTheme
                                                .dedicatedIndigoTextStyle,
                                            onChanged: (String? value) {
                                              setState(() {
                                                cityValue = value!;
                                                isChanged = true;
                                                clinicId = '';
                                              });
                                            },
                                            underline: const SizedBox(),
                                            items: cities
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Colors.grey.shade300,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Клиника',
                                    style: AppTheme.dedicatedIndigoTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 180,
                                  child: ref
                                      .watch(getCityClinicsProvider(cityValue))
                                      .when(
                                        data: (data) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                            ),
                                            margin: const EdgeInsets.all(8),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListView.builder(
                                                itemCount: data.length,
                                                itemBuilder:
                                                    (BuildContext context,
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
                                                      color: clinicId ==
                                                              clinic.id
                                                          ? AppTheme.secondColor
                                                          : Colors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
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
                          ),
                        ),
                      );
                    },
                    error: ((error, stackTrace) => ErrorText(
                          error: error.toString(),
                        )),
                    loading: (() => const Loader()),
                  ),
            ),
    );
  }
}
