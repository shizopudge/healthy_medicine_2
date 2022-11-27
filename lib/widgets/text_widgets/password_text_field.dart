import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  bool isObscured;
  final bool fromLogin;
  PasswordTextFieldWidget({
    super.key,
    required this.textController,
    required this.hintText,
    required this.isObscured,
    required this.fromLogin,
  });

  @override
  State<PasswordTextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<PasswordTextFieldWidget> {
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
          validator: widget.fromLogin
              ? (value) {
                  if (value == '') {
                    return 'Введите пароль';
                  } else if (value!.length < 6) {
                    return 'Пароль не может содержать меньше 6 символов';
                  }
                  return null;
                }
              : (value) {
                  if (value == '') {
                    return 'Введите пароль';
                  } else if (value!.length < 6) {
                    return 'Пароль должен содержать не меньше 6 символов';
                  }
                  return null;
                },
          controller: widget.textController,
          obscureText: widget.isObscured,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(fontSize: 20, color: Colors.white),
            suffixIcon: widget.isObscured
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isObscured = !widget.isObscured;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      setState(() {
                        widget.isObscured = !widget.isObscured;
                      });
                    },
                    icon: const Icon(
                      Icons.remove_red_eye,
                      color: Colors.red,
                    ),
                  ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
