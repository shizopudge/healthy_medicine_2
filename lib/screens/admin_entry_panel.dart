import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/doctors/doctors_controller.dart';
import 'package:routemaster/routemaster.dart';

List<DateTime> firstChangeTimeList = [
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 20),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 50),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 20),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 50),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 20),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 11, 50),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 13, 20),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 13, 50),
];

List<DateTime> secondChangeTimeList = [
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 13, 40),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 10),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 14, 40),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 10),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 16, 40),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 10),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 17, 40),
  DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 18, 10),
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
  // DateTime date = DateTime(DateTime.now().year, DateTime.now().month,
  //     DateTime.now().day + 3, DateTime.now().hour, DateTime.now().minute);
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
    // for (var i = 0; i < 10; i++) {
    //   h++;
    //   DateTime time = DateTime(
    //       DateTime.now().year, DateTime.now().month, DateTime.now().day, h, 30);
    //   times.add(time);
    // }
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
                  initialDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day + 1,
                      DateTime.now().hour,
                      DateTime.now().minute),
                  firstDate: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day),
                  lastDate: DateTime(
                    DateTime.now().year,
                    DateTime.now().month + 1,
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
