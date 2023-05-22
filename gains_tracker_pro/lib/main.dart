import 'package:flutter/material.dart';
import 'package:gains_tracker_pro/classes.dart';
import 'homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // initialize Hive, register adapters, and open a box
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(SetAdapter());
  Hive.registerAdapter(PRAdapter());
  await Hive.openBox('theBox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gains Tracker',
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
    );
  }
}
