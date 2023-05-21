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

void updateWkoutMap() {
  db.wkoutMap.putIfAbsent(db.wkoutList.last.dt, () => getVol(db.wkoutList.last.exList));
}

int getExIndex(List<Exercise> list, String name) {
  for (int i = 0; i < list.length; ++i) {
    if (list[i].exName == name) return i;
  }
  return -1;
}

List<String> getExNames(int wkoutIndex) {
  List<String> names = [];
  for (int i = 0; i < db.wkoutList[wkoutIndex].exList.length; ++i) {
    names.add(db.wkoutList[wkoutIndex].exList[i].exName);
  }
  return names;
}

PR findNewPR(String name) {
  int toBePR = -1;
  DateTime toBePRDT = DateTime.now();

  for (int i = 0; i < db.wkoutList.length; ++i) {
    int matchExIndex = getExIndex(db.wkoutList[i].exList, name);
    if (matchExIndex != -1) {
      int setLen = db.wkoutList[i].exList[matchExIndex].setList.length;
      for (int j = 0; j < setLen; ++j) {
        int setWeight = db.wkoutList[i].exList[matchExIndex].setList[j].weight;
        if (setWeight > toBePR) {
          toBePR = db.wkoutList[i].exList[matchExIndex].setList[j].weight;
          toBePRDT = db.wkoutList[i].dt;
        }
      }
    }
  }
  if (toBePR > -1) {
    PR replacement = PR(toBePR, toBePRDT);
    return replacement;
  }
  PR dummy = PR(toBePR, toBePRDT, true);
  return dummy;
}

void updatePRMap(String exName) {
  PR newPR = findNewPR(exName);
  if (newPR.toBeDeleted == true) {
    db.prMap.remove(exName);
  } else {
    db.prMap[exName] = newPR;
  }
}

void updatePRMapB4D(String exName, DateTime dt) {
  PR newPR = findNewPR(exName);
  if (newPR.toBeDeleted == true || newPR.prDatetime == dt) {
    db.prMap.remove(exName);
  } else {
    db.prMap[exName] = newPR;
  }
}

// need to deal with special case:
// if newPR.dt == dt of delWkout, then remove from prMap
void prWkoutUpdater(List<String> names, DateTime dt) {
  for (int i = 0; i < names.length; ++i) {
    updatePRMapB4D(names[i], dt);
  }
}