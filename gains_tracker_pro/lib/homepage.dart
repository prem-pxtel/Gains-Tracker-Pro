import 'package:flutter/material.dart';
import 'calendar.dart';
import 'other.dart';
import 'classes.dart';
import 'randfuncs.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Workout> wkoutList = [];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: const Text('GAINS TRACKER PRO'),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Workout newTestWkout = Workout();
            wkoutList.add(newTestWkout);
          });
        }
      ),
      body:<Widget>[
        Stack(
          children: [
            ListView.builder(
              itemCount: wkoutList.length,
              itemBuilder: (_, index) {
                return ListTile(
                  tileColor: randColor(),
                  title: Text(wkoutList[index].wkoutName),                
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 7, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Text(randEmoji()),
                  ),
                );
              },
            ),
          ]
        ),
        const CalendarPage(),
        const OtherPage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'Other',
          ),
        ],
      ),
    );
  }
}
