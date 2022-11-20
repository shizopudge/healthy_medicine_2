import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class AdminAddEntryButton extends StatelessWidget {
  final String doctorId;
  const AdminAddEntryButton({
    super.key,
    required this.doctorId,
  });

  void navigateToAdminEntryPanel(BuildContext context) {
    Routemaster.of(context).push('/admin-entry-panel/$doctorId');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToAdminEntryPanel(context),
        child: Card(
          color: Constants.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(
                  Icons.admin_panel_settings,
                  size: 50,
                  color: Colors.white,
                ),
                Text(
                  'Панель управления',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
