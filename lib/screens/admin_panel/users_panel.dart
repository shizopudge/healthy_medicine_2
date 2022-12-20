import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/lists/users.dart';
import 'package:routemaster/routemaster.dart';

final userTypeProvider =
    StateProvider.autoDispose<String>((ref) => 'Обычные пользователи');

class UsersPanel extends ConsumerStatefulWidget {
  const UsersPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UsersPanelState();
}

class _UsersPanelState extends ConsumerState<UsersPanel> {
  @override
  Widget build(BuildContext context) {
    final userType = ref.watch(userTypeProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Управление пользователями',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: AppTheme.headerTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(21),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      height: 65,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(32),
                        gradient: AppTheme.gradientIndigoToRed,
                      ),
                      child: const Icon(
                        Icons.search,
                        size: 36,
                      ),
                    ),
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      Text(
                        userType,
                        style: AppTheme.dedicatedIndigoTextStyle
                            .copyWith(fontSize: 16),
                      ),
                      PopupMenuButton(
                        iconSize: 32,
                        elevation: 0,
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            child: Text(
                              'Обычные пользователи',
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                  color: AppTheme.indigoColor, fontSize: 14),
                            ),
                            onTap: () => ref
                                .read(userTypeProvider.notifier)
                                .state = 'Обычные пользователи',
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Админы',
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                  color: AppTheme.indigoColor, fontSize: 14),
                            ),
                            onTap: () => ref
                                .read(userTypeProvider.notifier)
                                .state = 'Админы',
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Врачи',
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                  color: AppTheme.indigoColor, fontSize: 14),
                            ),
                            onTap: () => ref
                                .read(userTypeProvider.notifier)
                                .state = 'Врачи',
                          ),
                          PopupMenuItem(
                            child: Text(
                              'Все',
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                  color: AppTheme.indigoColor, fontSize: 14),
                            ),
                            onTap: () => ref
                                .read(userTypeProvider.notifier)
                                .state = 'Все',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: UsersList(
                userType: userType,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
