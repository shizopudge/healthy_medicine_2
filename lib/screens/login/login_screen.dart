import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/common/splashloader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/password_text_field.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/text_field.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/utils.dart';

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

  String avatar = '';
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
          date,
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

  // TextEditingController dateController = TextEditingController();
  // bool isDatePicked = false;
  DateTime date = DateTime.now();

  bool login = true;
  bool register = false;
  bool isDoctor = false;
  bool isMale = false;
  bool isFemale = false;
  bool isSubmited = false;
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    if (isLoading) {
      return const SplashLoader();
    }
    if (login) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  !isKeyboard
                      ? Column(
                          children: [
                            const Gap(70),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 90,
                              child: Image.asset(Constants.logoPath),
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
                      if (value!.isEmpty || !value.contains('@')) {
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
                  Padding(
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: Colors.indigo.shade300,
                      ),
                      child: Text(
                        'Войти',
                        style: AppTheme.dedicatedWhiteTextStyle,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        login = false;
                        register = true;
                      });
                    },
                    child: Text(
                      'Еще нет аккаунта?',
                      style: AppTheme.defaultIngidgoText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        login = false;
                        isDoctor = true;
                      });
                    },
                    child: Text(
                      'Я врач',
                      style: AppTheme.defaultIngidgoText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (isDoctor) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () => setState(() {
                          login = true;
                          isDoctor = false;
                        }),
                        borderRadius: BorderRadius.circular(21),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.grey.shade200,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Stepper(
                    margin: const EdgeInsets.all(8),
                    physics: const ClampingScrollPhysics(),
                    elevation: 16,
                    onStepTapped: (value) {},
                    currentStep: currentStep,
                    controlsBuilder: (context, details) {
                      if (currentStep == 0) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isCheckDoctorsCode = checkDoctorsCode(
                                  doctorsCodeController.text.trim());
                              isCheckUserDoctorsExist = checkUserDoctorsExist(
                                  doctorsCodeController.text.trim());
                            });
                            if (isCheckDoctorsCode == true &&
                                isCheckUserDoctorsExist == false) {
                              setState(() {
                                currentStep = currentStep + 1;
                                isSubmited = true;
                              });
                            } else if (isCheckDoctorsCode == false) {
                              showSnackBar(context, 'Вы ввели неверный DocID');
                            } else if (isCheckUserDoctorsExist == true) {
                              showSnackBar(context,
                                  'Аккаунт с таким DocID уже существует');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Продолжить',
                            style: AppTheme.dedicatedWhiteTextStyle,
                          ),
                        );
                      }
                      if (currentStep == 1) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  isCheckDoctorsCode == true &&
                                  isCheckUserDoctorsExist == false) {
                                _formKey.currentState!.save();
                                signUp(context, ref);
                              } else if (isCheckDoctorsCode == false) {
                                showSnackBar(context, 'Ваш код врача не верен');
                              } else if (isCheckUserDoctorsExist == true) {
                                showSnackBar(context,
                                    'Аккаунт с этим кодом врача уже существует');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              minimumSize: const Size(double.infinity, 55),
                              backgroundColor: Colors.indigo.shade300,
                            ),
                            child: Text(
                              'Зарегистрироваться',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                          ),
                        );
                      }
                      return const Loader();
                    },
                    steps: [
                      Step(
                        isActive: currentStep == 0,
                        title: Text(
                          'Введите ваш DocID',
                          style: AppTheme.defaultIngidgoText,
                        ),
                        content: Column(
                          children: [
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
                                      return 'Введите ваш DocID';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onFieldSubmitted: ((value) {
                                    setState(() {
                                      isCheckDoctorsCode =
                                          checkDoctorsCode(value);
                                      isCheckUserDoctorsExist =
                                          checkUserDoctorsExist(value);
                                    });
                                  }),
                                  onChanged: ((value) {
                                    setState(() {
                                      isCheckDoctorsCode =
                                          checkDoctorsCode(value);
                                      isCheckUserDoctorsExist =
                                          checkUserDoctorsExist(value);
                                    });
                                  }),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'ВАШ DocID',
                                    hintStyle:
                                        AppTheme.dedicatedIndigoTextStyle,
                                    suffixIcon: isCheckDoctorsCode
                                        ? isCheckUserDoctorsExist
                                            ? const Icon(
                                                CupertinoIcons.check_mark,
                                                size: 24,
                                                color: Colors.orange,
                                              )
                                            : const Icon(
                                                CupertinoIcons.check_mark,
                                                size: 24,
                                                color: Colors.green,
                                              )
                                        : const Icon(
                                            CupertinoIcons.check_mark,
                                            size: 24,
                                            color: Colors.red,
                                          ),
                                  ),
                                  cursorColor: Colors.indigo,
                                  style: AppTheme.dedicatedIndigoTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Step(
                        isActive: currentStep == 1,
                        title: Text(
                          'Регистрация',
                          style: AppTheme.defaultIngidgoText,
                        ),
                        content: Column(
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
                            // TextFieldWidget(
                            //   textController: firstNameController,
                            //   hintText: 'ИМЯ',
                            //   isNumber: false,
                            //   isRequired: true,
                            //   isEmail: false,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Введите ИМЯ';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                            // TextFieldWidget(
                            //   textController: lastNameController,
                            //   hintText: 'ФАМИЛИЯ',
                            //   isNumber: false,
                            //   isRequired: true,
                            //   isEmail: false,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Введите ФАМИЛИЮ';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                            // TextFieldWidget(
                            //   textController: patronymicController,
                            //   hintText: 'ОТЧЕСТВО',
                            //   isNumber: false,
                            //   isRequired: true,
                            //   isEmail: false,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Введите ОТЧЕСТВО';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                            // TextFieldWidget(
                            //   textController: phoneController,
                            //   hintText: 'НОМЕР ТЕЛЕФОНА',
                            //   isNumber: true,
                            //   isRequired: true,
                            //   isEmail: false,
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Введите НОМЕР ТЕЛЕФОНА';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    if (register) {
      return Scaffold(
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Форма регистрации',
                          textAlign: TextAlign.center,
                          style: AppTheme.headerTextStyle.copyWith(
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
                        if (value!.isEmpty || !value.contains('@')) {
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
                  // Container(
                  //   width: MediaQuery.of(context).size.width * .7,
                  //   height: 50,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(21),
                  //     color: Colors.grey.shade400,
                  //   ),
                  //   child: TextFormField(
                  //     controller: dateController,
                  //     textAlign: TextAlign.center,
                  //     onTap: () => showDatePicker(
                  //       context: context,
                  //       initialEntryMode: DatePickerEntryMode.inputOnly,
                  //       initialDate: DateTime.now().weekday == 5
                  //           ? DateTime(
                  //               DateTime.now().year,
                  //               DateTime.now().month,
                  //               DateTime.now().day + 3,
                  //               DateTime.now().hour,
                  //               DateTime.now().minute)
                  //           : DateTime.now().weekday == 6
                  //               ? DateTime(
                  //                   DateTime.now().year,
                  //                   DateTime.now().month,
                  //                   DateTime.now().day + 2,
                  //                   DateTime.now().hour,
                  //                   DateTime.now().minute)
                  //               : DateTime(
                  //                   DateTime.now().year,
                  //                   DateTime.now().month,
                  //                   DateTime.now().day + 1,
                  //                   DateTime.now().hour,
                  //                   DateTime.now().minute),
                  //       firstDate: DateTime.now().weekday == 5
                  //           ? DateTime(
                  //               DateTime.now().year,
                  //               DateTime.now().month,
                  //               DateTime.now().day + 3,
                  //               DateTime.now().hour,
                  //               DateTime.now().minute)
                  //           : DateTime.now().weekday == 6
                  //               ? DateTime(
                  //                   DateTime.now().year,
                  //                   DateTime.now().month,
                  //                   DateTime.now().day + 2,
                  //                   DateTime.now().hour,
                  //                   DateTime.now().minute)
                  //               : DateTime(
                  //                   DateTime.now().year,
                  //                   DateTime.now().month,
                  //                   DateTime.now().day + 1,
                  //                   DateTime.now().hour,
                  //                   DateTime.now().minute),
                  //       lastDate: DateTime(
                  //         DateTime.now().year,
                  //         DateTime.now().month,
                  //         DateTime.now().day + 14,
                  //       ),
                  //       selectableDayPredicate: (DateTime val) =>
                  //           val.weekday == 6 || val.weekday == 7 ? false : true,
                  //     ).then((selectedDate) {
                  //       if (selectedDate != null) {
                  //         setState(() {
                  //           date = selectedDate;
                  //           dateController = TextEditingController(
                  //               text:
                  //                   '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');
                  //           isDatePicked = true;
                  //         });
                  //       }
                  //     }),
                  //     readOnly: true,
                  //     decoration: InputDecoration(
                  //       contentPadding: const EdgeInsets.all(8),
                  //       border: InputBorder.none,
                  //       hintText: 'Дата рождения',
                  //       hintStyle: AppTheme.dedicatedWhiteTextStyle
                  //           .copyWith(fontSize: 21),
                  //     ),
                  //     style: AppTheme.dedicatedWhiteTextStyle
                  //         .copyWith(fontSize: 21),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Укажите ваш пол ',
                                style: AppTheme.titleTextStyle,
                              ),
                              const Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Text(
                  //         'Укажите ваш город',
                  //         style: AppTheme.titleTextStyle,
                  //       ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(21),
                  //           color: Colors.grey.shade200,
                  //         ),
                  //         padding: const EdgeInsets.all(8),
                  //         child: DropdownButton<String>(
                  //           value: cityValue,
                  //           icon: const RotatedBox(
                  //             quarterTurns: 3,
                  //             child: Icon(
                  //               Icons.arrow_back_ios_new_outlined,
                  //               color: Colors.indigo,
                  //             ),
                  //           ),
                  //           elevation: 16,
                  //           style: AppTheme.dedicatedIndigoTextStyle,
                  //           underline: const SizedBox(),
                  //           onChanged: (String? value) {
                  //             setState(() {
                  //               cityValue = value!;
                  //             });
                  //           },
                  //           items: cities
                  //               .map<DropdownMenuItem<String>>((String value) {
                  //             return DropdownMenuItem<String>(
                  //               value: value,
                  //               child: Text(value),
                  //             );
                  //           }).toList(),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() && gender != '') {
                          _formKey.currentState!.save();

                          signUp(context, ref);
                        }
                        if (gender == '') {
                          showSnackBar(context, 'Укажите ваш пол');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size(double.infinity, 55),
                        backgroundColor: Colors.indigo.shade300,
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
                        login = true;
                        register = false;
                      });
                    },
                    child: Text(
                      'Уже есть аккаунт? Войти',
                      style: AppTheme.defaultIngidgoText,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        register = false;
                        isDoctor = true;
                      });
                    },
                    child: Text(
                      'Я врач',
                      style: AppTheme.defaultIngidgoText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return const SplashLoader();
  }
}
