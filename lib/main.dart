import 'package:flutter/material.dart';
import 'package:empowerher/constants/colors.dart';
import 'package:empowerher/screens/splash_screen.dart';

void main() {
  runApp(EmpowerHERApp());
}

class EmpowerHERApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EmpowerHER',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.burgundy,
        scaffoldBackgroundColor: AppColors.white,
        colorScheme: ColorScheme.light(
          primary: AppColors.burgundy,
          secondary: AppColors.coral,
          surface: AppColors.white,
          background: AppColors.lightGrey,
          onPrimary: AppColors.white,
          onSecondary: AppColors.white,
          onSurface: AppColors.black,
          onBackground: AppColors.black,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
          displayMedium: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: AppColors.burgundy,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.black,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.burgundy,
            foregroundColor: AppColors.white,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColors.coral, width: 2),
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
      home: SplashScreen(),
    );
  }
}