import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentValueWeight = 3;
  int _currentValueReps = 10;
  int _currentValueRest = 60;
  String emojiText = '⏰';
  

  int seconds = 60;
  Timer? timer;
  bool timerRun = false;
  bool wasjust0 = false;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds >0 && wasjust0 == false){
        timerRun = true;
        seconds--;
        _currentValueRest = seconds;
        emojiText = '❌';
        }
        else{
          setState(() {
            timerRun = false;
          emojiText = '⏰';
          wasjust0 = true;
          timer?.cancel();
          });         
        }
      });
    });
  }

  void cancelTimer(){
    setState(() {
    timerRun = false;
    emojiText = '⏰';
    _currentValueRest = 60;
    seconds = 60;
    timer?.cancel();
    });

  }

   
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {

          });
        },),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                Text('🏋️'),
                NumberPicker(
                  key: UniqueKey(),
                  minValue: 0,
                  maxValue: 1000,
                  value: _currentValueWeight,
                  textStyle: TextStyle(color: Color.fromARGB(150, 20, 20, 20)),
                  selectedTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)) ,
                  onChanged: (value) => setState(() => _currentValueWeight = value)),],
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('#️⃣'),
                NumberPicker(
                  key: UniqueKey(),
                  minValue: 0,
                  maxValue: 125,
                  value: _currentValueReps,
                  textStyle: TextStyle(color: Color.fromARGB(150, 20, 20, 20)),
                  selectedTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  onChanged: (value) => setState(() => _currentValueReps = value)),
                  ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(onPressed: (){
                  if (timerRun == false){startTimer(); wasjust0 = false;}
                  else{cancelTimer();}
                  
                }, child: Text('$emojiText')),
                NumberPicker(
                  key: UniqueKey(),
                  minValue: 0,
                  maxValue: 300,
                  value: _currentValueRest,
                  textStyle: TextStyle(color: Color.fromARGB(150, 20, 20, 20)),
                  selectedTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  onChanged: (value) => setState((){
                    if(timerRun){
                      _currentValueRest = seconds;
                    }
                    else{
                      
                      _currentValueRest = value;
                      seconds = value;
                     }})),
                  
                  
            ]),
        
        ]
      ),
      )
        
    );
  }
  

}