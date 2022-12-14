import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool isNumber;
  final bool isEmail;
  final bool isRequired;
  final String? Function(String?)? validator;
  const TextFieldWidget({
    super.key,
    required this.textController,
    required this.hintText,
    required this.isNumber,
    required this.validator,
    required this.isRequired,
    required this.isEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(21),
          color: Colors.grey.shade300,
        ),
        child: TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(
              RegExp('[ ]'),
            ),
          ],
          controller: textController,
          keyboardType: isNumber
              ? TextInputType.phone
              : isEmail
                  ? TextInputType.emailAddress
                  : null,
          decoration: InputDecoration(
            suffixIcon: isRequired
                ? const Text(
                    '*',
                    style: TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.right,
                  )
                : null,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
            border: InputBorder.none,
          ),
          validator: validator,
        ),
      ),
    );
  }
}
