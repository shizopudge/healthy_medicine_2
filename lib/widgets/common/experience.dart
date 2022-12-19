// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class Experience extends StatefulWidget {
  int experience;
  Color color;

  Experience({
    super.key,
    required this.experience,
    required this.color,
  });

  @override
  State<Experience> createState() => _MyHoursState();
}

class _MyHoursState extends State<Experience> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.color,
        ),
        child: Center(
          child: Text(
            widget.experience.toString(),
            style: AppTheme.dedicatedIndigoTextStyle.copyWith(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
