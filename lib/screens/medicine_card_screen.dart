import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/profile_info_widget.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

final isOpenProvider = StateProvider.autoDispose<bool>((ref) => false);

class MedicineCardScreen extends ConsumerWidget {
  final String uid;
  const MedicineCardScreen({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOpen = ref.watch(isOpenProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Routemaster.of(context).pop(),
          borderRadius: BorderRadius.circular(21),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 24,
            color: Colors.indigo,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Медицинская карта',
          style: AppTheme.dedicatedIndigoTextStyle,
        ),
      ),
      body: ref.watch(getUserDataProvider(uid)).when(
          data: (user) {
            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'История приемов',
                            style: AppTheme.dedicatedIndigoTextStyle,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: InkWell(
                                onTap: () {
                                  ref.read(isOpenProvider.notifier).state =
                                      !ref.read(isOpenProvider.notifier).state;
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                          color: Colors.indigo, width: 1),
                                    ),
                                    child: isOpen
                                        ? const Icon(
                                            Icons.remove,
                                            size: 24,
                                          )
                                        : const Icon(
                                            Icons.add,
                                            size: 24,
                                          )),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ref
                                .watch(getUserDiagnosesProvider(uid))
                                .when(
                                  data: (diagnoses) {
                                    return AnimatedSize(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          color: Colors.indigo.shade300,
                                        ),
                                        height: isOpen
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .8
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .5,
                                        child: ListView.builder(
                                            itemCount: diagnoses.length,
                                            itemBuilder: (context, index) {
                                              final diagnose = diagnoses[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Card(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        ref
                                                            .watch(getDoctorByIdProvider(
                                                                diagnose
                                                                    .doctorId))
                                                            .when(
                                                                data: (doctor) {
                                                                  return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                CircleAvatar(
                                                                              backgroundImage: NetworkImage(doctor.image),
                                                                              radius: 32,
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                Text(
                                                                              '${doctor.firstName} ${doctor.lastName} ${doctor.patronymic}',
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: AppTheme.defaultIngidgoText,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        doctor
                                                                            .spec,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: AppTheme
                                                                            .defaultIngidgoText,
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                                error: (error,
                                                                        stackTrace) =>
                                                                    ErrorText(
                                                                        error: error
                                                                            .toString()),
                                                                loading: () =>
                                                                    const Loader()),
                                                        Text(
                                                          diagnose.diagnose !=
                                                                  ''
                                                              ? 'Диагноз: ${diagnose.diagnose}'
                                                              : 'Диагноз: Пусто',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTheme
                                                              .defaultIngidgoText,
                                                        ),
                                                        Text(
                                                          diagnose.recomendations !=
                                                                  ''
                                                              ? 'Рекомендации: ${diagnose.recomendations}'
                                                              : 'Рекомендации: Пусто',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTheme
                                                              .defaultIngidgoText,
                                                        ),
                                                        Text(
                                                          'Медикаменты:',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTheme
                                                              .defaultIngidgoText,
                                                        ),
                                                        diagnose.medicines
                                                                .isNotEmpty
                                                            ? SizedBox(
                                                                height: 50,
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount: diagnose
                                                                      .medicines
                                                                      .length,
                                                                  itemBuilder:
                                                                      ((context,
                                                                          index) {
                                                                    final medicine =
                                                                        diagnose
                                                                            .medicines[index];
                                                                    return Card(
                                                                      color: Colors
                                                                          .indigo,
                                                                      elevation:
                                                                          12,
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            Text(
                                                                          medicine,
                                                                          style:
                                                                              AppTheme.dedicatedWhiteTextStyle,
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ),
                                                              )
                                                            : Text(
                                                                'Пусто',
                                                                style: AppTheme
                                                                    .defaultIngidgoText,
                                                              ),
                                                        Text(
                                                          diagnose.isEdited ==
                                                                  true
                                                              ? 'Изменено: ${DateFormat('yMd').format(diagnose.createdAt)}'
                                                              : 'Заполнено: ${DateFormat('yMd').format(diagnose.createdAt)}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppTheme
                                                              .defaultIngidgoText,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    );
                                  },
                                  error: (error, stackTrace) =>
                                      ErrorText(error: error.toString()),
                                  loading: () => const Loader(),
                                ),
                          ),
                        ],
                      ),
                    ),
                    isOpen
                        ? const SizedBox()
                        : Divider(
                            color: Colors.indigo.shade800,
                            thickness: 1,
                          ),
                    isOpen
                        ? const SizedBox()
                        : Column(
                            children: [
                              ProfileInfoWidget(
                                  title: 'Имя', text: user.firstName),
                              ProfileInfoWidget(
                                  title: 'Фамилия', text: user.lastName),
                              ProfileInfoWidget(
                                  title: 'Отчество', text: user.patronymic),
                              Column(
                                children: [
                                  Text(
                                    'Пол',
                                    style: AppTheme.dedicatedIndigoTextStyle,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      radius: 30,
                                      child: user.gender == 'M'
                                          ? Icon(
                                              Icons.male_rounded,
                                              size: 52,
                                              color: Colors.indigo.shade600,
                                            )
                                          : Icon(
                                              Icons.female_rounded,
                                              size: 52,
                                              color: Colors.indigo.shade600,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              ProfileInfoWidget(
                                  title: 'Номер телефона',
                                  text: '+${user.phone}'),
                              ProfileInfoWidget(
                                  title: 'Email', text: user.email),
                            ],
                          ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
