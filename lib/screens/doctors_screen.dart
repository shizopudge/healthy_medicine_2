import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class DoctorsScreen extends ConsumerWidget {
  final String spec;
  final String clinic;
  const DoctorsScreen({
    super.key,
    required this.spec,
    required this.clinic,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(spec),
            const Gap(25),
            Text(clinic),
          ],
        ),
      ),
    );
  }
}
