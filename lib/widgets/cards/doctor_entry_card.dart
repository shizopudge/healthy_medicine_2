import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/clinics/clinics_controller.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/models/entry_model.dart';
import 'package:intl/intl.dart';

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
      onTap: () {},
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
        elevation: 16,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        child: ref.read(getUserDataProvider(widget.entry.uid)).when(
              data: (user) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      entryDate.millisecondsSinceEpoch >
                              currentDate.millisecondsSinceEpoch
                          ? const SizedBox()
                          : const Icon(
                              CupertinoIcons.check_mark,
                              color: Colors.white,
                              size: 24,
                            ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(36),
                                    onTap: () {},
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(21),
                                        image: user.avatar != ''
                                            ? DecorationImage(
                                                image:
                                                    NetworkImage(user.avatar),
                                                fit: BoxFit.cover,
                                              )
                                            : const DecorationImage(
                                                image: AssetImage(
                                                    Constants.avatarDefault),
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${user.firstName} ${user.lastName} ${user.patronymic}',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.whiteTextStyle,
                                      ),
                                      const Gap(5),
                                      Text(
                                        '+${user.phone}',
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.whiteTextStyle,
                                      ),
                                      const Gap(5),
                                      Text(
                                        user.email,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTheme.whiteTextStyle,
                                      ),
                                      const Gap(5),
                                      Row(
                                        children: [
                                          Text(
                                            'Дата: ',
                                            style: AppTheme
                                                .dedicatedWhiteTextStyle,
                                          ),
                                          Text(
                                            '${widget.entry.exDate.day}/${widget.entry.exDate.month}/${widget.entry.exDate.year}',
                                            style: AppTheme.whiteTextStyle,
                                          ),
                                        ],
                                      ),
                                      const Gap(5),
                                      Row(
                                        children: [
                                          Text(
                                            'Время: ',
                                            style: AppTheme
                                                .dedicatedWhiteTextStyle,
                                          ),
                                          Text(
                                            myFormat
                                                .format(widget.entry.exTime),
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
                    ],
                  ),
                );
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
