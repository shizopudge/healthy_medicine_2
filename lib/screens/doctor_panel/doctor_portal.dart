import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/screens/doctor_panel/doctors_history_screen.dart';
import 'package:healthy_medicine_2/screens/doctor_panel/doctors_doctor_screen.dart';

class DoctorPortal extends ConsumerStatefulWidget {
  const DoctorPortal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DoctorPortalState();
}

class _DoctorPortalState extends ConsumerState<DoctorPortal> {
  int _page = 0;

  static const tabWidgets = [
    DoctorsDoctorScreen(),
    DoctorsHistoryScreen(),
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
        elevation: 0,
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
    );
  }
}
