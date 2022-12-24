import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';
import 'package:healthy_medicine_2/core/models/diagnose_model.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/text_widgets/add_doctor_textfield.dart';
import 'package:routemaster/routemaster.dart';

class CreateDiagnoseScreen extends ConsumerStatefulWidget {
  final String uid;
  final String entryId;
  const CreateDiagnoseScreen({
    super.key,
    required this.uid,
    required this.entryId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateDiagnoseScreenState();
}

class _CreateDiagnoseScreenState extends ConsumerState<CreateDiagnoseScreen> {
  TextEditingController diagnoseController = TextEditingController();
  TextEditingController recomendationsController = TextEditingController();
  TextEditingController medicinesController = TextEditingController();
  List<String> meds = [];

  @override
  void dispose() {
    super.dispose();
    diagnoseController.dispose();
    recomendationsController.dispose();
    medicinesController.dispose();
  }

  bool checkIsMedsContain(String addedMed) {
    if (meds.isNotEmpty && meds.contains(addedMed)) {
      return true;
    } else {
      return false;
    }
  }

  void createDiagnose(String doctorId) {
    ref.read(entryControllerProvider.notifier).createDiagnose(
        Diagnose(
          id: widget.entryId,
          diagnose: diagnoseController.text.trim(),
          doctorId: doctorId,
          uid: widget.uid,
          recomendations: recomendationsController.text.trim(),
          medicines: meds,
          createdAt: DateTime.now(),
          isEdited: false,
        ),
        context);
  }

  bool isDiagnoseKnown = true;
  bool isNeedMedicalHealing = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final doctorId = ref.watch(userProvider)!.doctorId;
    final isLoading = ref.watch(entryControllerProvider);
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
          'Форма по приему',
          style: AppTheme.dedicatedIndigoTextStyle,
        ),
      ),
      body: isLoading
          ? const Loader()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Вам удалось поставить диагноз?',
                                      style: AppTheme.defaultIngidgoText
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  Checkbox(
                                      activeColor: Colors.indigo,
                                      side: const BorderSide(
                                          color: Colors.indigo, width: 1.8),
                                      value: isDiagnoseKnown,
                                      onChanged: (value) {
                                        setState(() {
                                          isDiagnoseKnown = value!;
                                        });
                                      }),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Требуется ли медикаментозное лечение?',
                                      style: AppTheme.defaultIngidgoText
                                          .copyWith(fontSize: 16),
                                    ),
                                  ),
                                  Checkbox(
                                      activeColor: Colors.indigo,
                                      side: const BorderSide(
                                          color: Colors.indigo, width: 1.8),
                                      value: isNeedMedicalHealing,
                                      onChanged: (value) {
                                        setState(() {
                                          isNeedMedicalHealing = value!;
                                        });
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      isDiagnoseKnown
                          ? AddDoctorTextField(
                              title: 'Диагноз',
                              controller: diagnoseController,
                              isNumber: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Вы не написали диагноз';
                                } else {
                                  return null;
                                }
                              },
                            )
                          : const SizedBox(),
                      isNeedMedicalHealing
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          'Медикаменты',
                                          style: AppTheme
                                              .dedicatedIndigoTextStyle
                                              .copyWith(
                                            fontWeight: FontWeight.w100,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 55,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(21),
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextFormField(
                                            controller: medicinesController,
                                            decoration: InputDecoration(
                                              errorStyle: AppTheme
                                                  .dedicatedIndigoTextStyle
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                              border: InputBorder.none,
                                              counterText: '',
                                            ),
                                            cursorColor: Colors.indigo,
                                            style: AppTheme
                                                .dedicatedIndigoTextStyle,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Spacer(
                                            flex: 2,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              final check = checkIsMedsContain(
                                                  medicinesController.text);
                                              if (medicinesController.text !=
                                                      '' &&
                                                  check == false) {
                                                meds.add(
                                                    medicinesController.text);
                                                medicinesController.clear();
                                                medicinesController
                                                    .selection.start;
                                              } else if (medicinesController
                                                          .text !=
                                                      '' &&
                                                  check == true) {
                                                showSnackBar(context,
                                                    'Вы уже добавили этот медикамент');
                                              } else {
                                                showSnackBar(context,
                                                    'Введите наименование медикамена');
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                const Icon(
                                                  Icons.add_box_rounded,
                                                  size: 44,
                                                  color: Colors.indigo,
                                                ),
                                                Text(
                                                  'Добавить',
                                                  style: AppTheme
                                                      .defaultIngidgoText
                                                      .copyWith(
                                                    fontSize: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Spacer(
                                            flex: 1,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (meds.isNotEmpty) {
                                                meds.clear();
                                              } else {
                                                showSnackBar(context,
                                                    'Список медикаментов пуст...');
                                              }
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.clear_all_outlined,
                                                  size: 44,
                                                  color: Colors.red.shade300,
                                                ),
                                                Text(
                                                  'Очистить',
                                                  style: AppTheme
                                                      .defaultIngidgoText
                                                      .copyWith(
                                                    fontSize: 14,
                                                    color: Colors.red.shade300,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const Spacer(
                                            flex: 2,
                                          ),
                                        ],
                                      ),
                                      AnimatedSize(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: Container(
                                          height: meds.isNotEmpty ? 225 : 0,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(8),
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.grey.shade300,
                                          ),
                                          child: ListView.builder(
                                              itemCount: meds.length,
                                              itemBuilder: ((context, index) {
                                                final med = meds[index];
                                                return Slidable(
                                                  endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          meds.removeAt(index);
                                                        },
                                                        backgroundColor:
                                                            Colors.red.shade300,
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(21),
                                                        label: 'Удалить',
                                                      ),
                                                    ],
                                                  ),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    margin:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors
                                                          .indigo.shade400,
                                                    ),
                                                    child: Text(
                                                      med,
                                                      style: AppTheme
                                                          .defaultIngidgoText
                                                          .copyWith(
                                                              fontSize: 28,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                );
                                              })),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 2,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Рекомендации',
                                style:
                                    AppTheme.dedicatedIndigoTextStyle.copyWith(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(21),
                                color: Colors.grey.shade300,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  controller: recomendationsController,
                                  decoration: InputDecoration(
                                    errorStyle: AppTheme
                                        .dedicatedIndigoTextStyle
                                        .copyWith(
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    counterText: '',
                                  ),
                                  maxLength: 200,
                                  maxLines: 5,
                                  cursorColor: Colors.indigo,
                                  style: AppTheme.dedicatedIndigoTextStyle,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Вы не написали рекомендации';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (isNeedMedicalHealing == true) {
                              if (_formKey.currentState!.validate() &&
                                  meds.isNotEmpty) {
                                _formKey.currentState!.save();
                                createDiagnose(doctorId);
                              }
                              if (meds.isEmpty) {
                                showSnackBar(
                                    context, 'Вы не добавили ни 1 медикамента');
                              }
                            } else {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                createDiagnose(doctorId);
                              }
                            }
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
                            'Отправить',
                            style: AppTheme.dedicatedIndigoTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
