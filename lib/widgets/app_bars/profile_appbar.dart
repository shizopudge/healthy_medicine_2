import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class ProfileAppBar extends StatelessWidget {
  final String text;
  const ProfileAppBar({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: InkWell(
            onTap: () => Routemaster.of(context).pop(),
            borderRadius: BorderRadius.circular(21),
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(32),
                color: Colors.grey.shade200,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 24,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: AppTheme.titleTextStyle,
          ),
        ),
      ],
    );
  }
}
