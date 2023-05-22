import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

// note: constructor run before widget is inserted in tree, initState() is after
// there is also dispose()

// AlertDialog addExDialog = AddExAlertDialog();

class AddExAlertDialog extends StatelessWidget {
  final TextEditingController textController;
  final TextEditingController textController2;
  final int wkoutIndex;
  final Function callback;
  const AddExAlertDialog({
    super.key,
    required this.textController,
    required this.textController2,
    required this.wkoutIndex,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Exercise'),
      content: Stack(
        children: [
          const Text('Please enter your exercise information'),
          const Padding(padding: EdgeInsets.only(top: 75), child: Icon(Icons.fitness_center)),
          Padding(
            padding: const EdgeInsets.only(top: 55.0, left: 35, right: 5), child: TextField(
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
          const Padding(padding: EdgeInsets.only(top: 145), child: Icon(Icons.notes_outlined)),
          Padding(
            padding: const EdgeInsets.only(top: 125.0, left: 35, right: 5), child: TextField(
              autofocus: true,
              controller: textController2,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Any thoughts?',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textController2.clear();
                  }  
                )
              ),
            ),
          ),
        ]),
      actions: [
        MaterialButton(
          onPressed: () { Navigator.pop(context); }, 
          shape: RoundedRectangleBorder(
		        borderRadius: BorderRadius.circular(20),
	        ),
          child: const Text('Cancel')
        ),
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            if (db.wkoutList[wkoutIndex].exExists(textController.text)) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exercise already exists.')));
            } else {
            //setState(() { must find a way to setState of ExerciseScreen widget --> callback function
              callback();
            //});
            }
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

// AlertDialog updateSetDialog = UpdateSetAlertDialog();

class UpdateSetAlertDialog extends StatefulWidget {
  final Function setStateCallback;
  final Function updateSetCallback;
  final int exIndex;
  final int setIndex;
  const UpdateSetAlertDialog({
    required this.setStateCallback,
    required this.updateSetCallback,
    required this.exIndex,
    required this.setIndex,
    super.key,
  });

  @override
  State<UpdateSetAlertDialog> createState() => _UpdateSetAlertDialogState();
}

class _UpdateSetAlertDialogState extends State<UpdateSetAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Set'),
      content: Row(
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
                padding: const EdgeInsets.only(left: 30),
                child:
              NumberPicker(
                minValue: 0,
                maxValue: 1000,
                haptics: true,
                itemWidth: 45,
                value: curWeight,
                step: 5,
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
              Container(padding: const EdgeInsets.only(left: 30), child:
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
          ),
        )
      ]),
      shape: RoundedRectangleBorder(
		    borderRadius: BorderRadius.circular(20),
	    ),
      actions: [
        MaterialButton(
          onPressed: () { widget.setStateCallback(); Navigator.pop(context); }, 
          shape: RoundedRectangleBorder(
		        borderRadius: BorderRadius.circular(20),
	        ),
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

class UpdateNotesDialogBox extends StatelessWidget {
  final Function callback;
  final int exIndex;
  const UpdateNotesDialogBox({
    super.key,
    required this.callback,
    required this.exIndex,
  });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return AlertDialog(
      title: const Text('Your Notes'),
      content: Stack(
        children: [
          const Text('Please update your exercise notes'),
          const Padding(padding: EdgeInsets.only(top: 75), child: Icon(Icons.notes_outlined)),
          Padding(
            padding: const EdgeInsets.only(top: 55.0, left: 35, right: 5), child: TextField(
              autofocus: true,
              controller: textController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Any thoughts?',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textController.clear();
                  }  
                )
              ),
            ),
          ),
        ],
      ),
      actions: [
        MaterialButton(
          onPressed: () { 
            Navigator.pop(context); 
            textController.clear();
          }, 
          shape: RoundedRectangleBorder(
		        borderRadius: BorderRadius.circular(20),
	        ),
          child: const Text('Cancel')
        ),
        MaterialButton(
          color: Colors.blue,
          onPressed: () {
            callback(textController.text, exIndex);
            Navigator.pop(context);
            textController.clear();
          }, 
          shape: RoundedRectangleBorder(
		        borderRadius: BorderRadius.circular(20),
	        ),
          child: const Text('Save')
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}