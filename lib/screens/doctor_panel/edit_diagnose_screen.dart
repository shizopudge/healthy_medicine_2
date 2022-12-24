import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';
import 'package:healthy_medicine_2/screens/doctor_panel/edit_diagnose.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';

class EditDiagnoseScreen extends ConsumerWidget {
  final String uid;
  final String entryId;
  const EditDiagnoseScreen({
    super.key,
    required this.uid,
    required this.entryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref
          .watch(getUserDiagnoseByIdProvider(
              DiagnoseParameters(uid: uid, diagnoseId: entryId)))
          .when(
            data: (diagnose) {
              return EditDiagnoseForm(
                diagnose: diagnose,
              );
            },
            error: (error, stackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
