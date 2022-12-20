import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class AdminEditDoctorButton extends StatelessWidget {
  final String doctorId;
  const AdminEditDoctorButton({
    super.key,
    required this.doctorId,
  });

  void navigateToAdminEditDoctorPanel(BuildContext context) {
    Routemaster.of(context).push('/admin-edit-doctor-panel/$doctorId');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToAdminEditDoctorPanel(context),
        borderRadius: BorderRadius.circular(21),
        child: Container(
          padding: const EdgeInsets.all(12),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(32),
            gradient: AppTheme.gradientIndigoToRed,
          ),
          child: const Icon(
            Icons.edit_note_rounded,
            size: 32,
          ),
        ),
      ),
    );
  }
}
