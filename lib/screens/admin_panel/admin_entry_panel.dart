import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/core/auth/auth_controller.dart';
import 'package:healthy_medicine_2/core/doctors/doctors_controller.dart';
import 'package:healthy_medicine_2/core/entries/entry_controller.dart';
import 'package:healthy_medicine_2/core/utils.dart';
import 'package:healthy_medicine_2/widgets/app_bars/admin_entry_appbar.dart';
import 'package:healthy_medicine_2/widgets/common/error_text.dart';
import 'package:healthy_medicine_2/widgets/common/hours.dart';
import 'package:healthy_medicine_2/widgets/common/loader.dart';
import 'package:healthy_medicine_2/widgets/common/minutes.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

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
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;
  late DateTime date;
  late int selectedHour;
  late int selectedMinute;
  DateFormat myFormat = DateFormat('kk:mm');
  List<DateTime> times = [];
  List<DateTime> addTimes = [];
  List<DateTime> editTimes = [];
  TextEditingController dateController = TextEditingController();
  TextEditingController addedTimesTittleController = TextEditingController();
  TextEditingController editTimesTittleController = TextEditingController();
  int selectedAddedTimeIndex = -1;
  int selectedEdititngTimeIndex = -1;
  bool isDatePicked = false;
  bool isTimePicked = false;
  String selectedTimePresetId = '';
  String selectedTimePresetTitle = '';
  bool selectedTimePresetTypeIsStandart = false;
  bool isEdited = false;

  void createEntryCell(BuildContext context) {
    ref
        .read(doctorControllerProvider.notifier)
        .createEntryCells(context, widget.doctorId, date, times);
  }

  void convertSelectedHourIndex() {
    switch (_hourController.selectedItem) {
      case 0:
        selectedHour = 8;
        break;
      case 1:
        selectedHour = 9;
        break;
      case 2:
        selectedHour = 10;
        break;
      case 3:
        selectedHour = 11;
        break;
      case 4:
        selectedHour = 12;
        break;
      case 5:
        selectedHour = 13;
        break;
      case 6:
        selectedHour = 14;
        break;
      case 7:
        selectedHour = 15;
        break;
      case 8:
        selectedHour = 16;
        break;
      case 9:
        selectedHour = 17;
        break;
      case 10:
        selectedHour = 18;
        break;
      case 11:
        selectedHour = 19;
        break;
      default:
        selectedHour = 8;
        break;
    }
  }

  bool timesCheck(List<DateTime> times) {
    int k = 0;
    for (var i = 0; i < times.length; i++) {
      var v =
          DateTime(1970, 1, 1, selectedHour, _minuteController.selectedItem, 0)
                  .millisecondsSinceEpoch -
              DateTime(1970, 1, 1, times[i].hour, times[i].minute, 0)
                  .millisecondsSinceEpoch;
      if (v >= 1800000 || v <= -1800000) {
        k++;
      }
    }
    if (k == times.length) {
      return true;
    } else {
      return false;
    }
  }

  void createUserTimesPreset() {
    ref.read(entryControllerProvider.notifier).createUserTimesPreset(
        addTimes, addedTimesTittleController.text.trim(), context);
  }

  void editUserTimesPreset() {
    ref.read(entryControllerProvider.notifier).editUserTimesPreset(editTimes,
        editTimesTittleController.text.trim(), selectedTimePresetId, context);
  }

  void deleteUserTimesPreset(String userTimesId, String userTimesTitle) {
    ref
        .read(entryControllerProvider.notifier)
        .deleteUserTimesPreset(userTimesId, userTimesTitle, context);
  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _hourController = FixedExtentScrollController();
    _minuteController = FixedExtentScrollController();
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
                      selectedTimePresetId = '';
                      selectedTimePresetTitle = '';
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
              'Выберите расписание',
              textAlign: TextAlign.center,
              style: AppTheme.headerTextStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          topRight: Radius.circular(32),
                        ),
                      ),
                      isScrollControlled: true,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.8,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                            child: Scaffold(
                              backgroundColor: Colors.indigo.shade300,
                              body: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Создайте свое расписание',
                                        textAlign: TextAlign.center,
                                        style: AppTheme.titleTextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey.shade100,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                        controller: addedTimesTittleController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Название',
                                          hintStyle:
                                              AppTheme.dedicatedIndigoTextStyle,
                                        ),
                                        style:
                                            AppTheme.dedicatedIndigoTextStyle,
                                        cursorColor: Colors.indigo,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 150,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 70,
                                            child:
                                                ListWheelScrollView.useDelegate(
                                              controller: _hourController,
                                              itemExtent: 50,
                                              perspective: 0.005,
                                              diameterRatio: 1.2,
                                              physics:
                                                  const FixedExtentScrollPhysics(),
                                              childDelegate:
                                                  ListWheelChildBuilderDelegate(
                                                childCount: 12,
                                                builder: (context, index) {
                                                  return MyHours(
                                                    hours: index,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: 70,
                                            child:
                                                ListWheelScrollView.useDelegate(
                                              controller: _minuteController,
                                              itemExtent: 50,
                                              perspective: 0.005,
                                              diameterRatio: 1.2,
                                              physics:
                                                  const FixedExtentScrollPhysics(),
                                              childDelegate:
                                                  ListWheelChildBuilderDelegate(
                                                childCount: 60,
                                                builder: (context, index) {
                                                  return MyMinutes(
                                                    mins: index,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            convertSelectedHourIndex();
                                            bool check = timesCheck(addTimes);
                                            if (!addTimes.contains(
                                                  DateTime(
                                                      1970,
                                                      1,
                                                      1,
                                                      selectedHour,
                                                      _minuteController
                                                          .selectedItem,
                                                      0),
                                                ) &&
                                                addTimes.length < 8 &&
                                                check == true) {
                                              addTimes.add(
                                                DateTime(
                                                    1970,
                                                    1,
                                                    1,
                                                    selectedHour,
                                                    _minuteController
                                                        .selectedItem,
                                                    0),
                                              );
                                              addTimes.sort();
                                            }
                                          },
                                          child: const Icon(
                                            Icons.add_box_rounded,
                                            size: 42,
                                            color: Colors.white,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (selectedAddedTimeIndex != -1) {
                                              addTimes.removeAt(
                                                  selectedAddedTimeIndex);
                                              selectedAddedTimeIndex = -1;
                                            }
                                          },
                                          onLongPress: () => addTimes.isNotEmpty
                                              ? addTimes.clear()
                                              : null,
                                          child: Icon(
                                            Icons.delete_rounded,
                                            size: 42,
                                            color: Colors.red.shade300,
                                          ),
                                        ),
                                      ],
                                    ),
                                    addTimes.isNotEmpty
                                        ? SizedBox(
                                            height: 200,
                                            child: GridView.builder(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 5),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: addTimes.length,
                                              itemBuilder: ((context, index) {
                                                final addedTime =
                                                    addTimes[index];
                                                return InkWell(
                                                  onTap: () => setState(() {
                                                    selectedAddedTimeIndex =
                                                        index;
                                                  }),
                                                  child: Card(
                                                    color:
                                                        selectedAddedTimeIndex ==
                                                                index
                                                            ? Colors
                                                                .red.shade300
                                                            : Colors.white,
                                                    elevation: 24,
                                                    child: Center(
                                                      child: Text(
                                                        myFormat
                                                            .format(addedTime),
                                                        style: AppTheme
                                                            .dedicatedIndigoTextStyle,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              Image.asset(
                                                'assets/images/secondvariant.png',
                                                height: 150,
                                              ),
                                              Text(
                                                'Тут еще нет ячеек с временем...',
                                                textAlign: TextAlign.center,
                                                style: AppTheme
                                                    .dedicatedWhiteTextStyle,
                                              ),
                                            ],
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (addTimes.isNotEmpty &&
                                              addedTimesTittleController.text
                                                      .trim() !=
                                                  '') {
                                            createUserTimesPreset();
                                            addTimes.clear();
                                            addedTimesTittleController.text =
                                                '';
                                            selectedTimePresetId = '';
                                            selectedTimePresetTitle = '';
                                            selectedTimePresetTypeIsStandart =
                                                false;
                                            Routemaster.of(context).pop();
                                          } else {
                                            if (addTimes.isEmpty) {
                                              showSnackBar(context,
                                                  'Вы не добавили ни 1 ячейки...');
                                            }
                                            if (addedTimesTittleController.text
                                                    .trim() ==
                                                '') {
                                              showSnackBar(context,
                                                  'Вы не ввели название для расписания');
                                            }
                                            if (addedTimesTittleController.text
                                                        .trim() ==
                                                    '' &&
                                                addTimes.isEmpty) {
                                              showSnackBar(context,
                                                  'Вы не ввели название для расписания и не добавили ни 1 ячейки...');
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          minimumSize:
                                              const Size(double.infinity, 50),
                                          elevation: 16,
                                          backgroundColor: Colors.white,
                                        ),
                                        child: Text(
                                          'Создать',
                                          style:
                                              AppTheme.dedicatedIndigoTextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.add_box_rounded,
                    size: 42,
                  ),
                ),
                const Gap(15),
                InkWell(
                  onTap: () {
                    if (selectedTimePresetId != '' &&
                        selectedTimePresetTypeIsStandart == false) {
                      // final editingUserTimes = ref
                      //         .read(getUserTimesByIdProvider(
                      //             UserTimesParameters(
                      //                 uid: user.uid,
                      //                 userTimesId: selectedTimePresetId)))
                      //         .value ??
                      //     UserTimes(
                      //         isStandart: false,
                      //         times: times,
                      //         title: '',
                      //         id: '');
                      editTimes.clear();
                      editTimes = editTimes + times;
                      isEdited = false;
                      print(editTimes);
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                        isScrollControlled: true,
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.8,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32),
                              ),
                              child: Scaffold(
                                backgroundColor: Colors.indigo.shade300,
                                body: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Измените свое расписание',
                                          textAlign: TextAlign.center,
                                          style:
                                              AppTheme.titleTextStyle.copyWith(
                                            color: Colors.white,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.grey.shade100,
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        padding: const EdgeInsets.all(8),
                                        child: TextFormField(
                                          controller: editTimesTittleController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Название',
                                            hintStyle: AppTheme
                                                .dedicatedIndigoTextStyle,
                                          ),
                                          style:
                                              AppTheme.dedicatedIndigoTextStyle,
                                          onChanged: (value) {
                                            isEdited = true;
                                          },
                                          cursorColor: Colors.indigo,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 70,
                                              child: ListWheelScrollView
                                                  .useDelegate(
                                                controller: _hourController,
                                                itemExtent: 50,
                                                perspective: 0.005,
                                                diameterRatio: 1.2,
                                                physics:
                                                    const FixedExtentScrollPhysics(),
                                                childDelegate:
                                                    ListWheelChildBuilderDelegate(
                                                  childCount: 12,
                                                  builder: (context, index) {
                                                    return MyHours(
                                                      hours: index,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: 70,
                                              child: ListWheelScrollView
                                                  .useDelegate(
                                                controller: _minuteController,
                                                itemExtent: 50,
                                                perspective: 0.005,
                                                diameterRatio: 1.2,
                                                physics:
                                                    const FixedExtentScrollPhysics(),
                                                childDelegate:
                                                    ListWheelChildBuilderDelegate(
                                                  childCount: 60,
                                                  builder: (context, index) {
                                                    return MyMinutes(
                                                      mins: index,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              convertSelectedHourIndex();
                                              bool check =
                                                  timesCheck(editTimes);
                                              if (!editTimes.contains(
                                                    DateTime(
                                                        1970,
                                                        1,
                                                        1,
                                                        selectedHour,
                                                        _minuteController
                                                            .selectedItem,
                                                        0),
                                                  ) &&
                                                  editTimes.length < 8 &&
                                                  check == true) {
                                                editTimes.add(
                                                  DateTime(
                                                      1970,
                                                      1,
                                                      1,
                                                      selectedHour,
                                                      _minuteController
                                                          .selectedItem,
                                                      0),
                                                );
                                                editTimes.sort();
                                                isEdited = true;
                                              }
                                            },
                                            child: const Icon(
                                              Icons.add_box_rounded,
                                              size: 42,
                                              color: Colors.white,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (selectedEdititngTimeIndex !=
                                                  -1) {
                                                editTimes.removeAt(
                                                    selectedEdititngTimeIndex);
                                                selectedEdititngTimeIndex = -1;
                                                isEdited = true;
                                              }
                                            },
                                            onLongPress: editTimes.isNotEmpty
                                                ? () {
                                                    editTimes.clear();
                                                    isEdited = true;
                                                  }
                                                : null,
                                            child: Icon(
                                              Icons.delete_rounded,
                                              size: 42,
                                              color: Colors.red.shade300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      editTimes.isNotEmpty
                                          ? SizedBox(
                                              height: 200,
                                              child: GridView.builder(
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 5),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: editTimes.length,
                                                itemBuilder: ((context, index) {
                                                  final editingTime =
                                                      editTimes[index];
                                                  return InkWell(
                                                    onTap: () => setState(() {
                                                      selectedEdititngTimeIndex =
                                                          index;
                                                    }),
                                                    child: Card(
                                                      color:
                                                          selectedEdititngTimeIndex ==
                                                                  index
                                                              ? Colors
                                                                  .red.shade300
                                                              : Colors.white,
                                                      elevation: 24,
                                                      child: Center(
                                                        child: Text(
                                                          myFormat.format(
                                                              editingTime),
                                                          style: AppTheme
                                                              .dedicatedIndigoTextStyle,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            )
                                          : Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/secondvariant.png',
                                                  height: 150,
                                                ),
                                                Text(
                                                  'Тут еще нет ячеек с временем...',
                                                  textAlign: TextAlign.center,
                                                  style: AppTheme
                                                      .dedicatedWhiteTextStyle,
                                                ),
                                              ],
                                            ),
                                      isEdited
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (editTimes.isNotEmpty &&
                                                      editTimesTittleController
                                                              .text
                                                              .trim() !=
                                                          '') {
                                                    editUserTimesPreset();
                                                    editTimesTittleController
                                                        .text = '';
                                                    selectedTimePresetId = '';
                                                    selectedTimePresetTitle =
                                                        '';
                                                    selectedTimePresetTypeIsStandart =
                                                        false;
                                                    isEdited = false;
                                                    Routemaster.of(context)
                                                        .pop();
                                                  } else {
                                                    if (editTimes.isEmpty) {
                                                      showSnackBar(context,
                                                          'Вы не добавили ни 1 ячейки...');
                                                    }
                                                    if (editTimesTittleController
                                                            .text
                                                            .trim() ==
                                                        '') {
                                                      showSnackBar(context,
                                                          'Вы не ввели название для расписания');
                                                    }
                                                    if (editTimesTittleController
                                                                .text
                                                                .trim() ==
                                                            '' &&
                                                        editTimes.isEmpty) {
                                                      showSnackBar(context,
                                                          'Вы не ввели название для расписания и не добавили ни 1 ячейки...');
                                                    }
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  minimumSize: const Size(
                                                      double.infinity, 50),
                                                  elevation: 16,
                                                  backgroundColor: Colors.white,
                                                ),
                                                child: Text(
                                                  'Изменить',
                                                  style: AppTheme
                                                      .dedicatedIndigoTextStyle,
                                                ),
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      if (selectedTimePresetId == '') {
                        showSnackBar(
                            context, 'Вы не выбрали расписание для изменения');
                      }
                      if (selectedTimePresetTypeIsStandart == true) {
                        showSnackBar(context,
                            'Вы не можете изменить стандартное расписание');
                      }
                    }
                  },
                  child: const Icon(
                    Icons.edit_rounded,
                    size: 42,
                    color: Colors.indigo,
                  ),
                ),
                const Gap(15),
                InkWell(
                  onTap: () {
                    if (selectedTimePresetId != '' &&
                        selectedTimePresetTypeIsStandart == false) {
                      deleteUserTimesPreset(
                          selectedTimePresetId, selectedTimePresetTitle);
                      selectedTimePresetId = '';
                    } else {
                      if (selectedTimePresetId == '') {
                        showSnackBar(context,
                            'Вы не выбрали расписание, которое хотите удалить');
                      }
                      if (selectedTimePresetTypeIsStandart) {
                        showSnackBar(context,
                            'Вы не можете удалить стандартное расписание!');
                      }
                    }
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
                            backgroundColor:
                                selectedTimePresetId == userTimes.id
                                    ? Colors.red
                                    : Colors.indigo.shade100,
                            collapsedBackgroundColor:
                                selectedTimePresetId == userTimes.id
                                    ? Colors.red
                                    : Colors.grey.shade200,
                            title: Text(
                              userTimes.title,
                              style: selectedTimePresetId == userTimes.id
                                  ? AppTheme.dedicatedIndigoTextStyle.copyWith(
                                      color: Colors.red.shade300, fontSize: 32)
                                  : AppTheme.dedicatedIndigoTextStyle.copyWith(
                                      fontSize: 32,
                                    ),
                            ),
                            children: [
                              SizedBox(
                                height: 150,
                                child: GridView.builder(
                                  itemCount: userTimes.times.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 6),
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    final userSingleTime =
                                        userTimes.times[index];
                                    return Card(
                                      color:
                                          selectedTimePresetId == userTimes.id
                                              ? Colors.red.shade300
                                              : Colors.grey.shade200,
                                      child: Center(
                                        child: Text(
                                          myFormat.format(userSingleTime),
                                          style: AppTheme
                                              .dedicatedIndigoTextStyle
                                              .copyWith(
                                            color: selectedTimePresetId ==
                                                    userTimes.id
                                                ? Colors.white
                                                : null,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    selectedTimePresetId == userTimes.id
                                        ? setState(() {
                                            times = [];
                                            // editTimes = [];
                                            selectedTimePresetId = '';
                                            selectedTimePresetTypeIsStandart =
                                                false;
                                            isTimePicked = false;
                                          })
                                        : setState(() {
                                            times = userTimes.times.toList();
                                            // editTimes =
                                            //     userTimes.times.toList();
                                            selectedTimePresetId = userTimes.id;
                                            selectedTimePresetTitle =
                                                userTimes.title;
                                            selectedTimePresetTypeIsStandart =
                                                userTimes.isStandart;
                                            isTimePicked = true;
                                            editTimesTittleController =
                                                TextEditingController(
                                                    text: userTimes.title);
                                          });
                                    print(times);
                                    print(editTimes);
                                    print(selectedTimePresetId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize:
                                        const Size(double.infinity, 50),
                                    backgroundColor:
                                        selectedTimePresetId == userTimes.id
                                            ? Colors.red.shade300
                                            : null,
                                    elevation: 16,
                                  ),
                                  child: Text(
                                    selectedTimePresetId == userTimes.id
                                        ? 'Отмена'
                                        : 'Выбрать',
                                    style: AppTheme.dedicatedIndigoTextStyle
                                        .copyWith(
                                            color: selectedTimePresetId ==
                                                    userTimes.id
                                                ? Colors.white
                                                : null),
                                  ),
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
