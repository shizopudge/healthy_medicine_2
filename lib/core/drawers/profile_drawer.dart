import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push('/profile/$uid');
  }

  void navigateToAdminPanelScreen(BuildContext context) {
    Routemaster.of(context).push('/admin');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      backgroundColor: Constants.bg,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(Constants.avatarDefault),
                backgroundColor: Colors.white,
                radius: 70,
              ),
            ),
            const Gap(10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${user.firstName} ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        user.lastName,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Constants.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Divider(),
            ListTile(
              title: const Text(
                'Профиль',
                style: TextStyle(
                  fontSize: 15,
                  color: Constants.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              onTap: () => navigateToProfileScreen(
                context,
                user.uid,
              ),
            ),
            user.isAdmin
                ? ListTile(
                    title: const Text(
                      'Панель управления',
                      style: TextStyle(
                        fontSize: 15,
                        color: Constants.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: const Icon(
                      Icons.admin_panel_settings,
                      color: Colors.white,
                    ),
                    onTap: () => navigateToAdminPanelScreen(context),
                  )
                : const SizedBox(),
            ListTile(
              title: const Text(
                'Выйти',
                style: TextStyle(
                  fontSize: 15,
                  color: Constants.textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              onTap: () => logOut(ref),
            ),
          ],
        ),
      ),
    );
  }
}
