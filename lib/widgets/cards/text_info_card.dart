import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class TextInfoCard extends StatelessWidget {
  final String text;
  const TextInfoCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Card(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: AppTheme.titleTextStyle.copyWith(
              fontSize: 28,
            ),
          ),
        ),
      ),
    );
  }
}
