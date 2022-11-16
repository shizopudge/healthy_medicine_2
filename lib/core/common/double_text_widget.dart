import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class AppDoubleTextWidget extends StatelessWidget {
  final String bigText;
  final String smallText;
  final String navigation;
  const AppDoubleTextWidget(
      {Key? key,
      required this.bigText,
      required this.smallText,
      required this.navigation})
      : super(key: key);

  void navigate(BuildContext context) {
    Routemaster.of(context).push(navigation);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          bigText,
          style: const TextStyle(
            color: Constants.textColor,
            fontSize: 22,
          ),
        ),
        InkWell(
          onTap: () => navigate(context),
          child: Text(
            smallText,
            style: const TextStyle(
              color: Constants.textColor,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
