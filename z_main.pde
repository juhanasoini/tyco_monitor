void draw()
{
  HandleSerialInput();
  if(Mode == Modes.RACE_COUNTDOWN && CountdownDone == false)
  {
    if(!CountdownStarted)
    {
      CountdownStarted = true;
      HandleCountdown(CountDownPhase);
    }
    else
    {
      if((frameCount - CountdownStartedAt) % 60 == 0)
      {
        CountDownPhase--;
        HandleCountdown(CountDownPhase);
      }
    }
  }
  if(TimingStarted)
  {
    TimingDuration = millis() - TimingStartTime;
    
    if(Mode != Modes.RACE_COUNTDOWN)
      PrintClock( TimingDuration );
    else if(Mode == Modes.RACE_COUNTDOWN && TimingDuration > 2000)
    {
      if(CountdownCleared == false)
      {
        ClearBoard();
        CountdownCleared = true;
        PrintLaneLabel(1);
        PrintLaneLabel(2);
      }
      PrintClock( TimingDuration );
    }
  }
}
