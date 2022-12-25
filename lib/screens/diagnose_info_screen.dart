import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class DiagnoseInfoScreen extends ConsumerWidget {
  final String diagnoseId;
  final String uid;
  const DiagnoseInfoScreen({
    super.key,
    required this.diagnoseId,
    required this.uid,
  });

  void navigateToEditDiagnoseScreen(BuildContext context, String entryId) {
    Routemaster.of(context).push('/doctor-edit-diagnose/$uid/$entryId');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doctorId = ref.watch(userProvider)!.doctorId;
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
          'Информация о приеме',
          style: AppTheme.dedicatedIndigoTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: ref
              .watch(getUserDiagnoseByIdProvider(
                  DiagnoseParameters(uid: uid, diagnoseId: diagnoseId)))
              .when(
                data: (diagnose) {
                  return Column(
                    children: [
                      diagnose.diagnose != ''
                          ? TextInfo(
                              title: 'Диагноз', content: diagnose.diagnose)
                          : const SizedBox(),
                      TextInfo(
                          title: 'Рекомендации',
                          content: diagnose.recomendations),
                      diagnose.medicines.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Медикаменты',
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.dedicatedIndigoTextStyle,
                              ),
                            )
                          : const SizedBox(),
                      diagnose.medicines.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey.shade200,
                                ),
                                padding: const EdgeInsets.all(8),
                                height: 200,
                                child: ListView.builder(
                                  itemCount: diagnose.medicines.length,
                                  itemBuilder: (context, index) {
                                    final medicine = diagnose.medicines[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: Card(
                                        color: Colors.indigo.shade300,
                                        elevation: 0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              medicine,
                                              style: AppTheme
                                                  .dedicatedWhiteTextStyle,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const SizedBox(),
                      ref.watch(getDoctorByIdProvider(diagnose.doctorId)).when(
                            data: (doctor) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Врач',
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    ),
                                  ),
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(doctor.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200,
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(8),
                                    child: Text(
                                      '${doctor.firstName} ${doctor.lastName}',
                                      textAlign: TextAlign.center,
                                      style: AppTheme.dedicatedIndigoTextStyle,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.grey.shade200,
                                    ),
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(8),
                                    margin: const EdgeInsets.all(8),
                                    child: Text(
                                      doctor.spec,
                                      textAlign: TextAlign.center,
                                      style: AppTheme.dedicatedIndigoTextStyle,
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
                      ref.watch(getEntryByIdProvider(diagnoseId)).when(
                            data: (entry) {
                              return TextInfo(
                                  title: 'Дата приема',
                                  content:
                                      DateFormat('yMd').format(entry.dateTime));
                            },
                            error: ((error, stackTrace) => ErrorText(
                                  error: error.toString(),
                                )),
                            loading: () => const Loader(),
                          ),
                      TextInfo(
                          title: diagnose.isEdited ? 'Изменено' : 'Заполнено',
                          content:
                              DateFormat('yMd').format(diagnose.createdAt)),
                      diagnose.doctorId == doctorId
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  navigateToEditDiagnoseScreen(
                                      context, diagnose.id);
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  backgroundColor: Colors.grey.shade200,
                                  elevation: 16,
                                  minimumSize: const Size(double.infinity, 60),
                                ),
                                child: Text(
                                  'Изменить',
                                  style: AppTheme.dedicatedIndigoTextStyle,
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  );
                },
                error: ((error, stackTrace) => ErrorText(
                      error: error.toString(),
                    )),
                loading: () => const Loader(),
              ),
        ),
      ),
    );
  }
}

class TextInfo extends StatelessWidget {
  final String title;
  final String content;
  const TextInfo({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: AppTheme.dedicatedIndigoTextStyle,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          child: Text(
            content,
            textAlign: TextAlign.center,
            style: AppTheme.dedicatedIndigoTextStyle,
          ),
        ),
      ],
    );
  }
}
