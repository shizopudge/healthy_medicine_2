import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

class AddDoctorTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isNumber;
  final String? Function(String?)? validator;
  const AddDoctorTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.isNumber,
    required this.validator,
  });

  @override
  State<AddDoctorTextField> createState() => _AddDoctorTextFieldState();
}

class _AddDoctorTextFieldState extends State<AddDoctorTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              widget.title,
              style: AppTheme.dedicatedIndigoTextStyle.copyWith(
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(21),
              color: Colors.grey.shade300,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                keyboardType: widget.isNumber ? TextInputType.number : null,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixText: widget.isNumber ? 'руб.' : null,
                  suffixStyle: widget.isNumber
                      ? AppTheme.dedicatedIndigoTextStyle
                      : null,
                  counterText: '',
                ),
                maxLength: widget.isNumber ? 4 : null,
                cursorColor: AppTheme.indigoColor,
                style: AppTheme.dedicatedIndigoTextStyle,
                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
