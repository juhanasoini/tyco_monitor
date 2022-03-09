void HandleSerialInput()
{
  if (SerialPort != null && BTConnected && SerialPort.available() > 0) 
  {
    String val = SerialPort.readStringUntil(59);// 59 = ;
    String[] valList;
    String[] actionList;
    String action;
    String value;
    String[] valueList;
    int intValue;
    if( val != null )
    {
      val = val.replace(";", "");
      actionList = val.split("#");
      int actLength = actionList.length;
      if(actLength > 0)
      {
        for(int i=0;i<actLength;i++)
        {
          valList = split( actionList[i], "=" );
          action = valList[0];
          switch(action)
          {
            case "mode":
              value = valList[1];
              intValue = int(value); 
              Reset(Modes.values()[intValue], false);
              break;
            case "start":
              StartTiming();
              break;
            case "stop":
              StopTiming();
              break;
            case "lap":
              if(Mode != Modes.FREE && TimingStarted)
              {              
                value = valList[1];
                valueList = value.split("%");
                int lane = int(valueList[0]);
                if(Mode == Modes.TIME_TRIAL)
                  lane = 0;
                int lapNr= int(valueList[1]);
                int lapTime = int(valueList[2]);
                AddLap(lane, lapNr, lapTime);
              }
              break;
            case "winner":
              println(Mode);
              if(Mode == Modes.RACE || Mode == Modes.RACE_COUNTDOWN)
              {
                value = valList[1];
                intValue = int(value); 
                SetWinner(intValue);
              }
              break;
          }
        }
      }
      println(val);
      SerialPort.clear();
      return;
    }
  }
}

void SerialWrite(char c)
{
  if (SerialPort != null && BTConnected)
  {
    SerialPort.write(c);
  }
}
