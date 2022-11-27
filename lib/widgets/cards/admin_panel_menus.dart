import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/models/clinic_model.dart';

class AdminClinicMenuWidget extends StatelessWidget {
  final Clinic clinic;
  const AdminClinicMenuWidget({
    super.key,
    required this.clinic,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Constants.secondColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Text(
              clinic.address,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Constants.primaryColor,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
