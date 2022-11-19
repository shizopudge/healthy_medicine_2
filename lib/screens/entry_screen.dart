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
        .createEntry(doctor, date, time, dateCellId, context);
  }

  bool isDatePicked = false;
  bool isDataEntered = false;
  List<String> times = [];
  String dateCellId = '';
  String date = '';
  String time = '';
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
      body: ref.watch(getEntryCellsProvider(widget.doctorId)).when(
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
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: entryDateCells.length,
                      itemBuilder: (context, index) {
                        final dateCell = entryDateCells[index];
                        return InkWell(
                          onTap: dateCell.time.isNotEmpty
                              ? () {
                                  setState(() {
                                    isDatePicked = true;
                                    dateCellId = dateCell.id;
                                    date = dateCell.date;
                                    times = dateCell.time;
                                  });
                                }
                              : null,
                          child: Card(
                            color: dateCell.time.isNotEmpty
                                ? Colors.blue
                                : Colors.grey,
                            child: Center(
                              child: Text(
                                dateCell.date,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        );
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
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: times.length,
                      itemBuilder: (context, index) {
                        final timeCell = times[index];
                        return InkWell(
                          onTap: timeCell.isNotEmpty
                              ? () {
                                  setState(() {
                                    time = timeCell;
                                    isDataEntered = true;
                                  });
                                  print(date);
                                  print(time);
                                  print(dateCellId);
                                }
                              : null,
                          child: Card(
                            color: Colors.blue,
                            child: Center(
                              child: Text(
                                timeCell,
                                style: const TextStyle(fontSize: 30),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          },
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader()),
    );
  }
}
