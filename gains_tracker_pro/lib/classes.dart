import 'package:flutter/material.dart';
import 'randfuncs.dart';

class Workout {
  String wkoutName = 'New Workout';
  int month = 0;
  int day = 0;
  int year = 0;
  List<Exercise> exList = [];
  String emoji = randEmoji();
  Color c = randColor();
}

class Exercise {
  String exName = 'New Exercise';
  String notes = '';
  List<Set> setList = [];
}

class Set {
  int repCount = 0;
}