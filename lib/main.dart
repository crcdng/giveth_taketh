import 'package:flutter/material.dart';
import 'app_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: MaterialApp(
        home: AppScreen(),
        title: "Giveth Taketh",
      ),
    );
  }
}
