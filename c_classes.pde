class Lane {
  ArrayList<Lap> Laps;
  Hashtable<Integer, LapInterval> LapIntervals;
  int LaneNr;
  int LapCount;
  Lap BestLap;
  Lane(int laneNr)
  {
    LaneNr = laneNr;
    Laps = new ArrayList<Lap>();
    LapIntervals = new Hashtable<Integer, LapInterval>();
  }
  void AddLap(Lap lap)
  {  
    Laps.add(lap);
    LapCount = lap.LapNr;
    if(BestLap == null || (BestLap != null && lap.LapTime < BestLap.LapTime))
    { 
      BestLap = lap;
    }
    //int index = lap.LapNr-1;
    //if(index >= LapIntervals.size())
    //{
    //  LapIntervals.add(new LapInterval(lap.LapNr));
    //}
  }
  void AddInterval(int lapNr, int time)
  {
    LapInterval interval = LapIntervals.get(lapNr);
    
    if( interval == null)
    {
      LapIntervals.put(lapNr, new LapInterval(lapNr));
      interval = LapIntervals.get(lapNr);
    }
    
    if(interval.Intervals.size() < 3)
      interval.Intervals.add(time);
  }
  void Reset()
  {
    BestLap = null;
    LapCount = 0;
    for (int i = Laps.size() - 1; i >= 0; i--) {
      Laps.remove(i);
    }
      LapIntervals.clear();
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

class LapInterval {
  int LapNr;
  ArrayList<Integer> Intervals;
  LapInterval()
  {
    Intervals = new ArrayList<Integer>();
  }
  LapInterval(int lapNr)
  {
    LapNr = lapNr;
    Intervals = new ArrayList<Integer>();
  }
}
