import 'package:flutter/material.dart';
import 'randfuncs.dart';
import 'package:intl/intl.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'classes.g.dart';

@HiveType(typeId: 0)
class Workout {
  @HiveField(0)
  late String wkoutName;
  @HiveField(1)
  late DateTime dt;
  @HiveField(2)
  late DateTime dtwithTime;
  @HiveField(3)
  List<Exercise> exList = [];
  @HiveField(4)
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

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  late String exName;
  @HiveField(1)
  String notes = '';
  @HiveField(2)
  List<Set> setList = [];
}

@HiveType(typeId: 2)
class Set {
  @HiveField(0)
  int repCount = 0;
  @HiveField(1)
  int weight = 0;

  Set(int reps, int theWeight) {
    repCount = reps;
    weight = theWeight;
  }
}