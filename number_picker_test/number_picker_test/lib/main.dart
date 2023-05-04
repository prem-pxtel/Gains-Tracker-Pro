import 'dart:io';

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
  double _currentValueRest = 1;
  String emojiText = '⏰';
  

  int seconds = 60;
  Timer? timer;
  bool timerRun = false;
  bool wasjust0 = false;
  bool buttonnull = false;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        if (seconds >0 && wasjust0 == false){
        timerRun = true;
        seconds--;
        _currentValueRest = convert2display(seconds);
        emojiText = '❌';
        buttonnull = false;
        }
        else{
          setState(() {
          timerRun = false;
          buttonnull = false;
          emojiText = '⏰';
          wasjust0 = true;
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
    buttonnull = false;
    timer?.cancel();
    
    });
    
  }

  double convert2display(seconds){
    int secondpart = (seconds%60).toInt();
    int minutepart = (seconds/60).floor();
    double display = minutepart + (secondpart/100);
    return display;

  }
  int convert2seconds (display){
    int seconds = ((display.floor()*60) + ((display - display.floor())*100)).toInt();
    return seconds;

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
                TextButton(
                  onPressed: (){
                  if (buttonnull){
                     null;
                  }
                  else{if (timerRun == false && seconds > 0){startTimer(); wasjust0 = false; buttonnull = true;}
                  else{cancelTimer(); buttonnull = true;}
                  }
                  
                  
                }, child: Text('$emojiText')),

                DecimalNumberPicker(minValue: 0,
                 maxValue: 30,
                  value: convert2display(seconds),
                  integerZeroPad: true,
                  decimalPlaces: 2,
                  textStyle: TextStyle(color: Color.fromARGB(150, 20, 20, 20)),
                  selectedTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  onChanged: (value) => setState((){
                    if(timerRun){
                      _currentValueRest = convert2display(seconds);
                    }
                    else{
                      if (value > 20){
                        value = 20;
                        _currentValueRest = 20;
                        seconds = 1200;
                      }
                      else{setState(() {
                        _currentValueRest = value;
                      seconds = convert2seconds(_currentValueRest);
                      });}
                     }}))
               
//               NumberPicker(
//                  key: UniqueKey(),
//                  minValue: 0,
  //                maxValue: 300,
    //              value: _currentValueRest,
      //            textStyle: TextStyle(color: Color.fromARGB(150, 20, 20, 20)),
        //          selectedTextStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          //        onChanged: (value) => setState((){
            //        if(timerRun){
              //        _currentValueRest = seconds;
                //    }
                  //  else{
                    //  
  //                    _currentValueRest = value;
    //                  seconds = value;
      //               }})),
                  
            ]),
        
        ]
      ),
      )
        
    );
  }
  

}