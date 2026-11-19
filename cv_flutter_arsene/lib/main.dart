import 'package:flutter/material.dart';
import 'data/cv_data.dart';
import 'page/login_page.dart';

void main() {
  runApp(const MonCvApp());
}

class MonCvApp extends StatelessWidget {
  const MonCvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV - ${CvData.fullName}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.pageBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryNavy,
          primary: AppColors.primaryNavy,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryNavy,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const LoginPage(),
    );
  }
} 