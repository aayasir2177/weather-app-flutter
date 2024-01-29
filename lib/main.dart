import 'package:flutter/material.dart';
import 'package:weather_app/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        cardTheme: const CardTheme(),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}