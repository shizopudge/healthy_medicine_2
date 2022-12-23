import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.indigo.shade300,
        elevation: 16,
        behavior: SnackBarBehavior.floating,
        content: Text(
          text,
          style: AppTheme.dedicatedWhiteTextStyle.copyWith(fontSize: 16),
        ),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);
  return image;
}
