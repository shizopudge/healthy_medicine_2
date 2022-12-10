import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/app_theme.dart';
import 'package:healthy_medicine_2/drawers/profile_drawer.dart';
import 'package:healthy_medicine_2/widgets/app_bars/main_appbar.dart';
import 'package:healthy_medicine_2/widgets/lists/entries.dart';

final descendingTypeProvider = StateProvider<bool>((ref) => false);

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
  bool isComingInTime = true;
  bool isNothing = false;
  String sortType = 'Ближайшие';

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
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: Row(
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
                                k = 150;
                              });
                            },
                            child: Text(
                              'Показать все',
                              style: AppTheme.titleTextStyle,
                            ),
                          ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: AppTheme.indigoColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Text(
                                sortType,
                                style: AppTheme.labelTextStyle
                                    .copyWith(color: AppTheme.indigoColor),
                              ),
                            ),
                            PopupMenuButton<HistoryMenu>(
                                iconSize: 32,
                                elevation: 0,
                                onSelected: (HistoryMenu item) {
                                  if (item == HistoryMenu.all) {
                                    setState(() {
                                      isNothing = true;
                                      isComingInTime = false;
                                      isUpcoming = false;
                                      isPast = false;
                                      sortType = 'Все';
                                      ref
                                          .read(descendingTypeProvider.notifier)
                                          .state = false;
                                    });
                                  }
                                  if (item == HistoryMenu.comingInTime) {
                                    setState(() {
                                      isComingInTime = true;
                                      isUpcoming = false;
                                      isPast = false;
                                      isNothing = false;
                                      sortType = 'Ближайшие';
                                      ref
                                          .read(descendingTypeProvider.notifier)
                                          .state = false;
                                    });
                                  }
                                  if (item == HistoryMenu.upcoming) {
                                    setState(() {
                                      isUpcoming = true;
                                      isComingInTime = false;
                                      isPast = false;
                                      isNothing = false;
                                      sortType = 'Предстоящие';
                                      ref
                                          .read(descendingTypeProvider.notifier)
                                          .state = false;
                                    });
                                  }
                                  if (item == HistoryMenu.past) {
                                    setState(() {
                                      isPast = true;
                                      isUpcoming = false;
                                      isComingInTime = false;
                                      isNothing = false;
                                      sortType = 'Прошедшие';
                                      ref
                                          .read(descendingTypeProvider.notifier)
                                          .state = true;
                                    });
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<HistoryMenu>>[
                                      PopupMenuItem<HistoryMenu>(
                                        value: HistoryMenu.all,
                                        child: Text(
                                          'Все',
                                          style: AppTheme
                                              .dedicatedWhiteTextStyle
                                              .copyWith(
                                                  color: AppTheme.indigoColor),
                                        ),
                                      ),
                                      PopupMenuItem<HistoryMenu>(
                                        value: HistoryMenu.comingInTime,
                                        child: Text(
                                          'Ближайшие',
                                          style: AppTheme
                                              .dedicatedWhiteTextStyle
                                              .copyWith(
                                                  color: AppTheme.indigoColor),
                                        ),
                                      ),
                                      PopupMenuItem<HistoryMenu>(
                                        value: HistoryMenu.upcoming,
                                        child: Text(
                                          'Предстоящие',
                                          style: AppTheme
                                              .dedicatedWhiteTextStyle
                                              .copyWith(
                                                  color: AppTheme.indigoColor),
                                        ),
                                      ),
                                      PopupMenuItem<HistoryMenu>(
                                        value: HistoryMenu.past,
                                        child: Text(
                                          'Прошедшие',
                                          style: AppTheme
                                              .dedicatedWhiteTextStyle
                                              .copyWith(
                                                  color: AppTheme.indigoColor),
                                        ),
                                      ),
                                    ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        'Сортировка',
                        style: AppTheme.dedicatedWhiteTextStyle.copyWith(
                          color: AppTheme.indigoColor,
                          fontSize: 14,
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: ref.read(descendingTypeProvider) ? 3 : 1,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              ref.read(descendingTypeProvider.notifier).state =
                                  !ref
                                      .read(descendingTypeProvider.notifier)
                                      .state;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
