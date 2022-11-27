import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/widgets/lists/entries.dart';
import 'package:healthy_medicine_2/core/constants.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Constants.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Ваша история приемов',
                  style: TextStyle(
                    color: Constants.textColor,
                    fontSize: 36,
                  ),
                ),
              ),
              Expanded(
                child: ListOfEntries(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
