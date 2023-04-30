import 'homepage.dart';
import 'classes.dart';

Map<DateTime, int> wkoutMap = {};

int getVol(List<Exercise> exList) {
  int repCount = 0;
  for (int i = 0; i < exList.length; i++) {
    int numSets = exList[i].setList.length;
    for (int j = 0; j < numSets; ++j) {
      repCount += exList[i].setList[j].repCount;
    }
  }
  return repCount;
}

void updateMap(DateTime key) {
  int volume = 0;
  for (int i = 0; i < wkoutList.length; ++i) {
    if (wkoutList[i].dt == key) {
      volume += getVol(wkoutList[i].exList);
    }
  }
  wkoutMap[key] = volume;
}

