import 'package:flutter/material.dart';
import 'homepage.dart';
import 'classes.dart';


int getRepcount(List<Exercise> exList) {
  int repCount = 0;
  for (int i = 0; i < exList.length; ++i) {
    int numSets = exList[i].setList.length;
    for (int j = 0; j < numSets; ++j) {
      repCount += exList[i].setList[j].repCount;
    }
  }
  return repCount;
}
