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
  final tc1 = TextEditingController();
  final tc2 = TextEditingController();

 // Following callback functions called from Add/Update AlertDialogs

  addExCallback() {
    setState(() {
      // update exList with correct input eventually
      Exercise newEx = Exercise();
      if (tc1.text != '') {
        newEx.exName = tc1.text;
      } else {
        int exLenPlus1 = wkoutList[widget.wkoutIndex].exList.length + 1;
        newEx.exName = 'Exercise $exLenPlus1';
      }
      newEx.notes = tc2.text;
      wkoutList[widget.wkoutIndex].exList.add(newEx);
      Navigator.pop(context);
      tc1.clear();
    });
  }
  
  addSetCallback(Set newSet) {
    setState(() {            
      Exercise lastEx = wkoutList[widget.wkoutIndex].exList.last;
      lastEx.setList.add(newSet);
      updateMap();
    });
  } 

  updateSetCallback(int exIndex, int setIndex, int reps, int weight) {
    setState(() {    
      Set s = wkoutList[widget.wkoutIndex].exList[exIndex].setList[setIndex];
      s.repCount = reps;
      s.weight = weight;
      updateMap();
    });
  } 

  updateNoteCallback(String newNote, int exIndex) {
    setState(() {
    wkoutList[widget.wkoutIndex].exList[exIndex].notes = newNote;
    });
  }

  setStateCallback() {
    setState(() {}); 
  }

  @override
  Widget build(BuildContext context) {
    List<Exercise> e = wkoutList[widget.wkoutIndex].exList;
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
                return AddExerciseAlertDialog(textController: tc1, textController2: tc2 ,wkoutIndex: widget.wkoutIndex, callback: addExCallback);
              }
            );
          });
        }
      ),
      body: Stack(
        children: [
          if (e.isEmpty) const Center(
            child: Text('Add your first exercise by tapping +')
          ),
          SizedBox(
            height: 570,
            // Dynamically display exercise list
            child: ListView.builder(
              itemCount: wkoutList[widget.wkoutIndex].exList.length,
              itemBuilder: (_, exIndex) {
                String notes = wkoutList[widget.wkoutIndex].exList[exIndex].notes;
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
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      key: ValueKey('$exIndex'),
                      title: Text(wkoutList[widget.wkoutIndex].exList[exIndex].exName),
                      children: <Widget> [
                        // Dynamically display set list
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: wkoutList[widget.wkoutIndex].exList[exIndex].setList.length,
                          itemBuilder: (_, setIndex) {
                            int setIndexPlus1 = setIndex + 1;
                            int reps = wkoutList[widget.wkoutIndex].exList[exIndex].setList[setIndex].repCount;
                            int weight = wkoutList[widget.wkoutIndex].exList[exIndex].setList[setIndex].weight;

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
                                  title: Text('Set $setIndexPlus1: [$reps, $weight]'),                
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
                                      radius: 6,
                                      backgroundColor: Colors.red.shade400,
                                    ),
                                  trailing: CircleAvatar(
                                    backgroundColor: const Color.fromARGB(100, 46, 46, 46),
                                    radius: 18,
                                    child: IconButton(
                                      icon: const Icon(Icons.edit_note), 
                                      onPressed: () {
                                        setState(() {
                                          showDialog(
                                            context: context,
                                            builder: (context) => UpdateRepsAlertDialog(setStateCallback: setStateCallback, updateSetCallback: updateSetCallback, exIndex: exIndex, setIndex: setIndex,),
                                          );
                                        });
                                      }
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        ),
                      // Display exercise notes, if present
                      if (notes != '') Container(
                          margin: const EdgeInsets.all(10.0), 
                          child: ListTile(
                            visualDensity: const VisualDensity(vertical: -4),
                            tileColor: Theme.of(context).brightness == Brightness.dark
                              ? const Color.fromARGB(255, 46, 46, 46)
                              : Colors.white,
                            title: Text('Notes: $notes'),                
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
                                radius: 6,
                                backgroundColor: Colors.grey,
                              ),
                            trailing: CircleAvatar(
                              backgroundColor: const Color.fromARGB(100, 46, 46, 46),
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(Icons.edit_note), 
                                onPressed: () {
                                  setState(() {
                                    showDialog(
                                      context: context,
                                      builder: (context) => UpdateNoteDialogBox(callback: updateNoteCallback, exIndex: exIndex),
                                    );
                                  });
                                }
                              ),
                            ),
                          )
                        ),
                      ]
                    ),
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
