import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';

class UsersList extends ConsumerWidget {
  final String userType;
  const UsersList({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return userType == 'Врачи'
        ? ref.watch(getUsersDoctorsProvider).when(
            data: ((users) {
              if (users.isNotEmpty) {
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: ((context, index) {
                    final user = users[index];
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: AppTheme.indigoColor.shade100,
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                            image: user.avatar != ''
                                ? DecorationImage(
                                    image: NetworkImage(user.avatar),
                                  )
                                : const DecorationImage(
                                    image: AssetImage(Constants.avatarDefault),
                                  ),
                          ),
                        ),
                        title: Text(
                          '${user.firstName} ${user.lastName}',
                          style: AppTheme.dedicatedWhiteTextStyle,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.isDoctor ? 'Врач' : 'Обычный пользователь',
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              user.email,
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Тел: +${user.phone}',
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        trailing: user.isDoctor
                            ? Icon(
                                Icons.medical_information,
                                color: Colors.amber.shade100,
                                size: 32,
                              )
                            : user.isAdmin
                                ? Icon(
                                    Icons.admin_panel_settings_rounded,
                                    color: Colors.amber.shade100,
                                    size: 32,
                                  )
                                : Icon(
                                    Icons.person,
                                    color: Colors.amber.shade100,
                                    size: 32,
                                  ),
                      ),
                    );
                  }),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.asset('assets/images/secondvariant.png'),
                      Text(
                        'Упс, похоже еще никто не зарегистрировался... или что-то пошло не так',
                        textAlign: TextAlign.center,
                        style: AppTheme.noDataTextStyle,
                      ),
                    ],
                  ),
                );
              }
            }),
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader())
        : userType == 'Обычные пользователи'
            ? ref.watch(getUsersProvider).when(
                data: ((users) {
                  if (users.isNotEmpty) {
                    return ListView.builder(
                      itemCount: users.length,
                      itemBuilder: ((context, index) {
                        final user = users[index];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: AppTheme.indigoColor.shade100,
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                                image: user.avatar != ''
                                    ? DecorationImage(
                                        image: NetworkImage(user.avatar),
                                      )
                                    : const DecorationImage(
                                        image:
                                            AssetImage(Constants.avatarDefault),
                                      ),
                              ),
                            ),
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.isDoctor
                                      ? 'Врач'
                                      : 'Обычный пользователь',
                                  style:
                                      AppTheme.dedicatedWhiteTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  user.email,
                                  style:
                                      AppTheme.dedicatedWhiteTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Тел: +${user.phone}',
                                  style:
                                      AppTheme.dedicatedWhiteTextStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            trailing: user.isDoctor
                                ? Icon(
                                    Icons.medical_information,
                                    color: Colors.amber.shade100,
                                    size: 32,
                                  )
                                : user.isAdmin
                                    ? Icon(
                                        Icons.admin_panel_settings_rounded,
                                        color: Colors.amber.shade100,
                                        size: 32,
                                      )
                                    : Icon(
                                        Icons.person,
                                        color: Colors.amber.shade100,
                                        size: 32,
                                      ),
                          ),
                        );
                      }),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset('assets/images/secondvariant.png'),
                          Text(
                            'Упс, похоже еще никто не зарегистрировался... или что-то пошло не так',
                            textAlign: TextAlign.center,
                            style: AppTheme.noDataTextStyle,
                          ),
                        ],
                      ),
                    );
                  }
                }),
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader())
            : userType == 'Админы'
                ? ref.watch(getUsersAdminsProvider).when(
                    data: ((users) {
                      if (users.isNotEmpty) {
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: ((context, index) {
                            final user = users[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor: AppTheme.indigoColor.shade100,
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    image: user.avatar != ''
                                        ? DecorationImage(
                                            image: NetworkImage(user.avatar),
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                Constants.avatarDefault),
                                          ),
                                  ),
                                ),
                                title: Text(
                                  '${user.firstName} ${user.lastName}',
                                  style: AppTheme.dedicatedWhiteTextStyle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.isDoctor
                                          ? 'Врач'
                                          : user.isAdmin
                                              ? 'Админ'
                                              : 'Обычный пользователь',
                                      style: AppTheme.dedicatedWhiteTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      user.email,
                                      style: AppTheme.dedicatedWhiteTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Тел: +${user.phone}',
                                      style: AppTheme.dedicatedWhiteTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: user.isDoctor
                                    ? Icon(
                                        Icons.medical_information,
                                        color: Colors.amber.shade100,
                                        size: 32,
                                      )
                                    : user.isAdmin
                                        ? Icon(
                                            Icons.admin_panel_settings_rounded,
                                            color: Colors.amber.shade100,
                                            size: 32,
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.amber.shade100,
                                            size: 32,
                                          ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset('assets/images/secondvariant.png'),
                              Text(
                                'Упс, похоже еще никто не зарегистрировался... или что-то пошло не так',
                                textAlign: TextAlign.center,
                                style: AppTheme.noDataTextStyle,
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader())
                : ref.watch(getAllUsersProvider).when(
                    data: ((users) {
                      if (users.isNotEmpty) {
                        return ListView.builder(
                          itemCount: users.length,
                          itemBuilder: ((context, index) {
                            final user = users[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor: AppTheme.indigoColor.shade100,
                                leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                    image: user.avatar != ''
                                        ? DecorationImage(
                                            image: NetworkImage(user.avatar),
                                          )
                                        : const DecorationImage(
                                            image: AssetImage(
                                                Constants.avatarDefault),
                                          ),
                                  ),
                                ),
                                title: Text(
                                  '${user.firstName} ${user.lastName}',
                                  style: AppTheme.dedicatedWhiteTextStyle,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.isDoctor
                                          ? 'Врач'
                                          : 'Обычный пользователь',
                                      style: AppTheme.dedicatedWhiteTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      user.email,
                                      style: AppTheme.dedicatedWhiteTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      'Тел: +${user.phone}',
                                      style: AppTheme.dedicatedWhiteTextStyle
                                          .copyWith(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: user.isDoctor
                                    ? Icon(
                                        Icons.medical_information,
                                        color: Colors.amber.shade100,
                                        size: 32,
                                      )
                                    : user.isAdmin
                                        ? Icon(
                                            Icons.admin_panel_settings_rounded,
                                            color: Colors.amber.shade100,
                                            size: 32,
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: Colors.amber.shade100,
                                            size: 32,
                                          ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset('assets/images/secondvariant.png'),
                              Text(
                                'Упс, похоже еще никто не зарегистрировался... или что-то пошло не так',
                                textAlign: TextAlign.center,
                                style: AppTheme.noDataTextStyle,
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader());
  }
}
