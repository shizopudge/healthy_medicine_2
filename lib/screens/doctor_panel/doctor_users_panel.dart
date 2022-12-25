import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/lists/users.dart';

class DoctorUsersPanel extends ConsumerStatefulWidget {
  const DoctorUsersPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorUsersPanelState();
}

class _DoctorUsersPanelState extends ConsumerState<DoctorUsersPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    'Пациенты',
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: AppTheme.headerTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: InkWell(
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
                ),
              ],
            ),
            const Expanded(
              child: UsersList(
                userType: 'Обычные пользователи',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
