import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/drawers/profile_drawer.dart';
import 'package:healthy_medicine_2/widgets/app_bars/main_appbar.dart';
import 'package:healthy_medicine_2/widgets/lists/entries.dart';

enum HistoryMenu { all, past, upcoming, comingInTime }

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  int k = 10;
  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  bool isUpcoming = false;
  bool isPast = false;
  bool isComingInTime = false;
  bool isNothing = true;
  String sortType = 'Все';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const ProfileDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              k > 10
                  ? const SizedBox()
                  : Builder(builder: (context) {
                      return MainAppBar(
                        onSearchTap: () {},
                        onAvatarTap: () => displayEndDrawer(context),
                        title: 'Ваша история приемов',
                      );
                    }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  k > 10
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              k = 10;
                            });
                          },
                          child: Text(
                            'Скрыть',
                            style: AppTheme.titleTextStyle,
                          ),
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              k = 50;
                            });
                          },
                          child: Text(
                            'Показать все',
                            style: AppTheme.titleTextStyle,
                          ),
                        ),
                  Row(
                    children: [
                      Text(
                        sortType,
                        style: AppTheme.labelTextStyle,
                      ),
                      PopupMenuButton<HistoryMenu>(
                          onSelected: (HistoryMenu item) {
                            if (item == HistoryMenu.all) {
                              setState(() {
                                isNothing = true;
                                isComingInTime = false;
                                isUpcoming = false;
                                isPast = false;
                                sortType = 'Все';
                              });
                            }
                            if (item == HistoryMenu.comingInTime) {
                              setState(() {
                                isComingInTime = true;
                                isUpcoming = false;
                                isPast = false;
                                isNothing = false;
                                sortType = 'Ближайшие';
                              });
                            }
                            if (item == HistoryMenu.upcoming) {
                              setState(() {
                                isUpcoming = true;
                                isComingInTime = false;
                                isPast = false;
                                isNothing = false;
                                sortType = 'Предстоящие';
                              });
                            }
                            if (item == HistoryMenu.past) {
                              setState(() {
                                isPast = true;
                                isUpcoming = false;
                                isComingInTime = false;
                                isNothing = false;
                                sortType = 'Прошедшие';
                              });
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<HistoryMenu>>[
                                PopupMenuItem<HistoryMenu>(
                                  value: HistoryMenu.all,
                                  child: Text(
                                    'Все',
                                    style: AppTheme.labelTextStyle,
                                  ),
                                ),
                                PopupMenuItem<HistoryMenu>(
                                  value: HistoryMenu.comingInTime,
                                  child: Text(
                                    'Ближайшие',
                                    style: AppTheme.labelTextStyle,
                                  ),
                                ),
                                PopupMenuItem<HistoryMenu>(
                                  value: HistoryMenu.upcoming,
                                  child: Text(
                                    'Предстоящие',
                                    style: AppTheme.labelTextStyle,
                                  ),
                                ),
                                PopupMenuItem<HistoryMenu>(
                                  value: HistoryMenu.past,
                                  child: Text(
                                    'Прошедшие',
                                    style: AppTheme.labelTextStyle,
                                  ),
                                ),
                              ]),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ListOfEntries(
                  limit: k,
                  isComingInTime: isComingInTime,
                  isPast: isPast,
                  isUpcoming: isUpcoming,
                  isNothing: isNothing,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
