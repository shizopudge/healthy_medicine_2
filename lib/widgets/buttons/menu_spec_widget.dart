import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class MenuOfSpec extends StatelessWidget {
  final String specText;
  final String specIcon;
  final String spec;
  const MenuOfSpec({
    super.key,
    required this.specText,
    required this.specIcon,
    required this.spec,
  });

  void navigateToChoiceClinic(BuildContext context) {
    Routemaster.of(context).push('/clinics/$spec');
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => navigateToChoiceClinic(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            specIcon,
            height: 50,
          ),
          Text(
            specText,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.titleTextStyle,
          ),
        ],
      ),
    );
  }
}
