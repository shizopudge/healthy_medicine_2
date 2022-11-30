import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';
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
    widget.entry.date.year,
    widget.entry.date.month,
    widget.entry.date.day,
  );
  late DateTime exEntryDateTime = DateTime(
    widget.entry.date.year,
    widget.entry.date.month,
    widget.entry.date.day,
    widget.entry.time.hour,
    widget.entry.time.minute,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(entryDate);
        print(exEntryDateTime);
      },
      child: Card(
        color: entryDate.millisecondsSinceEpoch >
                currentDate.millisecondsSinceEpoch
            ? Colors.green.shade100
            : (entryDate.millisecondsSinceEpoch ==
                        currentDate.millisecondsSinceEpoch &&
                    exEntryDateTime.millisecondsSinceEpoch >=
                        exCurrentDateTime.millisecondsSinceEpoch)
                ? Colors.orange.shade100
                : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(21),
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
                style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                  color: AppTheme.redColor,
                ),
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
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.entry.doctorImage),
                              backgroundColor: Colors.white,
                              radius: 55,
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
                                    '${widget.entry.date.day}/${widget.entry.date.month}/${widget.entry.date.year}',
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
                                    '${widget.entry.time.hour}:${widget.entry.time.minute}',
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
