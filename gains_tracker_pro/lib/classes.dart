import 'package:flutter/material.dart';
import 'randfuncs.dart';

class Workout {
  String wkoutName =  'New Workout';
  DateTime dt = DateTime.now();
  List<Exercise> exList = [];
  String emoji = randEmoji();
  Color c = randColor();
  Workout(this.wkoutName);
  //comment
}

class Exercise {
  String exName = 'New Exercise';
  String notes = '';
  List<Set> setList = [];
}

class Set {
  int repCount = 0;
}