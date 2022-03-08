
void PrintClock( int data )
{
  int clockY = 142;
  fill( 0 );
  stroke( #ffffff );
  int boxWidth = WindowWidth - (2*XPadding);
  rect( XPadding, clockY, boxWidth, 150);
  
  textAlign( CENTER );  
  int timeX = WindowWidth/2;
  int timeY = 260;
  fill( 255 );
  textFont( createFont(BoldFont, 150 ) );
  text( formatTime( data, false ), timeX, timeY );
}
void PrintLapRows(int laneNr)
{
  ArrayList<Lap> laps = new ArrayList<Lap>();
  Lane lane = LaneT;
  int blockWidth = WindowWidth/2-(XPadding*4);
  int x = LaneBlockOneX;
  int y = LaneBlockY+XPadding;//Add a little bit of space
  if( laneNr == 2 )
    x = WindowWidth/2+XPadding*2;
    
  if( Mode == Modes.TIME_TRIAL || Mode == Modes.FREE )
    blockWidth = WindowWidth-(2*XPadding);
    
  fill( #000000 );
  stroke( #000000 );
  rect( x, y, blockWidth, 600 );
  
  switch(laneNr)
  {
    case 0:
      lane = LaneT;
      laps = LaneT.Laps;
      break;
    case 1:
      lane = Lane1; 
      laps = Lane1.Laps;
      break;
    case 2:
      lane = Lane2;
      laps = Lane2.Laps;
      break;
  }
  
  for(int i=0;i<laps.size();i++)
  {
    Lap lap = laps.get(i);
    boolean isBestLap = lap.LapNr == lane.BestLap.LapNr;
    PrintLapRow(laneNr, lap, isBestLap);
  }
}

void PrintLapRow( int lane, Lap lap, boolean bestLap )
{
  int blockWidth = WindowWidth/2-(XPadding*4);
  int x = LaneBlockOneX;
  int y = LaneBlockY+XPadding;//Add a little bit of space
  int rowHeight = 35;
  if( lane == 2 )
    x = WindowWidth/2+XPadding*2;
  
  if( Mode == Modes.TIME_TRIAL || Mode == Modes.FREE )
  {
    blockWidth = WindowWidth-(2*XPadding);
    //x = LaneBlockOneX;
  }
  
  y += lap.LapNr*rowHeight;  
  
  if(bestLap)
    fill( 0,255,0 );
  else
    fill( 0 );
    
  stroke( #000000 );
  rect( x, y-rowHeight/2, blockWidth, rowHeight );
  
  textAlign( LEFT );
  fill( 255 );
  String stri = "Lap ";
  if( lap.LapNr < 10 )
    stri += " ";
  stri += str( lap.LapNr ) +": ";
  textFont( createFont(BoldFont, 25 ) );
  y += 5;
  text( stri, x, y );
  //
  textFont( createFont("Courier New", 25 ) );
  textAlign( RIGHT );
  text( formatTime( lap.LapTime, true ), x+blockWidth, y );

  stroke(126);
  line( x, y+11, x+blockWidth, y+11 );
}

void PrintLaneLabel( int lane )
{
  textAlign( LEFT );
  textFont( createFont(BoldFont, 30 ) );
  int x = XPadding;
  if( lane == 2 )
    x = WindowWidth/2+XPadding*2;
    
  stroke( #000000 );
  fill( #000000 );
  rect( x, LaneBlockY-90, 472, 100 );
  fill( #ffffff );
  String str = "Lane "+str( lane );
  if( Mode == Modes.FREE )
    str = "Manual timing";
  else if( Mode == Modes.TIME_TRIAL )
    str = "Time trial";
  text( str, x, LaneBlockY );
}

void ClearBoard()
{
    fill( 0 );
    stroke( 0 );
    rect( 0, 140, WindowWidth, WindowHeight );
}

void PrintPortList()
{
  String consoleMsg = "Select com port\n";
  int portsCount = Serial.list().length;
  int asc = 65;
  for(int i=0;i<portsCount;i++)
  {
    asc += i;
    char c = char(asc);
    consoleMsg += c+": ";
    consoleMsg += Serial.list()[i]+"\n";
  }
  
  ConsoleBox( consoleMsg );
}

void ConsoleBox( String message )
{
  
  textAlign( LEFT );
  fill( 0 );
  stroke( #000000 );
  int boxWidth = 232;
  int y = XPadding;
  int x = WindowWidth-boxWidth-XPadding;
  rect( x, y, boxWidth, 100);
  
  if(message != "")
  {
    stroke( #ffffff );
    rect( x, y, boxWidth, 100);
    textFont( createFont("Courier New Lihavoitu", 16 ) );
    fill( 255 );
    text( message, x+10, y+10, 212, 180);
  }
}

void ShowWinner(int laneNr)
{
  Lane lane = Lane1;
  int x = LaneBlockOneX;
  if(laneNr == 2)
  {
    x = WindowWidth/2+XPadding*2;
    lane = Lane2;
  }
  
  int y = LaneBlockY+XPadding+lane.LapCount*35;
  int blockWidth = WindowWidth/2-(XPadding*4);
  x += blockWidth/4;
  int imageS = blockWidth/2;
  
  imageMode(CORNER);
  image( Flag, x, y, imageS, imageS );
}
