import 'package:flutter/material.dart';
import 'package:gains_tracker_pro/mapfuncs.dart';
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
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.black,
        title: const Text('Your Workout'),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('New Exercise'),
                content: const Text('Please enter your shits now.'),
                actions: [
                  TextButton(
                    onPressed: () { Navigator.pop(context); }, 
                    child: const Text('Cancel')
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        // update exList with correct input eventually
                        Exercise newEx = Exercise();
                        Set testSet = Set();
                        testSet.repCount = 10;
                        newEx.setList.add(testSet);
                        wkoutList[widget.wkoutIndex].exList.add(newEx);
                        Navigator.pop(context);

                        //updating heatmap
                        wkoutMap.putIfAbsent(wkoutList[wkoutList.length-1].dt, () => getVol(wkoutList[wkoutList.length -1].exList));
                      });
                    }, 
                    child: const Text('Save')
                  ),
                ],
              ),
            );
          });
        }
      ),
      body: Stack(
        children: [
          if (wkoutList[widget.wkoutIndex].exList.isEmpty) 
          const Center(child: Text('Add your first exercise, by tapping +')),
          ListView.builder(
            itemCount: wkoutList[widget.wkoutIndex].exList.length,
            itemBuilder: (_, exIndex) {
              int exIndexPlus1 = exIndex + 1;
              return ExpansionTile( 
                title: Text('Exercise $exIndexPlus1'),
                children: <Widget> [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: wkoutList[widget.wkoutIndex].exList[exIndex].setList.length,
                    itemBuilder: (_, setIndex) {
                      int setIndexPlus1 = setIndex + 1;
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
                            wkoutList[widget.wkoutIndex].exList[exIndex].setList.removeAt(setIndex);
                          });
                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Set removed')));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          child: ListTile(
                            tileColor: Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(255, 46, 46, 46)
                              : Colors.white,
                            title: Text('Set $setIndexPlus1'),                
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
                              // open separate Workout screen where you can then    add Exercises and get prompted to enter Exercise info
                            }
                          ),
                        ),
                      );
                    }
                  ),
                ]
              );
            },
          ),
        ]
      )
    );
  }
}