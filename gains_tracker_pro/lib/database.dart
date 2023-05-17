import 'package:hive_flutter/hive_flutter.dart';

class WorkoutDatabase {
  List wkoutList = [];
  Map wkoutMap = {};
  Map prMap = {};

  // reference box
  final _myBox = Hive.box('theBox');

  void loadData() {
    wkoutList = _myBox.get("WKOUTLIST");
    wkoutMap = _myBox.get("WKOUTMAP");
    prMap = _myBox.get("PRMAP");
  }

  void updateDatabase() {
    _myBox.put("WKOUTLIST", wkoutList);
    _myBox.put("WKOUTMAP", wkoutMap);
    _myBox.put("PRMAP", prMap);
  }
}