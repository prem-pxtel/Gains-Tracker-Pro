import 'package:flutter/material.dart';
import 'database.dart';
import 'exercises.dart';
import 'classes.dart';
import 'heatmap.dart';
import 'other.dart';
import 'mapfuncs.dart';
import 'package:hive_flutter/hive_flutter.dart';

WorkoutDatabase db = WorkoutDatabase();

Map<DateTime, int> wkoutMap = {};
int curWeight = 30;
int curReps = 8;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _myBox = Hive.box('theBox');
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    if (_myBox.get("WKOUTLIST") != null) db.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: 
          BorderRadius.only(bottomLeft: Radius.circular(40)),),
        backgroundColor: Colors.black,
        title: const Text('   GAINS TRACKER 💪'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Workout newWkout = Workout();
            db.wkoutList.add(newWkout);
            db.updateDatabase();
          });
        }
      ),
      body:<Widget>[
        Stack(
          children: [
            if (db.wkoutList.isEmpty) const Center(child: Text('No Gains ❌')),
            ListView.builder(
              itemCount: db.wkoutList.length,
              itemBuilder: (_, index) {
                int reverseIndex = db.wkoutList.length - 1 - index;
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(left:320), 
                      child: Icon(Icons.clear),
                    ),
                  ),
                  onDismissed: (direction) {
                    // Remove the item from the data source.
                    setState(() {
                      db.wkoutList.removeAt(reverseIndex);
                      updateMap();
                      db.updateDatabase();
                    });
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workout removed')));
                  },
                  child: ListTile(
                    tileColor: Color(db.wkoutList[reverseIndex].colorVal),
                    title: Text(db.wkoutList[reverseIndex].wkoutName),                
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 7,
                        color: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 46, 46, 46)
                          : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text(db.wkoutList[reverseIndex].emoji),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ExerciseScreen(
                            wkoutIndex: reverseIndex),
                        ),
                      );
                      // open separate Workout screen where you can then add Exercises and get prompted to enter Exercise info
                    }
                  )
                );
              },
            ),
          ]
        ),
        Container(
          color: const Color.fromARGB(100, 100, 100, 100),
          child: const Center(child: CalendarPage()),
        ),
        const OtherPage(),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(0, 1, 1, 1),
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: '',
          ),
        ],
      ),
    );
  }
}