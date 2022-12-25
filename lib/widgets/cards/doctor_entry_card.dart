import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class DoctorsEntryCard extends ConsumerStatefulWidget {
  final EntryModel entry;
  const DoctorsEntryCard({
    super.key,
    required this.entry,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DoctorsEntryCardState();
}

class _DoctorsEntryCardState extends ConsumerState<DoctorsEntryCard> {
  DateFormat myFormat = DateFormat('kk:mm');
  DateFormat dateFormat = DateFormat('yMd');

  DateTime currentDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime exCurrentDateTime = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    DateTime.now().hour,
    DateTime.now().minute,
  );

  late DateTime entryDate = DateTime(
    widget.entry.dateTime.year,
    widget.entry.dateTime.month,
    widget.entry.dateTime.day,
  );
  late DateTime exEntryDateTime = DateTime(
    widget.entry.dateTime.year,
    widget.entry.dateTime.month,
    widget.entry.dateTime.day,
    widget.entry.dateTime.hour,
    widget.entry.dateTime.minute,
  );

  void navigateToCreateDiagnoseScreen(BuildContext context) {
    Routemaster.of(context)
        .push('/doctor-create-diagnose/${widget.entry.uid}/${widget.entry.id}');
  }

  void navigateToEditDiagnoseScreen(BuildContext context) {
    Routemaster.of(context)
        .push('/doctor-edit-diagnose/${widget.entry.uid}/${widget.entry.id}');
  }

  void navigateToMedicineCardScreen(BuildContext context) {
    Routemaster.of(context).push('/medicine-card/${widget.entry.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          if (!(entryDate.millisecondsSinceEpoch >
                  currentDate.millisecondsSinceEpoch) &&
              !(entryDate.millisecondsSinceEpoch ==
                      currentDate.millisecondsSinceEpoch &&
                  exEntryDateTime.millisecondsSinceEpoch >=
                      exCurrentDateTime.millisecondsSinceEpoch) &&
              widget.entry.isDiagnosisCreated == false) {
            navigateToCreateDiagnoseScreen(context);
          } else if (!(entryDate.millisecondsSinceEpoch >
                  currentDate.millisecondsSinceEpoch) &&
              !(entryDate.millisecondsSinceEpoch ==
                      currentDate.millisecondsSinceEpoch &&
                  exEntryDateTime.millisecondsSinceEpoch >=
                      exCurrentDateTime.millisecondsSinceEpoch) &&
              widget.entry.isDiagnosisCreated == true) {
            navigateToEditDiagnoseScreen(context);
          } else {
            showSnackBar(context,
                'Вы не можете поставить диагноз, т.к. прием еще не прошел');
          }
          print(
              'Сегодняшняя дата (exDate): ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0).millisecondsSinceEpoch}');
          print(
              'Желаемое время (exTime): ${DateTime(1970, 1, 1, 12, 0, 0).millisecondsSinceEpoch}');
          print(
              'Желаемое полное время (dateTime): ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0, 0).millisecondsSinceEpoch}');
          print(
              'Полное время записи (datetime): ${widget.entry.dateTime.millisecondsSinceEpoch}');
          print(
              'Точная дата (exDate): ${widget.entry.exDate.millisecondsSinceEpoch}');
          print(
              'Точное время (exTime): ${widget.entry.exTime.millisecondsSinceEpoch}');
        },
        child: ref.read(getUserDataProvider(widget.entry.uid)).when(
              data: (user) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: entryDate.millisecondsSinceEpoch >
                            currentDate.millisecondsSinceEpoch
                        ? Colors.green.shade200
                        : (entryDate.millisecondsSinceEpoch ==
                                    currentDate.millisecondsSinceEpoch &&
                                exEntryDateTime.millisecondsSinceEpoch >=
                                    exCurrentDateTime.millisecondsSinceEpoch)
                            ? Colors.red.shade300
                            : Colors.grey.shade500,
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => navigateToMedicineCardScreen(context),
                          borderRadius: BorderRadius.circular(21),
                          radius: 55,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                              image: user.avatar != ''
                                  ? DecorationImage(
                                      image: NetworkImage(user.avatar),
                                      fit: BoxFit.cover,
                                    )
                                  : const DecorationImage(
                                      image:
                                          AssetImage(Constants.avatarDefault),
                                      fit: BoxFit.scaleDown,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName} ${user.patronymic}',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                            Text(
                              'Дата: ${dateFormat.format(widget.entry.exDate)}',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                            Text(
                              'Время: ${myFormat.format(widget.entry.exTime)}',
                              style: AppTheme.dedicatedWhiteTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                Expanded(
                                  child: ref
                                      .watch(getClinicByIdProvider(
                                          widget.entry.clinicId))
                                      .when(
                                        data: (clinic) {
                                          return Row(
                                            children: [
                                              Text(
                                                '${clinic.city}, ',
                                                style: AppTheme
                                                    .dedicatedWhiteTextStyle,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  clinic.address,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      AppTheme.whiteTextStyle,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        error: ((error, stackTrace) =>
                                            ErrorText(
                                              error: error.toString(),
                                            )),
                                        loading: () => const Loader(),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      !(entryDate.millisecondsSinceEpoch >
                                  currentDate.millisecondsSinceEpoch) &&
                              !(entryDate.millisecondsSinceEpoch ==
                                      currentDate.millisecondsSinceEpoch &&
                                  exEntryDateTime.millisecondsSinceEpoch >=
                                      exCurrentDateTime.millisecondsSinceEpoch)
                          ? widget.entry.isDiagnosisCreated
                              ? Icon(
                                  Icons.check_box_rounded,
                                  color: Colors.green.shade300,
                                  size: 32,
                                )
                              : const Icon(
                                  Icons.indeterminate_check_box_rounded,
                                  color: Colors.orange,
                                  size: 32,
                                )
                          : const SizedBox(),
                    ],
                  ),
                );
                // return ListTile(
                //   tileColor: //можно изменить и отпарвлять цвет из entriesList (например: где получаю getPastUserEntries
                //       //передавать в entryCard параметр color = Colors.red.shade300)
                //       entryDate.millisecondsSinceEpoch >
                //               currentDate.millisecondsSinceEpoch
                //           ? Colors.green.shade200
                //           : (entryDate.millisecondsSinceEpoch ==
                //                       currentDate.millisecondsSinceEpoch &&
                //                   exEntryDateTime.millisecondsSinceEpoch >=
                //                       exCurrentDateTime.millisecondsSinceEpoch)
                //               ? Colors.red.shade300
                //               : Colors.grey.shade500,
                //   visualDensity: VisualDensity.compact,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   contentPadding: const EdgeInsets.all(8),
                //   title: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         '${user.firstName} ${user.lastName} ${user.patronymic}',
                //         style: AppTheme.dedicatedWhiteTextStyle,
                //       ),
                //       Text(
                //         'Дата: ${dateFormat.format(widget.entry.exDate)}',
                //         style: AppTheme.dedicatedWhiteTextStyle,
                //       ),
                //       Text(
                //         'Время: ${myFormat.format(widget.entry.exTime)}',
                //         style: AppTheme.dedicatedWhiteTextStyle,
                //       ),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           const Icon(
                //             Icons.location_on,
                //             color: Colors.white,
                //             size: 24,
                //           ),
                //           Expanded(
                //             child: ref
                //                 .watch(getClinicByIdProvider(
                //                     widget.entry.clinicId))
                //                 .when(
                //                   data: (clinic) {
                //                     return Row(
                //                       children: [
                //                         Text(
                //                           '${clinic.city}, ',
                //                           style:
                //                               AppTheme.dedicatedWhiteTextStyle,
                //                         ),
                //                         Expanded(
                //                           child: Text(
                //                             clinic.address,
                //                             overflow: TextOverflow.ellipsis,
                //                             style: AppTheme.whiteTextStyle,
                //                           ),
                //                         ),
                //                       ],
                //                     );
                //                   },
                //                   error: ((error, stackTrace) => ErrorText(
                //                         error: error.toString(),
                //                       )),
                //                   loading: () => const Loader(),
                //                 ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                //   trailing: !(entryDate.millisecondsSinceEpoch >
                //               currentDate.millisecondsSinceEpoch) &&
                //           !(entryDate.millisecondsSinceEpoch ==
                //                   currentDate.millisecondsSinceEpoch &&
                //               exEntryDateTime.millisecondsSinceEpoch >=
                //                   exCurrentDateTime.millisecondsSinceEpoch)
                //       ? widget.entry.isDiagnosisCreated
                //           ? Icon(
                //               Icons.check_box_rounded,
                //               color: Colors.green.shade300,
                //               size: 32,
                //             )
                //           : const Icon(
                //               Icons.indeterminate_check_box_rounded,
                //               color: Colors.orange,
                //               size: 32,
                //             )
                //       : const SizedBox(),
                //   leading: InkWell(
                //     onTap: () => navigateToMedicineCardScreen(context),
                //     borderRadius: BorderRadius.circular(21),
                //     radius: 55,
                //     child: Container(
                //       height: 60,
                //       width: 60,
                //       decoration: BoxDecoration(
                //         color: Colors.grey.shade100,
                //         shape: BoxShape.circle,
                //         image: user.avatar != ''
                //             ? DecorationImage(
                //                 image: NetworkImage(user.avatar),
                //                 fit: BoxFit.cover,
                //               )
                //             : const DecorationImage(
                //                 image: AssetImage(Constants.avatarDefault),
                //                 fit: BoxFit.scaleDown,
                //               ),
                //       ),
                //     ),
                //   ),
                // );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
