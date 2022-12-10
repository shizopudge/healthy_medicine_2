import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/screens/history_screen.dart';
import 'package:healthy_medicine_2/widgets/cards/entry_card.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';

class ListOfEntries extends ConsumerWidget {
  final int limit;
  final bool isComingInTime;
  final bool isUpcoming;
  final bool isPast;
  final bool isNothing;
  const ListOfEntries({
    super.key,
    required this.limit,
    required this.isComingInTime,
    required this.isUpcoming,
    required this.isPast,
    required this.isNothing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return isComingInTime
        ? ref
            .watch(getComingInTimeUserEntriesProvider(UserEntriesParameters(
                limit: limit,
                uid: user.uid,
                descendingType:
                    ref.read(descendingTypeProvider.notifier).state)))
            .when(
              data: ((entries) {
                return ListView.builder(
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      final entry = entries[index];
                      return EntryCard(entry: entry);
                    });
              }),
              error: ((error, stackTrace) => ErrorText(
                    error: error.toString(),
                  )),
              loading: () => const Loader(),
            )
        : isUpcoming
            ? ref
                .watch(getUpcomingUserEntriesProvider(UserEntriesParameters(
                    limit: limit,
                    uid: user.uid,
                    descendingType:
                        ref.read(descendingTypeProvider.notifier).state)))
                .when(
                  data: ((entries) {
                    return ListView.builder(
                        itemCount: entries.length,
                        itemBuilder: (BuildContext context, int index) {
                          final entry = entries[index];
                          return EntryCard(entry: entry);
                        });
                  }),
                  error: ((error, stackTrace) => ErrorText(
                        error: error.toString(),
                      )),
                  loading: () => const Loader(),
                )
            : isPast
                ? ref
                    .watch(getPastUserEntriesProvider(UserEntriesParameters(
                        limit: limit,
                        uid: user.uid,
                        descendingType:
                            ref.read(descendingTypeProvider.notifier).state)))
                    .when(
                      data: ((entries) {
                        return ListView.builder(
                            itemCount: entries.length,
                            itemBuilder: (BuildContext context, int index) {
                              final entry = entries[index];
                              return EntryCard(entry: entry);
                            });
                      }),
                      error: ((error, stackTrace) => ErrorText(
                            error: error.toString(),
                          )),
                      loading: () => const Loader(),
                    )
                : isNothing
                    ? ref
                        .watch(getAllUserEntriesProvider(UserEntriesParameters(
                            limit: limit,
                            uid: user.uid,
                            descendingType: ref
                                .read(descendingTypeProvider.notifier)
                                .state)))
                        .when(
                          data: ((entries) {
                            return ListView.builder(
                                itemCount: entries.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final entry = entries[index];
                                  return EntryCard(entry: entry);
                                });
                          }),
                          error: ((error, stackTrace) => ErrorText(
                                error: error.toString(),
                              )),
                          loading: () => const Loader(),
                        )
                    : const SizedBox();
    // DateTime currentDate = DateTime(
    //   DateTime.now().year,
    //   DateTime.now().month,
    //   DateTime.now().day,
    // );
    // DateTime exCurrentDateTime = DateTime(
    //   DateTime.now().year,
    //   DateTime.now().month,
    //   DateTime.now().day,
    //   DateTime.now().hour,
    //   DateTime.now().minute,
    // );
    // late DateTime entryDateTime;
    // late DateTime exEntryDateTime;

    // final user = ref.watch(userProvider)!;
    // return ref
    //     .watch(
    //       getUserEntriesProvider(
    //         UserEntriesParameters(
    //             limit: limit,
    //             uid: user.uid,
    //             descendingType:
    //                 ref.read(descendingTypeProvider.notifier).state),
    //       ),
    //     )
    //     .when(
    //       data: (entryData) {
    //         return ListView.builder(
    //           itemCount: entryData.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             final entry = entryData[index];
    //             entryDateTime = DateTime(
    //               entry.date.year,
    //               entry.date.month,
    //               entry.date.day,
    //             );
    //             exEntryDateTime = DateTime(
    //               entry.date.year,
    //               entry.date.month,
    //               entry.date.day,
    //               entry.time.hour,
    //               entry.time.minute,
    //             );
    //             if (isNothing) {
    //               return EntryCard(entry: entry);
    //             }
    //             if (isUpcoming) {
    //               if ((entryDateTime.millisecondsSinceEpoch >
    //                       currentDate.millisecondsSinceEpoch) ||
    //                   (entryDateTime.millisecondsSinceEpoch ==
    //                           currentDate.millisecondsSinceEpoch &&
    //                       exEntryDateTime.millisecondsSinceEpoch >=
    //                           exCurrentDateTime.millisecondsSinceEpoch)) {
    //                 return EntryCard(entry: entry);
    //               }
    //             }
    //             if (isComingInTime) {
    //               if (entryDateTime.millisecondsSinceEpoch ==
    //                       currentDate.millisecondsSinceEpoch &&
    //                   exEntryDateTime.millisecondsSinceEpoch >=
    //                       exCurrentDateTime.millisecondsSinceEpoch) {
    //                 return EntryCard(entry: entry);
    //               }
    //             }
    //             if (isPast) {
    //               if ((entryDateTime.millisecondsSinceEpoch ==
    //                           currentDate.millisecondsSinceEpoch &&
    //                       exEntryDateTime.millisecondsSinceEpoch <
    //                           exCurrentDateTime.millisecondsSinceEpoch) ||
    //                   (entryDateTime.millisecondsSinceEpoch <
    //                       currentDate.millisecondsSinceEpoch)) {
    //                 return EntryCard(entry: entry);
    //               }
    //             }
    //             return const SizedBox();
    //           },
    //         );
    //       },
    //       error: ((error, stackTrace) => ErrorText(
    //             error: error.toString(),
    //           )),
    //       loading: () => const Loader(),
    //     );
  }
}
