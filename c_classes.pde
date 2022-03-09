class Lane {
  ArrayList<Lap> Laps;
  int LaneNr;
  int LapCount;
  Lap BestLap;
  Lane(int laneNr)
  {
    LaneNr = laneNr;
    Laps = new ArrayList<Lap>();
  }
  void AddLap(Lap lap)
  {  
    Laps.add(lap);
    LapCount = lap.LapNr;
    if(BestLap == null || (BestLap != null && lap.LapTime < BestLap.LapTime))
    { 
      BestLap = lap;
    }
  }
  void Reset()
  {
    BestLap = null;
    for (int i = Laps.size() - 1; i >= 0; i--) {
      Laps.remove(i);
    }
  }
}

class Lap {
  int LapNr, LapTime;
  Lap(int lapNr, int lapTime)
  {
    LapNr = lapNr;
    LapTime = lapTime;
  }
}
