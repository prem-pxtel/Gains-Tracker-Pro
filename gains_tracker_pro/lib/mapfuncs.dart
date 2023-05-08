import 'homepage.dart';
import 'classes.dart';

int getVol(List<Exercise> exList) {
  int totalVol = 0;
  for (int i = 0; i < exList.length; ++i) {
    int numSets = exList[i].setList.length;
    for (int j = 0; j < numSets; ++j) {
      int repCount = exList[i].setList[j].repCount;
      int weight = exList[i].setList[j].weight;
      totalVol += (repCount * weight);
    }
  }
  return totalVol;
}

/*
void updateMap(DateTime key) {
  int volume = 0;
  for (int i = 0; i < wkoutList.length; ++i) {
    if (wkoutList[i].dt == key) {
      volume += getVol(wkoutList[i].exList);
    }
  }
  wkoutMap[key] = volume;
}
*/

void updateMap() {
  wkoutMap.putIfAbsent(wkoutList.last.dt, () => getVol(wkoutList.last.exList));
}