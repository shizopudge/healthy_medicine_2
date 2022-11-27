import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/models/clinic_model.dart';
import 'package:routemaster/routemaster.dart';

class MenuOfClinic extends StatelessWidget {
  final String spec;
  final Clinic clinic;
  const MenuOfClinic({
    super.key,
    required this.clinic,
    required this.spec,
  });
  void navigateToDoctors(BuildContext context) {
    Routemaster.of(context).push('/doctors/${clinic.id}/$spec');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
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
          minimumSize: MaterialStateProperty.all(
            const Size(double.infinity, 90),
          ),
        ),
        onPressed: () => navigateToDoctors(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              clinic.address,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Constants.primaryColor,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
