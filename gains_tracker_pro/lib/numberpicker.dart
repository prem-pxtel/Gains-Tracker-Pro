import 'package:flutter/material.dart';
import 'package:gains_tracker_pro/homepage.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:async';
import 'classes.dart';

class NumberPickerScreen extends StatefulWidget {
  final int wkoutIndex;
  const NumberPickerScreen({super.key, required this.wkoutIndex});

  @override
  State<NumberPickerScreen> createState() => _NumberPickerScreenState();
}

class _NumberPickerScreenState extends State<NumberPickerScreen> {
  int _curWeight = 10;
  int _curReps = 20;
  String _curEmoji = '⏰';
  int _seconds = 60;
  double _restTime = 0;
  late Timer timer;
  bool timerRun = false;
  bool buttonNull = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_seconds > 0) {
          timerRun = true;
          _seconds--;
          _restTime = toDisplay(_seconds);
          _curEmoji = '❌';
          buttonNull = false;
        } else {
          setState(() {
            timerRun = false;
            buttonNull = false;
            _curEmoji = '⏰';
          });        
        }
      });
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
                  ((display - display.floor()) *100)).toInt();
    return seconds;
  }
   
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Column(
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
                          ? const MaterialStatePropertyAll(Colors.white)
                          : const MaterialStatePropertyAll(Colors.black),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            )
                            
                            
                          )),
                child: Text(_curEmoji),
                          
                
              ),
              DecimalNumberPicker(
                minValue: 0,
                haptics: true,
                maxValue: 30,
                itemWidth: 40,
                value: toDisplay(_seconds),
                integerZeroPad: true,
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
                    } else {
                      setState(() {
                      _restTime = value;
                      _seconds = toSeconds(_restTime);
                      });
                    }
                  }
                })
              )                
            ]
          ),
          const Spacer(flex: 1),
          Row(
            children: <Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Container(
                padding: const EdgeInsets.only(bottom: 15.5),
                child: const Text('🏋️'),
              ),
              NumberPicker(
                minValue: 0,
                maxValue: 1000,
                haptics: true,
                itemWidth: 40,
                value: _curWeight,
                textStyle: const TextStyle(color: Colors.grey),
                selectedTextStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                onChanged: (value) => setState(() => _curWeight = value)
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget> [
              Container(
                padding: const EdgeInsets.only(bottom: 15.5),
                child: const Text('#️⃣'),
              ),
              NumberPicker(
                minValue: 0,
                maxValue: 125,
                value: _curReps,
                haptics: true,
                itemWidth: 40,
                textStyle: const TextStyle(color: Colors.grey),
                selectedTextStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                ),
                onChanged: (value) => setState(() => _curReps = value)
              ),
            ]
          ),
            ]),
              Container(padding: EdgeInsets.only(top: 570, left: 30), 
              child: MaterialButton(
                color: Colors.black,
                shape: CircleBorder(),
                child: const Text('✓'), 
                onPressed: () {
                      setState(() {
                  Set newSet = Set(_curReps, _curWeight);
                  Exercise lastEx = wkoutList[widget.wkoutIndex].exList.last;
                  lastEx.setList.add(newSet);
    }); 
    

                },

              ),
              ),
              
        ]
      ),
    );
  }
}