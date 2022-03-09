void Reset(Modes mode, boolean init)
{
  Mode = mode;
  
  PrintClock( 0 );
  
  if(!init)
    PlayerStop();
    
  OffNote(PitchHigh);
  OffNote(Pitch);
  CountdownDone = false;
  CountDownPhase = 4;
  CountdownStartedAt = 0;
  CountdownStarted = false;
  CountdownCleared = false;
  TimingStarted = false;
  TimingDuration = 0;
  TimingStartTime = 0;
  FreeTimingLapCount = 0;
  PreviousFreeTimingLapTimed = 0;
  
  LaneT.Reset();
  Lane1.Reset();
  Lane2.Reset();
  
  fill( #000000 );
  stroke( #000000 );
  rect( 0, LaneBlockY+XPadding, WindowWidth, WindowHeight );
  ClearBoard(); 
  switch(Mode)
  {
    case NONE:
      break;
    case FREE:
      PrintClock( 0 );
      PrintLaneLabel(0);
      break;
    case RACE:
      PrintClock( 0 );
      PrintLaneLabel(1);
      PrintLaneLabel(2);
      break;
    case RACE_COUNTDOWN:
      break;
    case TIME_TRIAL:
      PrintClock( 0 );
      PrintLaneLabel(0);
      break;
  }  
}
boolean StartTiming()
{
  if(TimingStarted)
    return true;
    
  PlayStart();
    
  TimingStarted = true;
  TimingStartTime = millis();
  PreviousFreeTimingLapTimed = TimingStartTime;
  
  if(Mode != Modes.RACE_COUNTDOWN || TimingDuration > 2000)
    PrintClock( TimingDuration );
  
  return false;
}

void StopTiming()
{
  TimingStarted = false;
}
void AddLap(int lane, int lapNr, int lapTime)
{
  Lap lap = new Lap(lapNr, lapTime);
  switch(lane)
  {
    case 0:
      LaneT.AddLap(lap);
      break;
    case 1:
      Lane1.AddLap(lap);
      break;
    case 2:
      Lane2.AddLap(lap);
      break;
  }
  PlayByPass();
  PrintLapRows(lane);
}

void SetWinner(int laneNr)
{
  ShowWinner(laneNr);
  PlayEnd();
}

String formatTime( int Millis, boolean showMillis )
{
  int milliss = numberOfMillis( Millis );
  int hundredths = numberOfHundreths(Millis);
  int seconds = numberOfSeconds( Millis );
  int minutes = numberOfMinutes( Millis );
  int hours = numberOfHours( Millis );

  String value;

  value = "";
  if( hours > 0 )
    value += getDigits( str( hours ), 2 )+":";
  value += getDigits( str( minutes ), 2 )+":";
  value += getDigits( str( seconds ), 2 );
  value += ".";
  if(showMillis)
    value += getDigits( str( milliss ), 3 );
  else
    value += getDigits( str( hundredths ), 2 );
  value = trim( value );
  return value;
}

String getDigits( String value, int digits )
{
  int valLength = value.length();
  if( valLength < digits )
  {
    for( int x = valLength; x < digits; x++)
    {
      value = "0"+value;
    }
  }
  return value;
}


void WindowSetup( boolean startup )
{
  // Create the font  
  textFont( createFont( "Courier New", 36 ) );
  if( startup )
    background(0); // Set background to black
  
  //Tyco logo
  logo = loadShape("images/tyco_logo.svg");
  logo.disableStyle();  // Ignore the colors in the SVG
  fill( #f7ff0f );    // Set the SVG fill to yellow
  stroke( #f7ff0f );
  shape( logo, 20, 10, 204, 57);
  fill( 255 );
  textAlign( LEFT );
  text( "Monitor v0.5", 230, 70 );
}

void keyPressed() {
  println(key, keyCode);
  if(keyCode>=65 && keyCode <=74)
  {
    int selKey = keyCode-65;
    SerialConnect(selKey);
    return;
  }
  
  switch(keyCode)
  {
    case 32://Space
      if(Mode == Modes.FREE && TimingStarted)
      {
        FreeTimingLapCount++;
        int lapTime = millis() - PreviousFreeTimingLapTimed;
        PreviousFreeTimingLapTimed = millis();
        AddLap(0, FreeTimingLapCount, lapTime);
      }
      else if(Mode == Modes.FREE)
        StartTiming();
      
      break;
    case ENTER:
      if(Mode == Modes.FREE)
        TimingStarted = false;
      break;
    case 49://1
      SerialWrite('1');
      Reset(Modes.TIME_TRIAL, false);
      break;
    case 50://2
      SerialWrite('2');
      Reset(Modes.RACE, false);
      break;
    case 51://3
      SerialWrite('2');
      Reset(Modes.RACE_COUNTDOWN, false);
      break;
    case 52://4
      Reset(Modes.FREE, false);
      break;
    case 81://Q
      SerialDisconnect();
      break;
    case 82://R
      SerialWrite('R');
      Reset(Mode, false); 
      break;
  }
}

void delayd(int time) 
{
  int current = millis();
  while (millis () < current+time) Thread.yield();
}

void SerialDisconnect()
{
  if(BTConnected && SerialPort != null)
  {
    SerialPort.stop();
    BTConnected = false;
  }
  PrintPortList();
}

void SerialConnect(int port)
{
  SerialDisconnect();
  try{
    String portName = Serial.list()[port];
    println("Trying to connect to "+portName);
    SerialPort = new Serial(this, portName, 9600);
    SerialPort.clear();
    SerialPort.bufferUntil('\n');
    BTConnected = true;
    ConsoleBox("");
  }
  catch(Exception e)
  {
    println(e.getMessage());
  }
}
