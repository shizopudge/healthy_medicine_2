import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/screens/history_screen.dart';
import 'package:healthy_medicine_2/screens/main_screen.dart';

class Portal extends ConsumerStatefulWidget {
  const Portal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortalState();
}

class _PortalState extends ConsumerState<Portal> {
  int _page = 0;

  static const tabWidgets = [
    MainScreen(),
    HistoryScreen(),
  ];
  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabWidgets[_page],
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 8,
          left: 5,
          right: 5,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(28),
            ),
            padding: const EdgeInsets.all(4),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house_alt),
                    activeIcon: Icon(CupertinoIcons.house_alt_fill),
                    label: 'Главная',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    activeIcon: Icon(Icons.history),
                    label: 'История',
                  ),
                ],
                onTap: onPageChanged,
                currentIndex: _page,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
