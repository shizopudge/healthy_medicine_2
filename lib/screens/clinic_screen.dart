import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/common/clinic_choice_menu.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/drawers/profile_drawer.dart';
import 'package:routemaster/routemaster.dart';

class ClinicScreen extends ConsumerWidget {
  final String spec;
  const ClinicScreen({
    super.key,
    required this.spec,
  });

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
    print(spec);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      backgroundColor: Constants.bg,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        actionsIconTheme: const IconThemeData(
          color: Constants.textColor,
          size: 28,
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => displayEndDrawer(context),
              icon: const Icon(
                Icons.menu,
              ),
            );
          }),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    spec,
                    style: const TextStyle(
                      color: Constants.textColor,
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        //change city
                      },
                      child: const Icon(
                        Icons.location_city,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  Text(
                    'г.${user.city}',
                    style: const TextStyle(
                      color: Constants.textColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Выберите удобную для себя клинику',
                  style: TextStyle(
                    color: Constants.textColor,
                    fontSize: 36,
                  ),
                ),
              ),
              Expanded(
                  child: ClinicMenu(
                spec: spec,
              )),
            ],
          ),
        ),
      ),
      endDrawer: const ProfileDrawer(),
    );
  }
}
