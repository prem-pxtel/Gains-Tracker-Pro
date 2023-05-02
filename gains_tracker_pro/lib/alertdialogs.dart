import 'package:flutter/material.dart';
import 'classes.dart';
import 'homepage.dart';
import 'mapfuncs.dart';

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
          const Text('Please enter your workout information'),   
          Padding(
            padding: const EdgeInsets.only(top: 55.0), child: TextField(
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
        TextButton(
          onPressed: () {
            //setState(() { must find a way to setState of ExerciseScreen widget --> CALLBACK()
              callback();
            //});
          }, 
          child: const Text('Save')
        ),
      ],
    );
  }
}


// AlertDialog updateRepsDialog = UpdateRepsAlertDialog();

class UpdateRepsAlertDialog extends StatelessWidget {
  const UpdateRepsAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Exercise'),
      content: const Text('Please enter your shits now.'),
      actions: [
        TextButton(
          onPressed: () { Navigator.pop(context); }, 
          child: const Text('Cancel')
        ),
        TextButton(
          onPressed: () {
            
          }, 
          child: const Text('Save')
        ),
      ],
    );
  }
}