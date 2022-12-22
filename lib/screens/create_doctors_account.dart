import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/app_bars/admin_entry_appbar.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/password_text_field.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/text_field.dart';

class CreateDoctorsAccountScreen extends ConsumerStatefulWidget {
  final VoidCallback onPressed;
  const CreateDoctorsAccountScreen({
    super.key,
    required this.onPressed,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateDoctorsAccountScreenState();
}

class _CreateDoctorsAccountScreenState
    extends ConsumerState<CreateDoctorsAccountScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Регистрация аккаунта врача',
                      style: AppTheme.dedicatedIndigoTextStyle,
                    ),
                    TextFieldWidget(
                        textController: emailController,
                        hintText: 'EMAIL',
                        isNumber: false,
                        isRequired: true,
                        isEmail: true,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Введите существующий Email';
                          } else {
                            return null;
                          }
                        }),
                    PasswordTextFieldWidget(
                      textController: passwordController,
                      hintText: 'ПАРОЛЬ',
                      isObscured: true,
                      fromLogin: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: widget.onPressed,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: const Size(double.infinity, 55),
                          backgroundColor: Colors.indigo.shade300,
                        ),
                        child: Text(
                          'Зарегистрироваться',
                          style: AppTheme.dedicatedWhiteTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
