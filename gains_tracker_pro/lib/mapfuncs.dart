import 'homepage.dart';
import 'classes.dart';

 //++i = ++gains 

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

void updateMap() {
  db.wkoutMap.putIfAbsent(db.wkoutList.last.dt, () => getVol(db.wkoutList.last.exList));
}

PR prsorterExlist(String Exname) {
  int afterdelpr = -1;
  DateTime afterdeldate = DateTime.now();
  PR newPR = PR(afterdelpr, afterdeldate);
  for (int i = 1; i <= db.wkoutList.length;) {
    int exindexPR = db.wkoutList[i].exList.Exname.indexof(Exname);
    if (exindexPR != -1) {}
    else {
      for (int setIndexafterdel = 1; i <= db.wkoutList[i].exList[exindexPR].setList.length;){
        if (db.wkoutList[i].exList[exindexPR].setList[setIndexafterdel].weight >= afterdelpr) {
          afterdelpr = db.wkoutList[i].exList[exindexPR].setList[setIndexafterdel].weight;
          afterdeldate = db.wkoutList[i].dt;
          PR newPR = PR(afterdelpr, afterdeldate);
          return newPR;
        }
        else{
        }}

      }
    }
    return newPR;
  }

  void updatePRMap(List e, int exIndex) {
    String exName = e[exIndex].exName;
    PR newPR = prsorterExlist(exName);
    if (newPR.prWeight == -1){
      db.prMap.remove(exName);
    }
    else {
      db.prMap[exName] = newPR;
    }
  }

  void prUpdaterWkout(deletedwkout){
    for (int i = 1 ; i<=db.wkoutList[deletedwkout].length;){
      updatePRMap(db.wkoutList[deletedwkout].exList, i);
    }
  }

