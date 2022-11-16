import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/common/menu_spec_widget.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/drawers/profile_drawer.dart';
import 'package:routemaster/routemaster.dart';

class SpecScreen extends ConsumerWidget {
  const SpecScreen({super.key});

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Какого врача вы ищете?',
                  style: TextStyle(
                    color: Constants.textColor,
                    fontSize: 36,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: const <Widget>[
                    MenuOfItem(
                      specText: 'Хирург',
                      specIcon: 'assets/images/surgeon.png',
                    ),
                    MenuOfItem(
                      specText: 'Окулист',
                      specIcon: 'assets/images/ophtalmologyst.png',
                    ),
                    MenuOfItem(
                      specText: 'Уролог',
                      specIcon: 'assets/images/urologist.png',
                    ),
                    MenuOfItem(
                      specText: 'Терапевт',
                      specIcon: 'assets/images/therapist.png',
                    ),
                    MenuOfItem(
                      specText: 'Педиатр',
                      specIcon: 'assets/images/pediatrician.png',
                    ),
                    MenuOfItem(
                      specText: 'Дантист',
                      specIcon: 'assets/images/dentist.png',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      endDrawer: const ProfileDrawer(),
    );
  }
}
