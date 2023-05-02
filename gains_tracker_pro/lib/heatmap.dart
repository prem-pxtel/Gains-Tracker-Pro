import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'homepage.dart';


class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}


class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {

    var thevalue = 0;

    wkoutMap.forEach((k,v){
      if(v>thevalue){
        thevalue = v;
      }
    });

    Map<DateTime, int> wkoutMap10 =
    {for(var i = 1; i <= wkoutMap.length;i++) wkoutMap.keys.elementAt(i-1) : (wkoutMap.values.elementAt(i-1)/thevalue).round()*10};

    return HeatMap(
  datasets: wkoutMap10,
  size: 30,
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 30)),
  colorMode: ColorMode.opacity,
  showText: false,
  scrollable: true,
  colorsets: const {
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