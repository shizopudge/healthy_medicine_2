import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/common/error_text.dart';
import 'package:healthy_medicine_2/core/common/loader.dart';
import 'package:healthy_medicine_2/core/common/profile_info_widget.dart';
import 'package:healthy_medicine_2/core/common/profile_text_field.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

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
      floatingActionButton: isChanged
          ? InkWell(
              onTap: () {},
              child: const CircleAvatar(
                backgroundColor: Constants.secondColor,
                radius: 35,
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            )
          : null,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        title: const Text(
          'Профиль',
          style: TextStyle(color: Constants.textColor, fontSize: 24),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      backgroundColor: Constants.bg,
      body: ref.watch(getUserDataProvider(widget.uid)).when(
            data: (user) {
              return SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(Constants.avatarDefault),
                            backgroundColor: Colors.white,
                            radius: 90,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Основные сведения',
                              style: TextStyle(
                                color: Constants.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Ваш пол',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                        ? Colors.amber.shade100
                                        : Colors.grey.shade200,
                                    radius: 42,
                                    child: const Icon(
                                      Icons.male,
                                      size: 50,
                                      color: Color.fromARGB(255, 70, 73, 95),
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
                                        ? Colors.amber.shade100
                                        : Colors.grey.shade200,
                                    radius: 42,
                                    child: const Icon(
                                      Icons.female,
                                      size: 50,
                                      color: Color.fromARGB(255, 70, 73, 95),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Gap(15),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Контактные данные',
                              style: TextStyle(
                                color: Constants.textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
