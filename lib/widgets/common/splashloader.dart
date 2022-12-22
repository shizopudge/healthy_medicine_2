import 'package:flutter/material.dart';

import 'package:healthy_medicine_2/core/constants.dart';

class SplashLoader extends StatelessWidget {
  const SplashLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 120,
          child: Image.asset(Constants.logoPath),
        ),
      ),
    );
  }
}
