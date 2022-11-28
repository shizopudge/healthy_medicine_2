import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class TopAppBar extends ConsumerWidget {
  final VoidCallback onAvatarTap;

  const TopAppBar({
    Key? key,
    required this.onAvatarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Align(
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
    );
  }
}
