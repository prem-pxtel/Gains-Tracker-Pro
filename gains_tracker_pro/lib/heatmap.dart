import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
  datasets: {
    DateTime(2021, 1, 6): 3,
    DateTime(2021, 1, 7): 7,
    DateTime(2021, 1, 8): 10,
    DateTime(2021, 1, 9): 13,
    DateTime(2021, 1, 13): 6,
  },
  colorMode: ColorMode.opacity,
  showText: false,
  scrollable: true,
  colorsets: {
    1: Color.fromARGB(25, 76, 175, 79),
    2: Color.fromARGB(50, 76, 175, 79),
    3: Color.fromARGB(76, 76, 175, 79),
    4: Color.fromARGB(101, 76, 175, 79),
    5: Color.fromARGB(127, 76, 175, 79),
    6: Color.fromARGB(152, 76, 175, 79),
    7: Color.fromARGB(178, 76, 175, 79),
    8: Color.fromARGB(203, 76, 175, 79),
    9: Color.fromARGB(229, 76, 175, 79),
    10: Colors.green,

  },
  onClick: (value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.toString())));
  },
);
  }
}