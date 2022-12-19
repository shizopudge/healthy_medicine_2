import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/widgets/common/splashloader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/password_text_field.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/text_field.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/utils.dart';

const List<String> cities = [
  'Москва',
  'Уфа',
  'Санкт-Петербург',
  'Казань',
];

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController doctorsCodeController = TextEditingController();
  bool isDoctor = false;
  bool isCheckDoctorsCode = false;
  bool isCheckUserDoctorsExist = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    patronymicController.dispose();
    phoneController.dispose();
  }

  final String avatar = '';
  String gender = '';

  int age = 0;

  bool checkDoctorsCode(String value) {
    final doctorList = ref.read(getDoctorsProvider).value ?? [];
    int k = 0;
    for (var element in doctorList) {
      var id = element.id;
      if (value == id) {
        k++;
      }
    }
    if (k > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool checkUserDoctorsExist(String value) {
    final userDoctorsList = ref.read(getUsersDoctorsProvider).value ?? [];
    int k = 0;
    for (var element in userDoctorsList) {
      var docID = element.doctorId;
      if (value == docID) {
        k++;
      }
    }
    if (k > 0) {
      return true;
    } else {
      return false;
    }
  }

  void signUp(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signUp(
          context,
          emailController.text.trim(),
          passwordController.text.trim(),
          firstNameController.text.trim(),
          lastNameController.text.trim(),
          patronymicController.text.trim(),
          avatar,
          gender,
          phoneController.text.trim(),
          cityValue,
          DateTime.now(),
          isDoctor,
          doctorsCodeController.text.trim(),
        );
  }

  void signIn(BuildContext context, WidgetRef ref) {
    ref.read(authControllerProvider.notifier).signIn(
          context,
          emailController.text.trim(),
          passwordController.text.trim(),
        );
  }

  String cityValue = cities.first;

  final _formKey = GlobalKey<FormState>();

  bool login = true;
  bool isMale = false;
  bool isFemale = false;
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return isLoading
        ? const SplashLoader()
        : Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: isDoctor
                      ? Column(
                          children: [
                            Column(
                              children: [
                                const Gap(40),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 60,
                                  child: Image.asset(Constants.logoPath),
                                ),
                                Text(
                                  'Создание аккаунта врача',
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.headerTextStyle,
                                ),
                              ],
                            ),
                            TextFieldWidget(
                                textController: emailController,
                                hintText: 'EMAIL',
                                isNumber: false,
                                isRequired: true,
                                isEmail: true,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Введите существующий Email';
                                  } else {
                                    return null;
                                  }
                                }),
                            PasswordTextFieldWidget(
                              textController: passwordController,
                              hintText: 'ПАРОЛЬ',
                              isObscured: true,
                              fromLogin: false,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(21),
                                    color: Colors.grey.shade300),
                                child: TextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                      RegExp('[ ]'),
                                    ),
                                  ],
                                  controller: doctorsCodeController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Введите ваш код врача';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'ВАШ КОД ВРАЧА',
                                      hintStyle:
                                          AppTheme.dedicatedIndigoTextStyle,
                                      suffixIcon: isCheckDoctorsCode
                                          ? Icon(
                                              CupertinoIcons.check_mark,
                                              size: 24,
                                              color: isCheckUserDoctorsExist
                                                  ? Colors.orange
                                                  : Colors.green,
                                            )
                                          : const Icon(
                                              CupertinoIcons.check_mark,
                                              size: 24,
                                              color: Colors.red,
                                            )),
                                  cursorColor: AppTheme.indigoColor,
                                  style: AppTheme.dedicatedIndigoTextStyle,
                                  onChanged: ((value) {
                                    setState(() {
                                      isCheckDoctorsCode =
                                          checkDoctorsCode(value);
                                      isCheckUserDoctorsExist =
                                          checkUserDoctorsExist(value);
                                    });
                                  }),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      isCheckDoctorsCode == true &&
                                      isCheckUserDoctorsExist == false) {
                                    _formKey.currentState!.save();

                                    signUp(context, ref);
                                  }
                                  if (isCheckDoctorsCode == false) {
                                    showSnackBar(
                                        context, 'Ваш код врача не верен');
                                  }
                                  if (isCheckUserDoctorsExist == true) {
                                    showSnackBar(context,
                                        'Аккаунт с этим кодом врача уже существует');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: const Size(double.infinity, 55),
                                  backgroundColor:
                                      AppTheme.indigoColor.shade300,
                                ),
                                child: Text(
                                  'Зарегистрироваться',
                                  style: AppTheme.dedicatedWhiteTextStyle,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isDoctor = !isDoctor;
                                });
                              },
                              child: isDoctor
                                  ? Text(
                                      'Нет, я не врач...',
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    )
                                  : Text(
                                      'Я врач',
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            login
                                ? Column(
                                    children: [
                                      !isKeyboard
                                          ? Column(
                                              children: [
                                                const Gap(70),
                                                CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  radius: 90,
                                                  child: Image.asset(
                                                      Constants.logoPath),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                      TextFieldWidget(
                                        textController: emailController,
                                        hintText: 'EMAIL',
                                        isNumber: false,
                                        isRequired: false,
                                        isEmail: true,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              !value.contains('@')) {
                                            return 'Введите существующий Email';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      PasswordTextFieldWidget(
                                        textController: passwordController,
                                        hintText: 'ПАРОЛЬ',
                                        isObscured: true,
                                        fromLogin: true,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Форма регистрации',
                                              textAlign: TextAlign.center,
                                              style: AppTheme.headerTextStyle
                                                  .copyWith(
                                                fontSize: 32,
                                              ),
                                            ),
                                            Text(
                                              'Пожалуйста, заполните все поля',
                                              style: AppTheme.labelTextStyle,
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextFieldWidget(
                                          textController: emailController,
                                          hintText: 'EMAIL',
                                          isNumber: false,
                                          isRequired: true,
                                          isEmail: true,
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                !value.contains('@')) {
                                              return 'Введите существующий Email';
                                            } else {
                                              return null;
                                            }
                                          }),
                                      TextFieldWidget(
                                        textController: firstNameController,
                                        hintText: 'ИМЯ',
                                        isNumber: false,
                                        isRequired: true,
                                        isEmail: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Введите ИМЯ';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      TextFieldWidget(
                                        textController: lastNameController,
                                        hintText: 'ФАМИЛИЯ',
                                        isNumber: false,
                                        isRequired: true,
                                        isEmail: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Введите ФАМИЛИЮ';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      TextFieldWidget(
                                        textController: patronymicController,
                                        hintText: 'ОТЧЕСТВО',
                                        isNumber: false,
                                        isRequired: true,
                                        isEmail: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Введите ОТЧЕСТВО';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      TextFieldWidget(
                                        textController: phoneController,
                                        hintText: 'НОМЕР ТЕЛЕФОНА',
                                        isNumber: true,
                                        isRequired: true,
                                        isEmail: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Введите НОМЕР ТЕЛЕФОНА';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      PasswordTextFieldWidget(
                                        textController: passwordController,
                                        hintText: 'ПАРОЛЬ',
                                        isObscured: true,
                                        fromLogin: false,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Укажите ваш пол ',
                                                    style:
                                                        AppTheme.titleTextStyle,
                                                  ),
                                                  const Text(
                                                    '*',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isMale = true;
                                                      isFemale = false;
                                                      gender = 'M';
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: isMale
                                                        ? Colors.indigo.shade300
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
                                                    });
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: isFemale
                                                        ? Colors.indigo.shade300
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
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Укажите ваш город',
                                              style: AppTheme.titleTextStyle,
                                            ),
                                            Container(
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
                                                underline: const SizedBox(),
                                                onChanged: (String? value) {
                                                  setState(() {
                                                    cityValue = value!;
                                                  });
                                                },
                                                items: cities.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                            login
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();

                                          signIn(context, ref);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        backgroundColor:
                                            AppTheme.indigoColor.shade300,
                                      ),
                                      child: Text(
                                        'Войти',
                                        style: AppTheme.dedicatedWhiteTextStyle,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() &&
                                            gender != '') {
                                          _formKey.currentState!.save();

                                          signUp(context, ref);
                                        }
                                        if (gender == '') {
                                          showSnackBar(
                                              context, 'Укажите ваш пол');
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        minimumSize:
                                            const Size(double.infinity, 55),
                                        backgroundColor:
                                            AppTheme.indigoColor.shade300,
                                      ),
                                      child: Text(
                                        'Зарегистрироваться',
                                        style: AppTheme.dedicatedWhiteTextStyle,
                                      ),
                                    ),
                                  ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  login = !login;
                                });
                              },
                              child: login
                                  ? Text(
                                      'Еще нет аккаунта?',
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    )
                                  : Text(
                                      'Уже есть аккаунт? Войти',
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  isDoctor = !isDoctor;
                                });
                              },
                              child: isDoctor
                                  ? Text(
                                      'Нет, я не врач...',
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    )
                                  : Text(
                                      'Я врач',
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          );
  }
}
