import 'package:flutter/material.dart';
import 'package:mamoyee/screens/appoinments_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/meditation_screen.dart';
import 'screens/breathing_screen.dart';
import 'screens/diary_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/diet_screen.dart';
import 'screens/appoinments_screen.dart';


Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => OnboardingScreen(),
  '/home': (context) => HomeScreen(),
  '/meditation': (context) => MeditationScreen(),
  '/breathing': (context) => BreathingScreen(),
  '/diary': (context) => DiaryScreen(),
  '/profile': (context) => ProfileScreen(),
  '/settings': (context) => SettingsScreen(),
  '/notifications': (context) => NotificationScreen(),
  '/diet': (context) => DietScreen(),
  '/appoinments': (context) => AppointmentsScreen(), // Add Diet route here
};
