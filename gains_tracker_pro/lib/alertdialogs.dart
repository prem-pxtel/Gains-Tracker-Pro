import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

// note: constructor run before widget is inserted in tree, initState() is after
// there is also dispose()

// AlertDialog addExDialog = AddExerciseAlertDialog();

class AddExerciseAlertDialog extends StatelessWidget {
  final TextEditingController textController;
  final int wkoutIndex;
  final Function callback;
  const AddExerciseAlertDialog({
    super.key,
    required this.textController,
    required this.wkoutIndex,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Exercise'),
      content: Stack(
        children: [
          const Text('Please enter your exrecise information'),   
          Padding(
            padding: const EdgeInsets.only(top: 55.0), child: TextField(
              autofocus: true,
              controller: textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'e.g. Bench Press',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textController.clear();
                  }  
                )
              ),
            ),
          ),
        ]),
      actions: [
        TextButton(
          onPressed: () { Navigator.pop(context); }, 
          child: const Text('Cancel')
        ),
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            //setState(() { must find a way to setState of ExerciseScreen widget --> CALLBACK()
              callback();
            //});
          }, 
          shape: RoundedRectangleBorder(
		        borderRadius: BorderRadius.circular(20),
	        ),
          child: const Text('Save')
        ),
      ],
      shape: RoundedRectangleBorder(
		    borderRadius: BorderRadius.circular(20),
	    ),
    );
  }
}


// AlertDialog updateRepsDialog = UpdateRepsAlertDialog();

class UpdateRepsAlertDialog extends StatefulWidget {
  final Function setStateCallback;
  final Function updateSetCallback;
  final int exIndex;
  final int setIndex;
  const UpdateRepsAlertDialog({
    required this.setStateCallback,
    required this.updateSetCallback,
    required this.exIndex,
    required this.setIndex,
    super.key,
  });

  @override
  State<UpdateRepsAlertDialog> createState() => _UpdateRepsAlertDialogState();
}

class _UpdateRepsAlertDialogState extends State<UpdateRepsAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Set'),
      content: 
Row(
              children: <Widget> [
                SizedBox(
                  width: 90,
                  height: 200,
                  child: Column(
                  
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Container(
                      padding: const EdgeInsets.only(bottom: 13, left: 30, top: 10),
                      child: const Icon(Icons.fitness_center),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child:
                    NumberPicker(
                      minValue: 0,
                      maxValue: 1000,
                      haptics: true,
                      itemWidth: 45,
                      value: curWeight,
                      textStyle: const TextStyle(color: Colors.grey),
                      selectedTextStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      ),
                      onChanged: (value) => setState(() { curWeight = value; HapticFeedback.selectionClick();})
                    ),
                    ),
                  ],
                ),
                ),
                SizedBox(
                  width: 90,
                  height: 200,
                  child:Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Container(
                      padding: const EdgeInsets.only(bottom: 13, left: 30, top: 10),
                      child: const Icon(Icons.tag),
                    ),
                    Container(padding: EdgeInsets.only(left: 30), child:
                    NumberPicker(
                      minValue: 0,
                      maxValue: 125,
                      value: curReps,
                      haptics: true,
                      itemWidth: 45,
                      textStyle: const TextStyle(color: Colors.grey),
                      selectedTextStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      ),
                      onChanged: (value) => setState(() => {curReps = value, HapticFeedback.selectionClick()})
                    ),
                    ),
                  ]
                ),)
                
                
              ]
            ),
          

          
      
      shape: RoundedRectangleBorder(
		    borderRadius: BorderRadius.circular(20),
	    ),
      actions: [
        TextButton(
          onPressed: () { widget.setStateCallback(); Navigator.pop(context); }, 
          child: const Text('Cancel')
        ),
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            widget.updateSetCallback(widget.exIndex, widget.setIndex, curReps, curWeight);
            Navigator.pop(context);
          }, 
          shape: RoundedRectangleBorder(
		        borderRadius: BorderRadius.circular(20),
	        ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}