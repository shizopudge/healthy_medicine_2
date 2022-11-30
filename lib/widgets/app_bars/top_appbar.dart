import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:routemaster/routemaster.dart';

class TopAppBar extends ConsumerWidget {
  final String title;
  final VoidCallback onSearchTap;

  const TopAppBar({
    Key? key,
    required this.onSearchTap,
    required this.title,
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => Routemaster.of(context).pop(),
              borderRadius: BorderRadius.circular(21),
              child: Container(
                padding: const EdgeInsets.all(12),
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.grey.shade200,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 24,
                ),
              ),
            ),
          ),
          Row(
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
