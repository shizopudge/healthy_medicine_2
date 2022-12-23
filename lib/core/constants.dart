import 'package:flutter/material.dart';

const List<String> specs = [
  'Все',
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

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const avatarDefault = 'assets/images/userAvatar.png';
  static const doctorIconDefault = 'assets/images/doctorIcon.png';
  static const adminIconDefault = 'assets/images/adminIcon.png';

  static const primaryColor = Color.fromARGB(255, 70, 73, 95);
  static const secondColor = Color.fromARGB(255, 219, 214, 197);
  static const bg = Color.fromARGB(255, 30, 31, 41);
  static const textColor = Color.fromARGB(255, 255, 233, 171);
}
