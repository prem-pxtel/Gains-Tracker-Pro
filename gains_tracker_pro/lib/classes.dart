import 'package:flutter/material.dart';
import 'randfuncs.dart';
import 'package:intl/intl.dart';

class Workout {
  String wkoutName =  'New Workout';
  late DateTime dt;
  List<Exercise> exList = [];
  String emoji = randEmoji();
  Color c = randColor();
  Workout() {
    final DateTime now = DateTime.now();
    dt = now;
    final DateFormat formatter = DateFormat('MMMMd');
    formatter.add_jm();
    final String formattedDate = formatter.format(now);
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
}