import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/widgets/buttons/menu_spec_widget.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:routemaster/routemaster.dart';

class SpecScreen extends ConsumerWidget {
  const SpecScreen({super.key});

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
      // endDrawer: const ProfileDrawer(),
    );
  }
}
