import 'package:flutter/material.dart';
import 'homepage.dart';
import 'classes.dart';

class ExerciseScreen extends StatefulWidget {
  final int wkoutIndex;
  const ExerciseScreen({super.key, required this.wkoutIndex});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    int testCount = 0;
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: const Text('Your Workout'),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {
            Exercise newEx = Exercise();
            wkoutList[widget.wkoutIndex].exList.add(newEx);
          });
        }
      ),
      body: Stack(
        children: [
          if (wkoutList[widget.wkoutIndex].exList.isEmpty) const Center(child: Text('Add your first exercise, by tapping +')),
          ListView.builder(
            itemCount: wkoutList[widget.wkoutIndex].exList.length,
            itemBuilder: (_, index) {
              int reverseIndex = wkoutList[widget.wkoutIndex].exList.length - 1 - index;
              return ExpansionTile(
                title: Text('Exercise $index'),
                children: <Widget> [ 
                  Dismissible(
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
                        wkoutList[widget.wkoutIndex].exList.removeAt(reverseIndex);
                      });
                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Workout removed')));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      child: ListTile(
                        tileColor: Theme.of(context).brightness == Brightness.dark
                          ? const Color.fromARGB(255, 46, 46, 46)
                          : Colors.white,
                        title: Text(wkoutList[widget.wkoutIndex].exList[reverseIndex].exName),                
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 7,
                            color: Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(255, 46, 46, 46)
                              : Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        leading: Transform.translate(
                          offset: const Offset(0, 5),
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.red.shade400,
                          ),
                        ),
                        onTap: () {
                          // open separate Workout screen where you can then add Exercises and get prompted to enter Exercise info
                        }
                      ),
                    ),
                  )
                ]
              );
            },
          ),
        ]
      )
    );
  }
}