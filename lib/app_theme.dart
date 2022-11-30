import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class AppTheme {
  // Colors
  static const blackColor = Color.fromRGBO(1, 1, 1, 1); // primary color
  static const indigoColor = Colors.indigo; // secondary color
  static const widgetsBgColor = Color.fromARGB(255, 120, 122, 122);
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static const whiteColor70 = Colors.white70;
  static const primaryTextColor = Color.fromARGB(255, 49, 51, 65);
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;
  static var gradientIndigoToRed =
      LinearGradient(colors: [Colors.indigo.shade200, Colors.red.shade200]);

  static TextStyle headerTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: indigoColor,
  );
  static TextStyle titleTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: blackColor,
  );
  static TextStyle whiteTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 18,
    color: whiteColor,
  );
  static TextStyle dedicatedWhiteTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: whiteColor,
  );
  static TextStyle dedicatedTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: primaryTextColor,
  );
  static TextStyle labelTextStyle = GoogleFonts.montserrat(
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: blackColor,
  );

  // Themes
  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,

    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    backgroundColor:
        drawerColor, // will be used as alternative background color
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: indigoColor,
      circularTrackColor: whiteColor70,
    ),
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
        size: 32,
      ),
    ),
    iconTheme: const IconThemeData(color: indigoColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: indigoColor,
      backgroundColor: Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          50,
        ),
      ),
    )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      selectedItemColor: indigoColor,
      unselectedItemColor: indigoColor,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedLabelStyle: labelTextStyle,
      unselectedIconTheme: const IconThemeData(size: 32),
      selectedIconTheme: const IconThemeData(size: 36),
      type: BottomNavigationBarType.fixed,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    backgroundColor: whiteColor70,
  );
}

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeMode _mode;
  ThemeNotifier({ThemeMode mode = ThemeMode.dark})
      : _mode = mode,
        super(AppTheme.darkModeAppTheme) {
    getTheme();
  }

  ThemeMode get mode => _mode;

  void getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'light') {
      _mode = ThemeMode.light;
      state = AppTheme.lightModeAppTheme;
    } else {
      _mode = ThemeMode.dark;
      state = AppTheme.darkModeAppTheme;
    }
  }

  void toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = AppTheme.lightModeAppTheme;
      prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = AppTheme.darkModeAppTheme;
      prefs.setString('theme', 'dark');
    }
  }
}
