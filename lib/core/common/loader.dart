import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Constants.secondColor,
      ),
    );
  }
}
