import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/screens/add_review_screen.dart';
import 'package:healthy_medicine_2/screens/admin_entry_panel.dart';
import 'package:healthy_medicine_2/screens/admin_panel_screen.dart';
import 'package:healthy_medicine_2/screens/clinic_screen.dart';
import 'package:healthy_medicine_2/screens/doctor_screen.dart';
import 'package:healthy_medicine_2/screens/doctors_list_screen.dart';
import 'package:healthy_medicine_2/screens/edit_review_screen.dart';
import 'package:healthy_medicine_2/screens/entry_screen.dart';
import 'package:healthy_medicine_2/screens/login_screen.dart';
import 'package:healthy_medicine_2/screens/portal.dart';
import 'package:healthy_medicine_2/screens/profile_screen.dart';
import 'package:healthy_medicine_2/screens/reviews_screen.dart';
import 'package:healthy_medicine_2/screens/main_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: Portal()),
  '/spec': (_) => const MaterialPage(
        child: MainScreen(),
      ),
  '/admin': (_) => const MaterialPage(
        child: AdminPanelScreen(),
      ),
  '/profile/:uid': (routeData) => MaterialPage(
        child: ProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/doctor/:doctorId': (routeDocThings) => MaterialPage(
        child: DoctorScreen(
          doctorId: routeDocThings.pathParameters['doctorId']!,
        ),
      ),
  '/add-review/:doctorId': (routeDocThings) => MaterialPage(
        child: AddReviewScreen(
          doctorId: routeDocThings.pathParameters['doctorId']!,
        ),
      ),
  '/reviews/:doctorId': (routeDocThings) => MaterialPage(
        child: ReviewsScreen(
          doctorId: routeDocThings.pathParameters['doctorId']!,
        ),
      ),
  '/edit-review/:doctorId': (routeDocThings) => MaterialPage(
        child: EditReviewScreen(
          doctorId: routeDocThings.pathParameters['doctorId']!,
        ),
      ),
  '/clinics/:spec': (routeData) => MaterialPage(
        child: ClinicScreen(
          spec: routeData.pathParameters['spec']!,
        ),
      ),
  '/entry/:doctorId': (routeDocThings) => MaterialPage(
        child: EntryScreen(
          doctorId: routeDocThings.pathParameters['doctorId']!,
        ),
      ),
  '/doctors/:clinicId/:spec': (routeData) => MaterialPage(
        child: DoctorsListScreen(
          clinic: routeData.pathParameters['clinicId']!,
          spec: routeData.pathParameters['spec']!,
        ),
      ),
  '/admin-entry-panel/:doctorId': (routeDocThings) => MaterialPage(
        child: AdminEntryPanel(
          doctorId: routeDocThings.pathParameters['doctorId']!,
        ),
      ),
});
