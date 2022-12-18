// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class MyHours extends StatefulWidget {
  int hours;

  MyHours({required this.hours});

  @override
  State<MyHours> createState() => _MyHoursState();
}

class _MyHoursState extends State<MyHours> {
  int hour = 8;
  @override
  void initState() {
    super.initState();
    switch (widget.hours) {
      case 0:
        hour = 8;
        break;
      case 1:
        hour = 9;
        break;
      case 2:
        hour = 10;
        break;
      case 3:
        hour = 11;
        break;
      case 4:
        hour = 12;
        break;
      case 5:
        hour = 13;
        break;
      case 6:
        hour = 14;
        break;
      case 7:
        hour = 15;
        break;
      case 8:
        hour = 16;
        break;
      case 9:
        hour = 17;
        break;
      case 10:
        hour = 18;
        break;
      case 11:
        hour = 19;
        break;
      default:
        hour = 8;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100,
        ),
        child: Center(
          child: Text(
            hour.toString(),
            style: AppTheme.dedicatedIndigoTextStyle.copyWith(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
