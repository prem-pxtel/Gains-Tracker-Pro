import 'package:flutter/material.dart';
import 'homepage.dart';
import 'alertdialogs.dart';
import 'classes.dart';
import 'mapfuncs.dart';

class ExerciseScreen extends StatefulWidget {
  final int wkoutIndex;
  const ExerciseScreen({super.key, required this.wkoutIndex});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final textController = TextEditingController();
  callback() {
    setState(() {
      // update exList with correct input eventually
      Exercise newEx = Exercise();
      Set testSet = Set();
      testSet.repCount = 10;
      testSet.weight = 50;
      newEx.setList.add(testSet);
      newEx.exName = textController.text;
      wkoutList[widget.wkoutIndex].exList.add(newEx);
      textController.clear();
      Navigator.pop(context);

      //updating heatmap
      wkoutMap.putIfAbsent(DateUtils.dateOnly(wkoutList[wkoutList.length - 1].dt), () => getVol(wkoutList[wkoutList.length - 1].exList));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Your Workout'),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (context) { // same as (context) => AddExerciseAlertD...
                return AddExerciseAlertDialog(textController: textController,wkoutIndex: widget.wkoutIndex, callback: callback);
              }
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
              return ExpansionTile( 
                title: Text(wkoutList[widget.wkoutIndex].exList[exIndex].exName),
                children: <Widget> [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: wkoutList[widget.wkoutIndex].exList[exIndex].setList.length,
                    itemBuilder: (_, setIndex) {
                      int setIndexPlus1 = setIndex + 1;
                      int reps = wkoutList[widget.wkoutIndex].exList[exIndex].setList[setIndex].repCount;
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
                            trailing: CircleAvatar(
                              backgroundColor: const Color.fromARGB(100, 46, 46, 46),
                              radius: 18,
                              child: IconButton(
                                icon: Text('$reps'), 
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (context) => const UpdateRepsAlertDialog(),
                                    );
                                  });
                                }
                              ),
                            ),
                            /*Row(
                              children: <Widget> [ 
                                (reps != 0) 
                                ? IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () => setState(() => reps--),
                                ) : Container(),
                                  Text(reps.toString()),
                                  IconButton(icon: const Icon(Icons.add),onPressed: () => setState(() => reps++))
                              ],
                            ),
                            */
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