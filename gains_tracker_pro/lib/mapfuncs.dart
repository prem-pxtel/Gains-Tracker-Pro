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
  for (int i = 0; i < db.wkoutList.length; ++i) {
    if (db.wkoutList[i].dt == key) {
      volume += getVol(db.wkoutList[i].exList);
    }
  }
  wkoutMap[key] = volume;
}
*/

void updateMap() {
  db.wkoutMap.putIfAbsent(db.wkoutList.last.dt, () => getVol(db.wkoutList.last.exList));
}