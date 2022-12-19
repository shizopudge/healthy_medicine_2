import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class AdminPanelButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AdminPanelButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 16,
          minimumSize: const Size(double.infinity, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.grey.shade200,
        ),
        child: Text(
          text,
          style: AppTheme.dedicatedIndigoTextStyle,
        ),
      ),
    );
  }
}
