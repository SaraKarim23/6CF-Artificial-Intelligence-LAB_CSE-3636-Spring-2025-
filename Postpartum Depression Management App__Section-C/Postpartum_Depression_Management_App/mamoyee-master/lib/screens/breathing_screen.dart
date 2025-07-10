import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BreathingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Breathing"), backgroundColor: AppColors.primary),
      body: Center(child: Text("Guided Breathing Here")),
    );
  }
}