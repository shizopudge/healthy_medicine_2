import 'package:flutter/material.dart';
import 'package:healthy_medicine_2/screens/clinic_screen.dart';
import 'package:healthy_medicine_2/screens/doctors_screen.dart';
import 'package:healthy_medicine_2/screens/login_screen.dart';
import 'package:healthy_medicine_2/screens/portal.dart';
import 'package:healthy_medicine_2/screens/profile_screen.dart';
import 'package:healthy_medicine_2/screens/spec_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: Portal()),
  '/spec': (_) => const MaterialPage(
        child: SpecScreen(),
      ),
  '/profile/:uid': (routeData) => MaterialPage(
        child: ProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/clinics/:spec': (routeData) => MaterialPage(
        child: ClinicScreen(
          spec: routeData.pathParameters['spec']!,
        ),
      ),
  '/doctors/:clinicId/:spec': (routeData) => MaterialPage(
        child: DoctorsScreen(
          clinic: routeData.pathParameters['clinicId']!,
          spec: routeData.pathParameters['spec']!,
        ),
      ),
});
