import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:routemaster/routemaster.dart';

import '../../drawers/profile_drawer.dart';

class DoctorsAdminPanel extends ConsumerStatefulWidget {
  const DoctorsAdminPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorsAdminPanelState();
}

class _DoctorsAdminPanelState extends ConsumerState<DoctorsAdminPanel> {
  String cityValue = '';

  @override
  void initState() {
    super.initState();
    cityValue = ref.read(userProvider)!.city;
  }

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToAdminDoctorsList(BuildContext context, String clinicId) {
    Routemaster.of(context).push('/doctors-list/$clinicId');
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider)!;
    return Scaffold(
      endDrawer: const ProfileDrawer(),
      appBar: AppBar(
        actions: [
          Builder(builder: (context) {
            return InkWell(
              onTap: () => displayEndDrawer(context),
              child: const Icon(
                Icons.menu,
                size: 32,
                color: Colors.indigo,
              ),
            );
          }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Выберите клинику',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                style: AppTheme.headerTextStyle,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.grey.shade200,
              ),
              padding: const EdgeInsets.all(8),
              child: DropdownButton<String>(
                value: cityValue,
                icon: const RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.indigo,
                  ),
                ),
                dropdownColor: Colors.grey.shade100,
                elevation: 16,
                underline: const SizedBox(),
                style: AppTheme.dedicatedIndigoTextStyle,
                onChanged: (String? value) {
                  setState(() {
                    cityValue = value!;
                  });
                },
                items: cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: ref.watch(getCityClinicsProvider(cityValue)).when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final clinic = data[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      50,
                                    ),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 90),
                                ),
                              ),
                              onPressed: () => navigateToAdminDoctorsList(
                                  context, clinic.id),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    clinic.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    error: ((error, stackTrace) => Center(
                          child: ErrorText(
                            error: error.toString(),
                          ),
                        )),
                    loading: () => const Loader(),
                  ),
            )
          ],
        ),
      ),
    );
  }
}
