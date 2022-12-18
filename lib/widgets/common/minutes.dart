// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class MyMinutes extends StatelessWidget {
  int mins;

  MyMinutes({required this.mins});

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
            mins < 10 ? '0$mins' : mins.toString(),
            style: AppTheme.dedicatedIndigoTextStyle.copyWith(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
