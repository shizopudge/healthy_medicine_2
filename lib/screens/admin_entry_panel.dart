import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/widgets/app_bars/admin_entry_appbar.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';

class AdminEntryPanel extends ConsumerStatefulWidget {
  final String doctorId;
  const AdminEntryPanel({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminEntryPanelState();
}

class _AdminEntryPanelState extends ConsumerState<AdminEntryPanel> {
  late DateTime date;
  List<DateTime> times = [];
  TextEditingController dateController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();

  bool isDatePicked = false;
  bool isTimePicked = false;
  String timePresetId = '';

  void createEntryCell(BuildContext context) {
    ref
        .read(doctorControllerProvider.notifier)
        .createEntryCells(context, widget.doctorId, date, times);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: isDatePicked
          ? isTimePicked
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      createEntryCell(context);
                      print(times);
                      dateController = TextEditingController(text: '');
                      times = [];
                      isDatePicked = false;
                      isTimePicked = false;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                      ),
                      child: const Icon(
                        Icons.add_rounded,
                        size: 50,
                      ),
                    ),
                  ),
                )
              : null
          : null,
      body: SafeArea(
        child: Column(
          children: [
            const AdminEntryAppBar(title: 'Панель управления'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(21),
                  color: Colors.grey.shade400,
                ),
                child: TextFormField(
                  controller: dateController,
                  textAlign: TextAlign.center,
                  onTap: () => showDatePicker(
                    context: context,
                    initialDate: DateTime.now().weekday == 5
                        ? DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day + 3,
                            DateTime.now().hour,
                            DateTime.now().minute)
                        : DateTime.now().weekday == 6
                            ? DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 2,
                                DateTime.now().hour,
                                DateTime.now().minute)
                            : DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 1,
                                DateTime.now().hour,
                                DateTime.now().minute),
                    firstDate: DateTime.now().weekday == 5
                        ? DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day + 3,
                            DateTime.now().hour,
                            DateTime.now().minute)
                        : DateTime.now().weekday == 6
                            ? DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 2,
                                DateTime.now().hour,
                                DateTime.now().minute)
                            : DateTime(
                                DateTime.now().year,
                                DateTime.now().month,
                                DateTime.now().day + 1,
                                DateTime.now().hour,
                                DateTime.now().minute),
                    lastDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day + 14,
                    ),
                    selectableDayPredicate: (DateTime val) =>
                        val.weekday == 6 || val.weekday == 7 ? false : true,
                  ).then((selectedDate) {
                    if (selectedDate != null) {
                      setState(() {
                        date = selectedDate;
                        dateController = TextEditingController(
                            text:
                                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}');
                        isDatePicked = true;
                      });
                    }
                  }),
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    border: InputBorder.none,
                    hintText: 'Дата',
                    hintStyle:
                        AppTheme.dedicatedWhiteTextStyle.copyWith(fontSize: 28),
                  ),
                  style:
                      AppTheme.dedicatedWhiteTextStyle.copyWith(fontSize: 28),
                ),
              ),
            ),
            Text(
              'Выберите время',
              style: AppTheme.headerTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.add_box_rounded,
                    size: 42,
                  ),
                ),
                const Gap(15),
                InkWell(
                  onTap: () {
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.delete_rounded,
                    size: 42,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ref.watch(getUserTimesProvider(user.uid)).when(
                    data: (data) {
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          final userTimes = data[index];
                          return ExpansionTile(
                            onExpansionChanged: (value) {
                              print(userTimes.id);
                            },
                            backgroundColor: AppTheme.indigoColor.shade100,
                            collapsedBackgroundColor: Colors.grey.shade200,
                            title: Text(
                              userTimes.title,
                              style: timePresetId == userTimes.id
                                  ? AppTheme.dedicatedIndigoTextStyle.copyWith(
                                      color: Colors.red.shade300, fontSize: 32)
                                  : AppTheme.dedicatedIndigoTextStyle.copyWith(
                                      fontSize: 32,
                                    ),
                            ),
                            children: [
                              SizedBox(
                                height: 250,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: GridView.builder(
                                        itemCount: userTimes.times.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 5),
                                        itemBuilder: ((context, index) {
                                          final userSingleTime =
                                              userTimes.times[index];
                                          return Card(
                                            color: timePresetId == userTimes.id
                                                ? Colors.red.shade300
                                                : Colors.grey.shade200,
                                            child: Center(
                                              child: Text(
                                                '${userSingleTime.hour}:${userSingleTime.minute}',
                                                style: AppTheme
                                                    .dedicatedIndigoTextStyle
                                                    .copyWith(
                                                  color: timePresetId ==
                                                          userTimes.id
                                                      ? Colors.white
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        timePresetId == userTimes.id
                                            ? setState(() {
                                                times = [];
                                                timePresetId = '';
                                                isTimePicked = false;
                                              })
                                            : setState(() {
                                                times =
                                                    userTimes.times.toList();
                                                timePresetId = userTimes.id;
                                                isTimePicked = true;
                                              });
                                        print(times);
                                        print(timePresetId);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        backgroundColor:
                                            timePresetId == userTimes.id
                                                ? Colors.red.shade300
                                                : null,
                                        elevation: 16,
                                      ),
                                      child: Text(
                                        timePresetId == userTimes.id
                                            ? 'Отмена'
                                            : 'Выбрать',
                                        style: AppTheme.dedicatedIndigoTextStyle
                                            .copyWith(
                                                color:
                                                    timePresetId == userTimes.id
                                                        ? Colors.white
                                                        : null),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      );
                    },
                    error: (error, stackTrace) =>
                        ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
