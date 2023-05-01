import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'homepage.dart';


//change it later
//int volume(int a){
//  var volumesum = 0;
//  for (int i= 1; i<= wkoutList[a].exList.length; i++){
//    volumesum += wkoutList[a].exList[i].setList.length; 
//  }
//  return volumesum;
//}

int volume(int a){
  return wkoutList[a].exList.length;
}

var volumedatepair = {
  for (int i = 0; i<wkoutList.length;i++) wkoutList[i].dt : volume(i)
};

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return HeatMap(
  datasets: volumedatepair,
  colorMode: ColorMode.opacity,
  showText: false,
  scrollable: true,
  colorsets: const {
    1: Color.fromARGB(225, 76, 175, 79),
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