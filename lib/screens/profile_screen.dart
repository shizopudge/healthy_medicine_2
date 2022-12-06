import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
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
  }

  bool isChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: isChanged
          ? ElevatedButton(
              onPressed: () {},
              child: Text(
                'Сохранить',
                style: AppTheme.dedicatedIndigoTextStyle,
              ),
            )
          : null,
      body: ref.watch(getUserDataProvider(widget.uid)).when(
            data: (user) {
              return SingleChildScrollView(
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage:
                                const AssetImage(Constants.avatarDefault),
                            backgroundColor: Colors.grey.shade100,
                            radius: 90,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Основные сведения',
                            style: AppTheme.dedicatedIndigoTextStyle.copyWith(
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
                        ),
                        ProfileTextField(
                          controller: lastNameController,
                          title: 'Фамилия',
                          func: (value) {
                            setState(() {
                              isChanged = true;
                            });
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
                        ),
                        ProfileInfoWidget(
                            title: 'День рождения',
                            text: '${ref.read(userProvider)!.birthday.year}-'
                                '${ref.read(userProvider)!.birthday.month}-'
                                '${ref.read(userProvider)!.birthday.day}'),
                        ProfileInfoWidget(
                          text: user.city,
                          title: 'Город',
                        ),
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
                                          ? AppTheme.redColor
                                          : Colors.grey.shade200,
                                      radius: 42,
                                      child: const Icon(
                                        Icons.male,
                                        size: 50,
                                        color: AppTheme.indigoColor,
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
                                          ? AppTheme.redColor
                                          : Colors.grey.shade200,
                                      radius: 42,
                                      child: const Icon(
                                        Icons.female,
                                        size: 50,
                                        color: AppTheme.indigoColor,
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
                            style: AppTheme.dedicatedIndigoTextStyle.copyWith(
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
    );
  }
}
