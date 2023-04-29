import 'package:flutter/material.dart';
import 'homepage.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: const Text('Your Workout'),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {

          });
        }
      ),
      body: Stack(
        children: [
          if (HomePageState().wkoutList.isEmpty) const Center(child: Text('No gains ❌')),
          ListView.builder(
            itemCount: HomePageState().wkoutList.length,
            itemBuilder: (_, index) {
              int reverseIndex = HomePageState().wkoutList.length - 1 - index;
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
                    HomePageState().wkoutList.removeAt(reverseIndex);
                  });
                  // Then show a snackbar.
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workout removed')));
                },
                child: ListTile(
                  tileColor: HomePageState().wkoutList[reverseIndex].c,
                  title: Text(HomePageState().wkoutList[reverseIndex].wkoutName),                
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
                    child: Text(HomePageState().wkoutList[reverseIndex].emoji),
                  ),
                  onTap: () {
                    // open separate Workout screen where you can then add Exercises and get prompted to enter Exercise info
                  }
                ),
              );
            },
          ),
        ]
      )
    );
  }
}