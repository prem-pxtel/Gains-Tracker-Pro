import 'package:hive_flutter/hive_flutter.dart';

class WorkoutDatabase {
  List wkoutList = [];

  // reference box
  final _myBox = Hive.box('theBox');

  void loadData() {
    wkoutList = _myBox.get("WKOUTLIST");
  }

  void updateDatabase() {
    _myBox.put("WKOUTLIST", wkoutList);
  }
}