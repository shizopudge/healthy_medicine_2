import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';
import 'package:healthy_medicine_2/core/models/doctor_model.dart';
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
    ref.read(entryControllerProvider.notifier).createEntry(
        doctor, date, time, date, pickedDateCellId.trim(), context);
  }

  int currentMonthNumber = DateTime.now().month;
  int currentDay = DateTime.now().day;
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
  String pickedDateCellId = '';
  DateTime pickedTime = DateTime.now();
  late DateTime date;
  late DateTime time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isDataEntered
          ? ref.watch(getDoctorByIdProvider(widget.doctorId)).when(
              data: (doctor) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 42),
                  ),
                  onPressed: () async {
                    setState(() {
                      date = DateTime(date.year, date.month, date.day,
                          time.hour, time.minute, 0);
                    });
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
      body: SafeArea(
        child: ref
            .watch(
              getEntryCellsByMonthAndYearProvider(
                MyParameter2(
                  monthNumber: currentMonthNumber,
                  doctorId: widget.doctorId,
                  year: currentYear,
                  day: currentDay,
                ),
              ),
            )
            .when(
                data: (entryDateCells) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () => Routemaster.of(context).pop(),
                            borderRadius: BorderRadius.circular(21),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(32),
                                color: Colors.grey.shade200,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Выберите дату',
                          textAlign: TextAlign.center,
                          style: AppTheme.headerTextStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          currentYear.toString(),
                          textAlign: TextAlign.center,
                          style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                            color: AppTheme.indigoColor,
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
                                        currentDay = DateTime.now().day;
                                        currentYear--;
                                      });
                                    } else {
                                      setState(() {
                                        currentMonthNumber =
                                            currentMonthNumber - 1;
                                        currentDay = DateTime.now().day;
                                      });
                                    }
                                    setState(() {
                                      k--;
                                      isDatePicked = false;
                                      time = DateTime.now();
                                      pickedTime = DateTime.now();
                                      isDataEntered = false;
                                      isDatePicked = false;
                                      pickedDateCellId = '';
                                      date = DateTime.now();
                                      times = [];
                                    });
                                    print(currentMonthNumber);
                                    print(currentDay);
                                    getCurrentMounth();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_outlined,
                                    size: 26,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              currentMonth,
                              textAlign: TextAlign.center,
                              style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                                color: AppTheme.indigoColor,
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
                                        currentDay = 0;
                                        currentYear++;
                                      });
                                    } else {
                                      setState(() {
                                        currentMonthNumber =
                                            currentMonthNumber + 1;
                                        currentDay = 0;
                                      });
                                    }
                                    setState(() {
                                      k++;
                                      isDatePicked = false;
                                      time = DateTime.now();
                                      pickedTime = DateTime.now();
                                      isDataEntered = false;
                                      isDatePicked = false;
                                      pickedDateCellId = '';
                                      date = DateTime.now();
                                      times = [];
                                    });
                                    print(currentMonthNumber);
                                    print(currentDay);
                                    getCurrentMounth();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 26,
                                  )),
                        ],
                      ),
                      entryDateCells.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5),
                                itemCount: entryDateCells.length,
                                itemBuilder: (context, index) {
                                  final dateCell = entryDateCells[index];
                                  // if (dateCell.date.month == currentMonthNumber) {
                                  return InkWell(
                                    onTap: dateCell.time.isNotEmpty
                                        ? () {
                                            setState(() {
                                              isDatePicked = true;
                                              pickedDateCellId = dateCell.id;
                                              date = dateCell.date;
                                              times = dateCell.time;
                                            });
                                            print(pickedDateCellId.trim());
                                            print(date);
                                          }
                                        : null,
                                    child: Card(
                                      color: pickedDateCellId == dateCell.id
                                          ? AppTheme.redColor
                                          : dateCell.time.isNotEmpty
                                              ? AppTheme.indigoColor
                                              : Colors.grey,
                                      child: Center(
                                        child: Text(
                                          dateCell.date.day.toString(),
                                          style:
                                              AppTheme.dedicatedWhiteTextStyle,
                                        ),
                                      ),
                                    ),
                                  );
                                  // }
                                  // return const SizedBox();
                                },
                              ),
                            )
                          : Column(
                              children: [
                                Image.asset('assets/images/secondvariant.png'),
                                Text(
                                  'Извините, но похоже нет свободных записей на этот месяц...',
                                  textAlign: TextAlign.center,
                                  style: AppTheme.noDataTextStyle,
                                ),
                              ],
                            ),
                      isDatePicked
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Выберите время',
                                textAlign: TextAlign.center,
                                style:
                                    AppTheme.dedicatedWhiteTextStyle.copyWith(
                                  color: AppTheme.indigoColor,
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
                                          pickedTime = timeCell;
                                          isDataEntered = true;
                                        });
                                        print(time);
                                        print(pickedTime);
                                        print(pickedDateCellId);
                                      },
                                      child: Card(
                                        color: pickedTime == timeCell
                                            ? AppTheme.redColor
                                            : AppTheme.indigoColor,
                                        child: Center(
                                          child: Text(
                                            '${timeCell.hour}:${timeCell.minute}',
                                            style: AppTheme
                                                .dedicatedWhiteTextStyle,
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
                error: (error, stackTrace) =>
                    ErrorText(error: error.toString()),
                loading: () => const Loader()),
      ),
    );
  }
}
