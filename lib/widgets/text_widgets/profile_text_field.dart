import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final void Function(String)? func;
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.func,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
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
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: widget.controller,
                decoration: const InputDecoration(
                  filled: true,
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Constants.textColor,
                  fontSize: 22,
                ),
                onChanged: widget.func,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
