import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:gains_tracker_pro/randfuncs.dart';
import 'homepage.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  List prKeylist = [];
  Widget build(BuildContext context) {
    var themaxValue = 0;
    db.wkoutMap.forEach(
      (k,v) { 
        if (v > themaxValue) themaxValue = v;
      }
    );
    Map<DateTime, int> heatmapData = {
      for (var i = 0; i < db.wkoutMap.length; ++i) 
      db.wkoutMap.keys.elementAt(i)
      : (db.wkoutMap.values.elementAt(i) / themaxValue).round() * 10
    };

    return Column(
      children: [ HeatMap(
      datasets: heatmapData,
      size: 30,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 30)),
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
    ),
    SizedBox(height: 300, child: 
    ListView.builder(
      itemCount: db.prMap.length,
      itemBuilder: (context, index) {
        db.prMap.forEach((key, value) {
          prKeylist.insert(-1, key);
        });

        for (int i = 1; i <= prKeylist.length;){

          return ListTile(          
            tileColor: randColor(),
              title: Text('$prKeylist[i]: yes'),                
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 7,
                  color: Theme.of(context).brightness == Brightness.dark
                    ? const Color.fromARGB(255, 46, 46, 46)
                    : Colors.white,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              leading: const CircleAvatar(
                backgroundColor: Colors.black,
                child: Text('S'),
              ),
            );
        }
        
      },
    )
    ),

    ],);
    
    
  }
}