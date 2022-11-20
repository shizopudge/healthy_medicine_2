import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/common/error_text.dart';
import 'package:healthy_medicine_2/core/common/loader.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/entries/entry_controller.dart';
import 'package:healthy_medicine_2/models/doctor_model.dart';
import 'package:routemaster/routemaster.dart';

class EntryScreen extends ConsumerStatefulWidget {
  final String doctorId;
  const EntryScreen({
    super.key,
    required this.doctorId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EntryScreenState();
}

class _EntryScreenState extends ConsumerState<EntryScreen> {
  void createEntry(Doctor doctor) {
    ref
        .read(entryControllerProvider.notifier)
        .createEntry(doctor, date, time, dateCellId.trim(), context);
  }

  int currentMonthNumber = DateTime.now().month;
  late String currentMonth;
  int currentYear = DateTime.now().year;
  int k = 0;

  getCurrentMounth() {
    switch (currentMonthNumber) {
      case 1:
        currentMonth = 'Январь';
        break;
      case 2:
        currentMonth = 'Февраль';
        break;
      case 3:
        currentMonth = 'Март';
        break;
      case 4:
        currentMonth = 'Апрель';
        break;
      case 5:
        currentMonth = 'Май';
        break;
      case 6:
        currentMonth = 'Июнь';
        break;
      case 7:
        currentMonth = 'Июль';
        break;
      case 8:
        currentMonth = 'Август';
        break;
      case 9:
        currentMonth = 'Сентябрь';
        break;
      case 10:
        currentMonth = 'Октябрь';
        break;
      case 11:
        currentMonth = 'Ноябрь';
        break;
      case 12:
        currentMonth = 'Декабрь';
        break;
      default:
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentMounth();
    print(currentMonthNumber);
  }

  bool isDatePicked = false;
  bool isDataEntered = false;
  bool isDateCellTapped = false;
  bool isTimeCellTapped = false;
  List<DateTime> times = [];
  String dateCellId = '';
  late DateTime date;
  late DateTime time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bg,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isDataEntered
          ? ref.watch(getDoctorByIdProvider(widget.doctorId)).when(
              data: (doctor) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.primaryColor,
                    minimumSize: const Size(250, 42),
                  ),
                  onPressed: () {
                    createEntry(doctor);
                    // deleteEntryTime();
                  },
                  child: const Text(
                    'Записаться',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader())
          : null,
      body: ref
          .watch(getEntryCellsByMonthAndYearProvider(MyParameter2(
              monthNumber: currentMonthNumber,
              doctorId: widget.doctorId,
              year: currentYear)))
          .when(
              data: (entryDateCells) {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Выберите дату',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        currentYear.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        k == 0
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  if (currentMonthNumber == 1) {
                                    setState(() {
                                      currentMonthNumber = 12;
                                      currentYear--;
                                    });
                                  } else {
                                    setState(() {
                                      currentMonthNumber =
                                          currentMonthNumber - 1;
                                    });
                                  }
                                  setState(() {
                                    k--;
                                    isDatePicked = false;
                                  });
                                  print(currentMonthNumber);
                                  getCurrentMounth();
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: 26,
                                  color: Colors.white,
                                )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            currentMonth,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        k > 0
                            ? const SizedBox()
                            : IconButton(
                                onPressed: () {
                                  if (currentMonthNumber == 12) {
                                    setState(() {
                                      currentMonthNumber = 1;
                                      currentYear++;
                                    });
                                  } else {
                                    setState(() {
                                      currentMonthNumber =
                                          currentMonthNumber + 1;
                                    });
                                  }
                                  setState(() {
                                    k++;
                                    isDatePicked = false;
                                  });
                                  print(currentMonthNumber);
                                  getCurrentMounth();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 26,
                                  color: Colors.white,
                                )),
                      ],
                    ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     itemCount: entryDateCells.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       final dateCell = entryDateCells[index];
                    //       if (dateCell.date.month == DateTime.now().month &&
                    //           dateCell.date.day > DateTime.now().day) {
                    //         return InkWell(
                    //           onTap: dateCell.time.isNotEmpty
                    //               ? () {
                    //                   setState(() {
                    //                     isDatePicked = true;
                    //                     dateCellId = dateCell.id;
                    //                     date = dateCell.date;
                    //                     times = dateCell.time;
                    //                   });
                    //                   print(dateCellId.trim());
                    //                 }
                    //               : null,
                    //           child: Card(
                    //             color: dateCell.time.isNotEmpty
                    //                 ? Colors.blue
                    //                 : Colors.grey,
                    //             child: Center(
                    //               child: Text(
                    //                 dateCell.date.day.toString(),
                    //                 style: const TextStyle(fontSize: 30),
                    //               ),
                    //             ),
                    //           ),
                    //         );
                    //       }
                    //       return const SizedBox();
                    //     },
                    //   ),
                    // ),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5),
                          itemCount: entryDateCells.length,
                          itemBuilder: (context, index) {
                            final dateCell = entryDateCells[index];
                            if (dateCell.date.month == currentMonthNumber) {
                              return InkWell(
                                onTap: dateCell.time.isNotEmpty
                                    ? () {
                                        setState(() {
                                          isDatePicked = true;
                                          dateCellId = dateCell.id;
                                          date = dateCell.date;
                                          times = dateCell.time;
                                        });
                                        print(dateCellId.trim());
                                      }
                                    : null,
                                child: Card(
                                  color: dateCell.time.isNotEmpty
                                      ? Colors.blue
                                      : Colors.grey,
                                  child: Center(
                                    child: Text(
                                      dateCell.date.day.toString(),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          }),
                    ),
                    isDatePicked
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Выберите время',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    isDatePicked
                        ? Expanded(
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5),
                                itemCount: times.length,
                                itemBuilder: (context, index) {
                                  final timeCell = times[index];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        time = timeCell;
                                        isDataEntered = true;
                                      });
                                      print(date);
                                      print(time);
                                      print(dateCellId);
                                    },
                                    child: Card(
                                      color: Colors.blue,
                                      child: Center(
                                        child: Text(
                                          '${timeCell.hour}:${timeCell.minute}',
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : const SizedBox(),
                  ],
                );
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader()),
    );
  }
}
