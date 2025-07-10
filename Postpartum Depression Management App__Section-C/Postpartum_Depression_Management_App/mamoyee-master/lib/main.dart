import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/app_colors.dart';

void main() {
  runApp(const MamoyeeApp());
}

class MamoyeeApp extends StatelessWidget {
  const MamoyeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mamoyee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
