import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class EntryCard extends ConsumerStatefulWidget {
  final EntryModel entry;
  const EntryCard({
    super.key,
    required this.entry,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryCardState();
}

class _EntryCardState extends ConsumerState<EntryCard> {
  void navigateToDoctorScreen(BuildContext context) {
    Routemaster.of(context).push('/doctor/${widget.entry.doctorId}');
  }

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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(
            'Сегодняшняя дата (exDate): ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0).millisecondsSinceEpoch}');
        print(
            'Желаемое время (exTime): ${DateTime(1970, 1, 1, 11, 20, 0).millisecondsSinceEpoch}');
        print(
            'Желаемое полное время (dateTime): ${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20, 0).millisecondsSinceEpoch}');
        print(
            'Полное время записи (datetime): ${widget.entry.dateTime.millisecondsSinceEpoch}');
        print(
            'Точная дата (exDate): ${widget.entry.exDate.millisecondsSinceEpoch}');
        print(
            'Точное время (exTime): ${widget.entry.exTime.millisecondsSinceEpoch}');
      },
      child: Card(
        color: //можно изменить и отпарвлять цвет из entriesList (например: где получаю getPastUserEntries
            //передавать в entryCard параметр color = Colors.red.shade300)
            entryDate.millisecondsSinceEpoch >
                    currentDate.millisecondsSinceEpoch
                ? Colors.green.shade200
                : (entryDate.millisecondsSinceEpoch ==
                            currentDate.millisecondsSinceEpoch &&
                        exEntryDateTime.millisecondsSinceEpoch >=
                            exCurrentDateTime.millisecondsSinceEpoch)
                    ? Colors.red.shade300
                    : Colors.grey.shade500,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Text(
                '${widget.entry.serviceCost} руб.',
                overflow: TextOverflow.ellipsis,
                style: AppTheme.dedicatedWhiteTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(36),
                            onTap: () => navigateToDoctorScreen(context),
                            child: Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(21),
                                image: DecorationImage(
                                  image: NetworkImage(widget.entry.doctorImage),
                                  fit: BoxFit.cover,
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
                                'Д-р. ${widget.entry.doctorFirstName}',
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.whiteTextStyle,
                              ),
                              const Gap(5),
                              Text(
                                widget.entry.doctorSpec,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.whiteTextStyle,
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Text(
                                    'Дата: ',
                                    style: AppTheme.dedicatedWhiteTextStyle,
                                  ),
                                  Text(
                                    dateFormat.format(widget.entry.exDate),
                                    style: AppTheme.whiteTextStyle,
                                  ),
                                ],
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Text(
                                    'Время: ',
                                    style: AppTheme.dedicatedWhiteTextStyle,
                                  ),
                                  Text(
                                    myFormat.format(widget.entry.exTime),
                                    style: AppTheme.whiteTextStyle,
                                  ),
                                ],
                              ),
                              const Gap(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: ref
                              .watch(
                                  getClinicByIdProvider(widget.entry.clinicId))
                              .when(
                                data: (clinic) {
                                  return Row(
                                    children: [
                                      Text(
                                        '${clinic.city}, ',
                                        style: AppTheme.dedicatedWhiteTextStyle,
                                      ),
                                      Expanded(
                                        child: Text(
                                          clinic.address,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTheme.whiteTextStyle,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                error: ((error, stackTrace) => ErrorText(
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
            ],
          ),
        ),
      ),
    );
  }
}
