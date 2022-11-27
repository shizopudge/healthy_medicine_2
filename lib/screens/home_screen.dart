import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/widgets/buttons/doctor_spec_card.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/double_text_widget.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/drawers/profile_drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Привет, ',
              style: TextStyle(
                fontSize: 22,
                color: Constants.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '${user.firstName}!',
              style: const TextStyle(
                color: Colors.red,
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
            ),
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => displayEndDrawer(context),
              icon: const Icon(
                Icons.menu,
              ),
            );
          }),
        ],
        actionsIconTheme: const IconThemeData(
          color: Constants.textColor,
          size: 28,
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(
                      12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Constants.secondColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage('assets/images/firstvariant.png'),
                            ),
                          ),
                        ),
                        const Gap(
                          15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Как вы себя чувствуете?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(
                                8,
                              ),
                              const Text(
                                'Узнайте состояние своего здоровья, прямо сейчас.',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Gap(
                                8,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(
                                    12,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    color: Constants.primaryColor,
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Приступить',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Gap(
                  25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Constants.secondColor,
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.search,
                          size: 32,
                          color: Constants.primaryColor,
                        ),
                        Expanded(
                          child: Text(
                            'Чем мы можем вам помочь?',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(
                  15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const AppDoubleTextWidget(
                    bigText: 'Специалисты',
                    smallText: 'Посмотреть все',
                    navigation: '/spec',
                  ),
                ),
                const Gap(
                  15,
                ),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CategoryCard(
                        image: 'assets/images/dentist.png',
                        docspec: 'Дантист',
                        spec: 'Dentist',
                      ),
                      CategoryCard(
                        image: 'assets/images/surgeon.png',
                        docspec: 'Хирург',
                        spec: 'Surgeon',
                      ),
                      CategoryCard(
                        image: 'assets/images/ophtalmologyst.png',
                        docspec: 'Окулист',
                        spec: 'Ophtalmologyst',
                      ),
                      CategoryCard(
                        image: 'assets/images/therapist.png',
                        docspec: 'Терапевт',
                        spec: 'Therapist',
                      ),
                      CategoryCard(
                        image: 'assets/images/pediatrician.png',
                        docspec: 'Педиатр',
                        spec: 'Pediatrician',
                      ),
                      CategoryCard(
                        image: 'assets/images/urologist.png',
                        docspec: 'Уролог',
                        spec: 'Urologist',
                      ),
                    ],
                  ),
                ),
                const Gap(
                  15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const AppDoubleTextWidget(
                    bigText: '',
                    smallText: 'Посмотреть все',
                    navigation: '/spec',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      endDrawer: const ProfileDrawer(),
    );
  }
}
