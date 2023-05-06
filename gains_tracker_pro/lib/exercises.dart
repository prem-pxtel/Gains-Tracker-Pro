import 'package:flutter/material.dart';
import 'homepage.dart';
import 'alertdialogs.dart';
import 'classes.dart';
import 'mapfuncs.dart';
import 'numberpicker.dart';

class ExerciseScreen extends StatefulWidget {
  final int wkoutIndex;
  const ExerciseScreen({super.key, required this.wkoutIndex});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final textController = TextEditingController();
  addExCallback() {
    setState(() {
      // update exList with correct input eventually
      Exercise newEx = Exercise();
      if (textController.text != '') {
        newEx.exName = textController.text;
      } else {
        int exLenPlus1 = wkoutList[widget.wkoutIndex].exList.length + 1;
        newEx.exName = 'Exercise $exLenPlus1';
      }
      wkoutList[widget.wkoutIndex].exList.add(newEx);
      textController.clear();
      Navigator.pop(context);

      //updating heatmap
      wkoutMap.putIfAbsent(DateUtils.dateOnly(wkoutList[wkoutList.length - 1].dt), () => getVol(wkoutList[wkoutList.length - 1].exList));
    });
  }
  addSetCallback(Set newSet) {
    setState(() {            
      Exercise lastEx = wkoutList[widget.wkoutIndex].exList.last;
      lastEx.setList.add(newSet);
    }); 

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),),
        backgroundColor: Colors.black,
        title: const Text('Your Workout'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            showDialog(
              context: context,
              builder: (context) { // same as (context) => AddExerciseAlertD...
                return AddExerciseAlertDialog(textController: textController,wkoutIndex: widget.wkoutIndex, callback: addExCallback);
              }
            );
          });
        }
      ),
      body: Stack(
        children: [
          if (wkoutList[widget.wkoutIndex].exList.isEmpty) 
          const Center(child: Text('Add your first exercise by tapping +')),
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: wkoutList[widget.wkoutIndex].exList.length,
              itemBuilder: (_, exIndex) {
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
                      wkoutList[widget.wkoutIndex].exList.removeAt(exIndex);
                    });
                    // Then show a snackbar.
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exercise removed')));
                  },
                  child: ExpansionTile( 
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
                                visualDensity: const VisualDensity(vertical: -4),
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
                                leading:  CircleAvatar(
                                    radius: 6,
                                    backgroundColor: Colors.red.shade400,
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
                                onTap: () {
                                  // ...
                                }
                              ),
                            ),
                          );
                        }
                      ),
                    ]
                  ),
                );
              },
            ),
          ),
          NumberPickerScreen(wkoutIndex: widget.wkoutIndex, callback: addSetCallback),
        ]
      )
    );
  }
}