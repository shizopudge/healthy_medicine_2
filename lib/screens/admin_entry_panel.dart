import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:routemaster/routemaster.dart';

List<DateTime> firstChangeTimeList = [
  DateTime(0, 0, 0, 9, 20),
  DateTime(0, 0, 0, 9, 50),
  DateTime(0, 0, 0, 10, 20),
  DateTime(0, 0, 0, 10, 50),
  DateTime(0, 0, 0, 11, 20),
  DateTime(0, 0, 0, 11, 50),
  DateTime(0, 0, 0, 13, 20),
  DateTime(0, 0, 0, 13, 50),
];

List<DateTime> secondChangeTimeList = [
  DateTime(0, 0, 0, 13, 40),
  DateTime(0, 0, 0, 14, 10),
  DateTime(0, 0, 0, 14, 40),
  DateTime(0, 0, 0, 15, 10),
  DateTime(0, 0, 0, 16, 40),
  DateTime(0, 0, 0, 17, 10),
  DateTime(0, 0, 0, 17, 40),
  DateTime(0, 0, 0, 18, 10),
];

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
  late List<DateTime> times;
  late int h;
  TextEditingController dateController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();

  bool isDatePicked = false;
  bool isTimePicked = false;

  bool isFirstTimesPicked = false;
  bool isSecondTimesPicked = false;
  bool isOwnTimesPicked = false;

  @override
  void initState() {
    super.initState();
    String spec = ref.read(getDoctorByIdProvider(widget.doctorId)).value!.spec;
    switch (spec) {
      case 'Хирург':
        h = 6;
        break;
      default:
        h = 10;
    }
  }

  void createEntryCell(BuildContext context) {
    ref
        .read(doctorControllerProvider.notifier)
        .createEntryCells(context, widget.doctorId, date, times);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bg,
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
                      isFirstTimesPicked = false;
                      isSecondTimesPicked = false;
                      isOwnTimesPicked = false;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade300,
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 50,
                        color: Constants.primaryColor,
                      ),
                    ),
                  ),
                )
              : null
          : null,
      appBar: AppBar(
        backgroundColor: Constants.bg,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Routemaster.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Constants.textColor,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Text(
            'Выберите дату',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(21),
                color: Colors.grey.shade300,
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
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: InputBorder.none,
                  hintText: 'Дата',
                  hintStyle: TextStyle(
                    color: Constants.primaryColor,
                    fontSize: 32,
                  ),
                ),
                style: const TextStyle(
                  color: Constants.primaryColor,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          const Text(
            'Выберите время',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  times = firstChangeTimeList;
                  isTimePicked = true;
                  isFirstTimesPicked = true;
                  isSecondTimesPicked = false;
                  isOwnTimesPicked = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isFirstTimesPicked
                    ? Colors.green.shade300
                    : Constants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(8),
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
              ),
              child: const Text(
                'Стандартное время для 1 смены',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  times = secondChangeTimeList;
                  isTimePicked = true;
                  isSecondTimesPicked = true;
                  isFirstTimesPicked = false;
                  isOwnTimesPicked = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSecondTimesPicked
                    ? Colors.green.shade300
                    : Constants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(8),
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
              ),
              child: const Text(
                'Стандартное время для 2 смены',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  // times = ownTimes;
                  // isTimePicked = true;
                  isOwnTimesPicked = true;
                  isSecondTimesPicked = false;
                  isFirstTimesPicked = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isOwnTimesPicked
                    ? Colors.green.shade300
                    : Constants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(8),
                minimumSize: const Size(
                  double.infinity,
                  50,
                ),
              ),
              child: const Text(
                'Добавить свое время',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                print(DateTime.now().hour);
                print(DateTime.now().minute);
                print(DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day - 2, 15, 30, 0)
                    .millisecondsSinceEpoch);
                print(DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day - 2, 0, 0, 0)
                    .millisecondsSinceEpoch);
                print(DateTime(0, 0, 0, 15, 30, 0).millisecondsSinceEpoch);
              },
              child: Text('PRESS'))
          // Мб получится сделать лист из дат без выходных и делать ячейки с записями через for на каждую
          // const Text(
          //   'Выберите даты',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 32,
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
          //   child: Container(
          //     width: double.infinity,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(21),
          //       color: Colors.grey.shade300,
          //     ),
          //     child: TextFormField(
          //       controller: dateRangeController,
          //       textAlign: TextAlign.center,
          //       onTap: () => showDateRangePicker(
          //         context: context,
          //         firstDate: DateTime(DateTime.now().year, DateTime.now().month,
          //             DateTime.now().day),
          //         lastDate: DateTime(
          //           DateTime.now().year,
          //           DateTime.now().month + 1,
          //         ),
          //       ),
          //       readOnly: true,
          //       decoration: const InputDecoration(
          //         contentPadding: EdgeInsets.all(8),
          //         border: InputBorder.none,
          //         hintText: 'С ... по ...',
          //         hintStyle: TextStyle(
          //           color: Constants.primaryColor,
          //           fontSize: 32,
          //         ),
          //       ),
          //       style: const TextStyle(
          //         color: Constants.primaryColor,
          //         fontSize: 32,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
