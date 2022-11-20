import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/common/splashloader.dart';
import 'package:healthy_medicine_2/core/common/password_text_field.dart';
import 'package:healthy_medicine_2/core/common/text_field.dart';
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
                  child: Column(
                    children: [
                      login
                          ? Column(
                              children: [
                                !isKeyboard
                                    ? Column(
                                        children: [
                                          const Gap(75),
                                          CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 90,
                                            child:
                                                Image.asset(Constants.logoPath),
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
                                    children: const [
                                      Text(
                                        'Форма регистрации',
                                        style: TextStyle(
                                            fontSize: 32,
                                            color:
                                                Color.fromARGB(255, 70, 73, 95),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Пожалуйста, заполните все поля',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 70, 73, 95),
                                            fontWeight: FontWeight.w300),
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              'Укажите ваш пол ',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 70, 73, 95),
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
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
                                                  ? Colors.amber.shade100
                                                  : Colors.grey.shade200,
                                              radius: 42,
                                              child: const Icon(
                                                Icons.male,
                                                size: 50,
                                                color: Color.fromARGB(
                                                    255, 70, 73, 95),
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
                                                  ? Colors.amber.shade100
                                                  : Colors.grey.shade200,
                                              radius: 42,
                                              child: const Icon(
                                                Icons.female,
                                                size: 50,
                                                color: Color.fromARGB(
                                                    255, 70, 73, 95),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Укажите ваш город ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 70, 73, 95),
                                          fontSize: 22,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      DropdownButton<String>(
                                        value: cityValue,
                                        icon: const RotatedBox(
                                          quarterTurns: 3,
                                          child: Icon(Icons
                                              .arrow_back_ios_new_outlined),
                                        ),
                                        elevation: 16,
                                        style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 70, 73, 95),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                        underline: Container(
                                          height: 2,
                                          color: const Color.fromARGB(
                                              255, 70, 73, 95),
                                        ),
                                        onChanged: (String? value) {
                                          setState(() {
                                            cityValue = value!;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
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
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: const Size(double.infinity, 55),
                                  backgroundColor:
                                      const Color.fromARGB(255, 70, 73, 95),
                                ),
                                child: const Text(
                                  'Войти',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                                    showSnackBar(context, 'Укажите ваш пол');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minimumSize: const Size(double.infinity, 55),
                                  backgroundColor:
                                      const Color.fromARGB(255, 70, 73, 95),
                                ),
                                child: const Text(
                                  'Зарегистрироваться',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w400,
                                  ),
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
                            ? const Text(
                                'Еще нет аккаунта?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 70, 73, 95),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            : const Text(
                                'Уже есть аккаунт? Войти',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 70, 73, 95),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
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
