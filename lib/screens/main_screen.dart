import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/drawers/profile_drawer.dart';
import 'package:healthy_medicine_2/widgets/app_bars/main_appbar.dart';
import 'package:healthy_medicine_2/widgets/buttons/menu_spec_widget.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({
    super.key,
  });

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      endDrawer: const ProfileDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              Builder(builder: (context) {
                return MainAppBar(
                  onSearchTap: () {},
                  onAvatarTap: () => displayEndDrawer(context),
                  title: 'Какого врача вы ищете?',
                );
              }),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: const <Widget>[
                    MenuOfSpec(
                      specText: 'Хирург',
                      specIcon: 'assets/images/surgeon.png',
                      spec: 'Surgeon',
                    ),
                    MenuOfSpec(
                      specText: 'Окулист',
                      specIcon: 'assets/images/ophtalmologyst.png',
                      spec: 'Ophtalmologyst',
                    ),
                    MenuOfSpec(
                      specText: 'Уролог',
                      specIcon: 'assets/images/urologist.png',
                      spec: 'Urologist',
                    ),
                    MenuOfSpec(
                      specText: 'Терапевт',
                      specIcon: 'assets/images/therapist.png',
                      spec: 'Therapist',
                    ),
                    MenuOfSpec(
                      specText: 'Педиатр',
                      specIcon: 'assets/images/pediatrician.png',
                      spec: 'Pediatrician',
                    ),
                    MenuOfSpec(
                      specText: 'Дантист',
                      specIcon: 'assets/images/dentist.png',
                      spec: 'Dentist',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
