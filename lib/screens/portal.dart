import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/core/constants.dart';
import 'package:healthy_medicine_2/screens/history_screen.dart';
import 'package:healthy_medicine_2/screens/home_screen.dart';

class Portal extends ConsumerStatefulWidget {
  const Portal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PortalState();
}

class _PortalState extends ConsumerState<Portal> {
  int _page = 0;

  static const tabWidgets = [
    HomeScreen(),
    // SpecScreen(),
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        selectedItemColor: Constants.textColor,
        unselectedItemColor: Colors.white,
        backgroundColor: Constants.bg,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.add),
          //   label: 'Entry',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        onTap: onPageChanged,
        currentIndex: _page,
      ),
    );
  }
}
