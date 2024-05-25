import 'package:flutter/material.dart';
import 'app_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
            useMaterial3: false,
            fontFamily: 'CourierPrime'),
        home: const AppScreen(),
        title: "Giveth Taketh",
      ),
    );
  }
}
