import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/widgets/cards/user_card.dart';
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
                    return UserCard(user: user);
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
                        return UserCard(user: user);
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
                            return UserCard(user: user);
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
                            return UserCard(user: user);
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
