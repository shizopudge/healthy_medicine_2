import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/models/user_model.dart';
import 'package:routemaster/routemaster.dart';

class UserCard extends ConsumerWidget {
  final UserModel user;
  const UserCard({
    super.key,
    required this.user,
  });

  void navigateToMedicineCardScreen(BuildContext context) {
    Routemaster.of(context).push('/medicine-card/${user.uid}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToMedicineCardScreen(context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.indigo.shade100,
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              user.isAdmin
                  ? Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage(Constants.adminIconDefault),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    )
                  : user.isDoctor
                      ? Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage(Constants.doctorIconDefault),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () => navigateToMedicineCardScreen(context),
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                              image: user.avatar != ''
                                  ? DecorationImage(
                                      image: NetworkImage(user.avatar),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image:
                                          AssetImage(Constants.avatarDefault),
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ),
                        ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      '${user.firstName} ${user.lastName}',
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.dedicatedWhiteTextStyle,
                    ),
                    Text(
                      user.isDoctor
                          ? 'Врач'
                          : user.isAdmin
                              ? 'Админ'
                              : 'Обычный пользователь',
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      user.email,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Тел: +${user.phone}',
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              user.isDoctor
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
            ],
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(4.0),
    //   child: ListTile(
    //     contentPadding: const EdgeInsets.all(8),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     tileColor: Colors.indigo.shade100,
    //     leading: user.isAdmin
    //         ? Container(
    //             height: 60,
    //             width: 60,
    //             decoration: BoxDecoration(
    //               color: Colors.grey.shade100,
    //               shape: BoxShape.circle,
    //               image: const DecorationImage(
    //                 image: AssetImage(Constants.adminIconDefault),
    //                 fit: BoxFit.scaleDown,
    //               ),
    //             ),
    //           )
    //         : user.isDoctor
    //             ? Container(
    //                 height: 60,
    //                 width: 60,
    //                 decoration: BoxDecoration(
    //                   color: Colors.grey.shade100,
    //                   shape: BoxShape.circle,
    //                   image: const DecorationImage(
    //                     image: AssetImage(Constants.doctorIconDefault),
    //                     fit: BoxFit.scaleDown,
    //                   ),
    //                 ),
    //               )
    //             : InkWell(
    //                 onTap: () => navigateToMedicineCardScreen(context),
    //                 child: Container(
    //                   height: 60,
    //                   width: 60,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey.shade100,
    //                     shape: BoxShape.circle,
    //                     image: user.avatar != ''
    //                         ? DecorationImage(
    //                             image: NetworkImage(user.avatar),
    //                             fit: BoxFit.cover,
    //                           )
    //                         : const DecorationImage(
    //                             image: AssetImage(Constants.avatarDefault),
    //                             fit: BoxFit.scaleDown,
    //                           ),
    //                   ),
    //                 ),
    //               ),
    //     title: Text(
    //       '${user.firstName} ${user.lastName}',
    //       style: AppTheme.dedicatedWhiteTextStyle,
    //     ),
    //     subtitle: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           user.isDoctor
    //               ? 'Врач'
    //               : user.isAdmin
    //                   ? 'Админ'
    //                   : 'Обычный пользователь',
    //           style: AppTheme.dedicatedWhiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //         Text(
    //           user.email,
    //           style: AppTheme.dedicatedWhiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //         Text(
    //           'Тел: +${user.phone}',
    //           style: AppTheme.dedicatedWhiteTextStyle.copyWith(
    //             fontSize: 14,
    //           ),
    //         ),
    //       ],
    //     ),
    //     trailing: user.isDoctor
    //         ? Icon(
    //             Icons.medical_information,
    //             color: Colors.amber.shade100,
    //             size: 32,
    //           )
    //         : user.isAdmin
    //             ? Icon(
    //                 Icons.admin_panel_settings_rounded,
    //                 color: Colors.amber.shade100,
    //                 size: 32,
    //               )
    //             : Icon(
    //                 Icons.person,
    //                 color: Colors.amber.shade100,
    //                 size: 32,
    //               ),
    //   ),
    // );
  }
}
