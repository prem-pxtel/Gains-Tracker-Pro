class Workout {
  String wkoutName = '';
  int month = 0;
  int day = 0;
  int year = 0;
  int numEx = 0;
}

class Exercise extends Workout {
  String exName = '';
  String notes = '';
  int numSets = 0;
}

class Set extends Exercise {
  int repCount = 0;
}