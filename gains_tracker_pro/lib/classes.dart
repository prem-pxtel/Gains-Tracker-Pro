import 'package:flutter/material.dart';
import 'randfuncs.dart';
import 'package:intl/intl.dart';

class Workout {
  String wkoutName =  'New Workout';
  late DateTime dt;
  late DateTime dtwithTime;
  List<Exercise> exList = [];
  String emoji = randEmoji();
  Color c = randColor();
  Workout() {
    final DateTime now = DateTime.now();
    final DateTime date = DateTime(now.year, now.month, now.day);
    dt = date;
    final DateFormat formatter = DateFormat('MMMMd');
    formatter.add_jm();
    final String formattedDate = formatter.format(now);
    dtwithTime = now;
    wkoutName = formattedDate;
  }
}

class Exercise {
  String exName = 'New Exercise';
  String notes = '';
  List<Set> setList = [];
}

class Set {
  int repCount = 0;
  int weight = 0;
}