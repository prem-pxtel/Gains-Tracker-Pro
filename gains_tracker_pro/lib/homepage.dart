import 'package:flutter/material.dart';
import 'package:gains_tracker_pro/exercises.dart';
import 'classes.dart';
import 'heatmap.dart';
import 'other.dart';

List<Workout> wkoutList = [];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: const Text('GAINS TRACKER PRO 💪'),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Workout newWkout = Workout();
            wkoutList.add(newWkout);
          });
        }
      ),
      body:<Widget>[
        Stack(
          children: [
            if (wkoutList.isEmpty) const Center(child: Text('No Gains ❌')),
            ListView.builder(
              itemCount: wkoutList.length,
              itemBuilder: (_, index) {
                int reverseIndex = wkoutList.length - 1 - index;
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
                      wkoutList.removeAt(reverseIndex);
                    });
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workout removed')));
                  },
                  child: ListTile(
                    tileColor: wkoutList[reverseIndex].c,
                    title: Text(wkoutList[reverseIndex].wkoutName),                
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
                      child: Text(wkoutList[reverseIndex].emoji),
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