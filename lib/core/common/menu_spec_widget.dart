import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class MenuOfItem extends StatelessWidget {
  final String specText;
  final String specIcon;
  final String spec;
  const MenuOfItem({
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
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Constants.textColor),
        backgroundColor: MaterialStateProperty.all(Constants.secondColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50,
            ),
          ),
        ),
      ),
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
            style: const TextStyle(color: Constants.primaryColor),
          ),
        ],
      ),
    );
  }
}
