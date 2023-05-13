import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'classes.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

class NumberPickerScreen extends StatefulWidget {
  final int wkoutIndex;
  final Function callback;
  const NumberPickerScreen({super.key, required this.wkoutIndex, required this.callback});

  @override
  State<NumberPickerScreen> createState() => _NumberPickerScreenState();
}

class _NumberPickerScreenState extends State<NumberPickerScreen> {
  String _curEmoji = '⏰';
  int _seconds = 60;
  double _restTime = 0;
  late Timer timer;
  bool timerRun = false;
  bool buttonNull = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          if (_seconds > 0) {
            timerRun = true;
            _seconds--;
            _restTime = toDisplay(_seconds);
            _curEmoji = '❌';
            buttonNull = false;
          } else {
            setState(() {
              buttonNull = false;
              _curEmoji = '⏰';
              HapticFeedback.vibrate();
            });        
          }
        });
      }
    });
  }

  void cancelTimer() {
    setState(() {
      timerRun = false;
      buttonNull = false;
      timer.cancel();
      _curEmoji = '⏰';
      _restTime = 60;
      _seconds = 60;
    });  
  }

  double toDisplay(int seconds) {
    int secondPart = (seconds % 60).toInt();
    int minutePart = (seconds / 60).floor();
    double display = minutePart + (secondPart / 100);
    return display;
  }

  int toSeconds(double display) {
    int seconds = ((display.floor() * 60) + 
                  ((display - display.floor()) * 100)).toInt();
    return seconds;
  }
   
  @override
  Widget build(BuildContext context) {
    double screensize = MediaQuery.of(context).size.height - 16;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(120), topRight: Radius.circular(120)),
        color: Theme.of(context).brightness == Brightness.dark
                    ? (const Color.fromARGB(255, 44, 44, 44))
                    : (const Color.fromARGB(255, 227, 227, 227))
      ),
      padding: const EdgeInsets.only(bottom: 15, left: 90, top: 15),
      margin: EdgeInsets.only(top: screensize.round() - 320),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Material(
            color: const Color.fromARGB(81, 136, 162, 165),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                TextButton(
                  onPressed: () {
                    if (!buttonNull) {
                      if (timerRun == false && _seconds > 0) {
                        startTimer();
                        buttonNull = true;
                      } else {
                        cancelTimer();
                      }
                    }
                  }, 
                  style: ButtonStyle(backgroundColor: Theme.of(context).brightness == Brightness.dark
                    ? const MaterialStatePropertyAll(Color.fromARGB(255, 47, 47, 47))
                    : const MaterialStatePropertyAll(Color.fromARGB(255, 245, 245, 245)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                      )
                    )
                  ),
                  child: Text(_curEmoji),
                ),
                DecimalNumberPicker(
                  minValue: 0,
                  haptics: true,
                  maxValue: 30,
                  itemWidth: 40,
                  value: toDisplay(_seconds),
                  decimalPlaces: 2,
                  textStyle: const TextStyle(color: Colors.grey),
                  selectedTextStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  ),
                  onChanged: (value) => setState(() {
                    if (timerRun) {
                      _restTime = toDisplay(_seconds);
                    } else {
                      if (value > 20) {
                        value = 20;
                        _restTime = 20;
                        _seconds = 1200;
                        HapticFeedback.selectionClick();
                      } else {
                        _restTime = value;
                        _seconds = toSeconds(_restTime);
                      }
                    }
                  })
                )                
              ]
            ),
          ),
          const Spacer(flex: 1),
          Material(
            color: const Color.fromARGB(81, 136, 162, 165),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Row(
              children: <Widget> [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Container(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: const Icon(Icons.fitness_center),
                    ),
                    NumberPicker(
                      minValue: 0,
                      maxValue: 1000,
                      haptics: true,
                      itemWidth: 45,
                      step: 5,
                      value: curWeight,
                      textStyle: const TextStyle(color: Colors.grey),
                      selectedTextStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      ),
                      onChanged: (value) => setState(() { curWeight = value; HapticFeedback.selectionClick();})
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget> [
                    Container(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: const Icon(Icons.tag),
                    ),
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
                  ]
                ),
              ]
            ),
          ),
          Container(padding: const EdgeInsets.only(left: 30), 
            child: MaterialButton(
              color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
              shape: const CircleBorder(),
              textColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
              child: Icon(Icons.check, color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white),
              onPressed: () {
                Set newSet = Set(curReps, curWeight);
                widget.callback(newSet);
              },
            ),
          ),
        ],
      ),    
    );
  }
}