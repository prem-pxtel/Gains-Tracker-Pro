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

// check if indexing with i = 1...length is valid

PR prExUpdater(String name) {
  int afterdelpr = -1;
  DateTime afterdeldate = DateTime.now();
  PR dummy = PR(afterdelpr, afterdeldate, true);
  for (int i = 1; i <= db.wkoutList.length; ++i) {
    int exindexPR = db.wkoutList[i].exList.exName.indexof(name);
    if (exindexPR != -1) {
      for (int setIndexafterdel = 1; i <= db.wkoutList[i].exList[exindexPR].setList.length; ++i) {
        if (db.wkoutList[i].exList[exindexPR].setList[setIndexafterdel].
            prWeight >= afterdelpr) {
              
          afterdelpr = db.wkoutList[i].exList[exindexPR].setList[setIndexafterdel].prWeight;
          afterdeldate = db.wkoutList[i].dt;
          PR replacement = PR(afterdelpr, afterdeldate);
          return replacement;
        }
      }
    }
  }
  return dummy;
}

void updatePRMap(List<Exercise> e, int exIndex) {
  String exName = e[exIndex].exName;
  PR newPR = prExUpdater(exName);
  if (newPR.toBeDeleted == true) {
    db.prMap.remove(exName);
  } else {
    db.prMap[exName] = newPR;
  }
}

void prWkoutUpdater(deletedwkout) {
  for (int i = 1; i <= db.wkoutList.length; ++i) {
    updatePRMap(db.wkoutList[deletedwkout].exList, i);
  }
}