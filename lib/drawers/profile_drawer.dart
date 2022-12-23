import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
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
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: user.avatar != ''
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                      backgroundColor: Colors.transparent,
                      radius: 75,
                    )
                  : CircleAvatar(
                      backgroundImage: user.isAdmin
                          ? const AssetImage(Constants.adminIconDefault)
                          : user.isDoctor
                              ? const AssetImage(Constants.doctorIconDefault)
                              : const AssetImage(Constants.avatarDefault),
                      backgroundColor: Colors.transparent,
                      radius: 75,
                    ),
            ),
            const Gap(10),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${user.firstName} ${user.lastName}',
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.titleTextStyle,
                  ),
                ),
                Text(
                  user.email,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTheme.dedicatedTextStyle.copyWith(fontSize: 18),
                ),
              ],
            ),
            const Gap(10),
            const Divider(),
            user.isAdmin || user.isDoctor
                ? const SizedBox()
                : ListTile(
                    title: Text(
                      'Профиль',
                      style: AppTheme.labelTextStyle,
                    ),
                    leading: const Icon(
                      Icons.person,
                      color: Colors.indigo,
                      size: 32,
                    ),
                    onTap: () => navigateToProfileScreen(
                      context,
                      user.uid,
                    ),
                  ),
            ListTile(
              title: Text(
                'Выйти',
                style: AppTheme.labelTextStyle,
              ),
              leading: const Icon(
                Icons.logout_rounded,
                color: Colors.red,
                size: 32,
              ),
              onTap: () => logOut(ref),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark
                    ? const Icon(
                        Icons.mode_night_rounded,
                        color: Colors.indigo,
                        size: 42,
                      )
                    : const Icon(
                        Icons.light_mode_rounded,
                        color: Colors.indigo,
                        size: 42,
                      ),
                Switch.adaptive(
                  value: ref.watch(themeNotifierProvider.notifier).mode ==
                      ThemeMode.dark,
                  onChanged: (value) => toggleTheme(ref),
                  activeColor: Colors.indigo,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
