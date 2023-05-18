import 'package:hive_flutter/hive_flutter.dart';

class WorkoutDatabase {
  List wkoutList = [];
  Map wkoutMap = {};
  Map prMap = {};
  List prKeys = [];
  List prVals = [];

  // reference box
  final _myBox = Hive.box('theBox');

  void loadWkouts() {
    wkoutList = _myBox.get("WKOUTLIST");
    wkoutMap = _myBox.get("WKOUTMAP");
  }

  void loadPRs() {
    prMap = _myBox.get("PRMAP");
    prKeys = _myBox.get("PRKEYS");
    prVals = _myBox.get("PRVALS");
  }

  void updateDatabase() {
    _myBox.put("WKOUTLIST", wkoutList);
    _myBox.put("WKOUTMAP", wkoutMap);
    _myBox.put("PRMAP", prMap);
    prKeys = prMap.keys.toList();
    prVals = prMap.values.toList();
    _myBox.put("PRKEYS", prKeys);
    _myBox.put("PRVALS", prVals);
  }
}