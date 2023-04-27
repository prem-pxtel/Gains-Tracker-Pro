class Workout {
  String wkoutName = 'New Workout';
  int month = 0;
  int day = 0;
  int year = 0;
  List<Exercise> exList = [];
}

class Exercise {
  String exName = 'New Exercise';
  String notes = '';
  List<Set> setList = [];
}

class Set {
  int repCount = 0;
}