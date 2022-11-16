import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/common/error_text.dart';
import 'package:healthy_medicine_2/core/common/loader.dart';
import 'package:healthy_medicine_2/core/common/menu_clinic_widget.dart';

class ClinicMenu extends ConsumerWidget {
  final String spec;
  const ClinicMenu({
    super.key,
    required this.spec,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return ref.watch(getCityClinicsProvider(user.city)).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final clinic = data[index];
                return MenuOfClinic(
                  clinic: clinic,
                  spec: spec,
                );
              },
            );
          },
          error: ((error, stackTrace) => Center(
                child: ErrorText(
                  error: error.toString(),
                ),
              )),
          loading: () => const Loader(),
        );
  }
}
