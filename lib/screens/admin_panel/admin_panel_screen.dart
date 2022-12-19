import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/widgets/buttons/admin_panel_buttons.dart';
import 'package:routemaster/routemaster.dart';

class AdminPanelScreen extends ConsumerWidget {
  const AdminPanelScreen({super.key});

  void navigateToDoctorsAdminPanel(BuildContext context) {
    Routemaster.of(context).push('/admin-doctor-panel');
  }

  void navigateToAddDoctorAdminPanel(BuildContext context) {
    Routemaster.of(context).push('/admin-add-doctor-panel');
  }

  void navigateToUsersAdminPanel(BuildContext context) {
    Routemaster.of(context).push('/admin-users-panel');
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () => logOut(ref),
            child: const Icon(
              Icons.logout_rounded,
              size: 36,
              color: Colors.red,
            ),
          ),
        ],
        title: Text(
          user.email,
          style: AppTheme.dedicatedIndigoTextStyle.copyWith(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 75,
              child: Image.asset(Constants.logoPath),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 15,
              ),
              child: Text(
                'Панель управления',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: AppTheme.headerTextStyle,
              ),
            ),
            AdminPanelButton(
              text: 'Врачи',
              onPressed: () => navigateToDoctorsAdminPanel(context),
            ),
            AdminPanelButton(
              text: 'Создать врача',
              onPressed: () => navigateToAddDoctorAdminPanel(context),
            ),
            AdminPanelButton(
              text: 'Пользователи',
              onPressed: () => navigateToUsersAdminPanel(context),
            ),
          ],
        ),
      ),
    );
  }
}
