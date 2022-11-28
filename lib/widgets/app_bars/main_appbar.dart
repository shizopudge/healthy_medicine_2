import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class MainAppBar extends ConsumerWidget {
  final String title;
  final VoidCallback onSearchTap;
  final VoidCallback onAvatarTap;

  const MainAppBar({
    Key? key,
    required this.title,
    required this.onSearchTap,
    required this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        right: 5,
        left: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTheme.headerTextStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: onSearchTap,
                borderRadius: BorderRadius.circular(21),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey[200],
                  ),
                  child: const Icon(
                    Icons.search,
                    size: 36,
                    color: AppTheme.blackColor,
                  ),
                ),
              ),
              const Gap(5),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onAvatarTap,
                  borderRadius: BorderRadius.circular(21),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: user.avatar == ''
                        ? Image.asset(Constants.avatarDefault)
                        : Image.network(user.avatar),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: onMenuTap,
              //   borderRadius: BorderRadius.circular(21),
              //   child: Container(
              //     padding: const EdgeInsets.all(12),
              //     decoration: BoxDecoration(
              //       border: Border.all(color: Colors.white),
              //       borderRadius: BorderRadius.circular(16),
              //       color: Colors.grey[200],
              //     ),
              //     child: const Icon(
              //       Icons.menu,
              //       size: 36,
              //       color: AppTheme.blackColor,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}