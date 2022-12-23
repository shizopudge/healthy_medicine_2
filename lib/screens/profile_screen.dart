import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/models/user_model.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/widgets/app_bars/profile_appbar.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/profile_info_widget.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/profile_text_field.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late TextEditingController emailController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController patronymicController;
  late TextEditingController phoneController;
  late String avatar;
  late String city;
  late String uid;
  late String password;
  late DateTime birthday;
  late String gender;
  late bool isMale;
  late bool isFemale;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    patronymicController.dispose();
    phoneController.dispose();
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

  @override
  void initState() {
    super.initState();
    emailController =
        TextEditingController(text: ref.read(userProvider)!.email);
    firstNameController =
        TextEditingController(text: ref.read(userProvider)!.firstName);
    lastNameController =
        TextEditingController(text: ref.read(userProvider)!.lastName);
    patronymicController =
        TextEditingController(text: ref.read(userProvider)!.patronymic);
    phoneController =
        TextEditingController(text: ref.read(userProvider)!.phone);
    gender = ref.read(userProvider)!.gender;
    if (gender == 'M') {
      isMale = true;
      isFemale = false;
    } else {
      isFemale = true;
      isMale = false;
    }
    avatar = ref.read(userProvider)!.avatar;
    city = ref.read(userProvider)!.city;
    uid = ref.read(userProvider)!.uid;
    password = ref.read(userProvider)!.password;
    birthday = ref.read(userProvider)!.birthday;
  }

  void editUser() {
    ref.read(authControllerProvider.notifier).editUser(
        profileFile: profileFile,
        profileWebFile: profileWebFile,
        context: context,
        user: UserModel(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            patronymic: patronymicController.text.trim(),
            email: emailController.text.trim(),
            avatar: avatar,
            gender: gender,
            phone: phoneController.text.trim(),
            city: city,
            uid: uid,
            password: password,
            birthday: birthday,
            isAdmin: false,
            isDoctor: false,
            doctorId: ''),
        isPicPicked: isPicPicked);
  }

  bool isChanged = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: isChanged
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && isChanged == true) {
                    _formKey.currentState!.save();
                    isChanged = false;
                    editUser();
                  }
                },
                child: Text(
                  'Изменить',
                  style: AppTheme.defaultIngidgoText.copyWith(fontSize: 16),
                ),
              ),
            )
          : null,
      body: isLoading
          ? const Loader()
          : ref.watch(getUserDataProvider(widget.uid)).when(
                data: (user) {
                  return Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: Column(
                            children: [
                              const ProfileAppBar(
                                text: 'Профиль',
                              ),
                              InkWell(
                                onTap: () => selectProfileImage(),
                                radius: 60,
                                borderRadius: BorderRadius.circular(60),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: user.avatar != '' &&
                                          profileWebFile == null &&
                                          profileFile == null
                                      ? Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(user.avatar),
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
                                                  backgroundImage: MemoryImage(
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
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey.shade200,
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
                                              : Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage:
                                                          const AssetImage(
                                                              Constants
                                                                  .avatarDefault),
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
                                                ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Основные сведения',
                                  style: AppTheme.dedicatedIndigoTextStyle
                                      .copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              ProfileTextField(
                                controller: firstNameController,
                                title: 'Имя',
                                func: (value) {
                                  setState(() {
                                    isChanged = true;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Введите ИМЯ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              ProfileTextField(
                                controller: lastNameController,
                                title: 'Фамилия',
                                func: (value) {
                                  setState(() {
                                    isChanged = true;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Введите ФАМИЛИЮ';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              ProfileTextField(
                                controller: patronymicController,
                                title: 'Отчество',
                                func: (value) {
                                  setState(() {
                                    isChanged = true;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Введите ОТЧЕСТВО';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              // ProfileInfoWidget(
                              //     title: 'День рождения',
                              //     text: '${ref.read(userProvider)!.birthday.year}-'
                              //         '${ref.read(userProvider)!.birthday.month}-'
                              //         '${ref.read(userProvider)!.birthday.day}'),
                              // ProfileInfoWidget(
                              //   text: user.city,
                              //   title: 'Город',
                              // ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Ваш пол',
                                      style: AppTheme.titleTextStyle.copyWith(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isMale = true;
                                              isFemale = false;
                                              gender = 'M';
                                              isChanged = true;
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: isMale
                                                ? Colors.indigo
                                                : Colors.grey.shade400,
                                            radius: 42,
                                            child: const Icon(
                                              Icons.male,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isFemale = true;
                                              isMale = false;
                                              gender = 'F';
                                              isChanged = true;
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: isFemale
                                                ? Colors.indigo
                                                : Colors.grey.shade400,
                                            radius: 42,
                                            child: const Icon(
                                              Icons.female,
                                              size: 50,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(15),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Контактные данные',
                                  style: AppTheme.dedicatedIndigoTextStyle
                                      .copyWith(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              ProfileInfoWidget(
                                text: user.email,
                                title: 'Email',
                              ),
                              ProfileTextField(
                                controller: phoneController,
                                title: 'Номер телефона',
                                func: (value) {
                                  setState(() {
                                    isChanged = true;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Введите НОМЕР ТЕЛЕФОНА';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ],
                          ),
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
    );
  }
}
