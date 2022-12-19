import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthy_medicine_2/screens/admin_panel/add_doctors_screen.dart';
import 'package:healthy_medicine_2/screens/admin_panel/doctors_admin_panel_screen.dart';
import 'package:healthy_medicine_2/screens/admin_panel/users_panel.dart';

class AdminPortal extends ConsumerStatefulWidget {
  const AdminPortal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AdminPortalState();
}

class _AdminPortalState extends ConsumerState<AdminPortal> {
  int _page = 0;

  static const tabWidgets = [
    DoctorsAdminPanel(),
    AddDoctorScreen(),
    UsersPanel(),
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
            icon: Icon(
              Icons.add_circle,
            ),
            activeIcon: Icon(
              Icons.add_circle,
            ),
            label: 'Добавить врача',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: 'Пользователи',
          ),
        ],
        onTap: onPageChanged,
        currentIndex: _page,
      ),
    );
  }
}
