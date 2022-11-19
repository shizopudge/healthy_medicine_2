import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/common/entry_card.dart';
import 'package:healthy_medicine_2/core/common/error_text.dart';
import 'package:healthy_medicine_2/core/common/loader.dart';
import 'package:healthy_medicine_2/entries/entry_controller.dart';

class ListOfEntries extends ConsumerWidget {
  const ListOfEntries({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return ref.watch(getUserEntriesProvider(user.uid)).when(
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
