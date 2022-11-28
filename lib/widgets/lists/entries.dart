import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
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
    return ref
        .watch(
          getUserEntriesProvider(
            UserEntriesParameters(limit: limit, uid: user.uid),
          ),
        )
        .when(
          data: (entryData) {
            return ListView.builder(
              itemCount: entryData.length,
              itemBuilder: (BuildContext context, int index) {
                final entry = entryData[index];
                return EntryCard(entry: entry);
              },
            );
          },
          error: ((error, stackTrace) => ErrorText(
                error: error.toString(),
              )),
          loading: () => const Loader(),
        );
  }
}
