import processing.serial.*;
import ddf.minim.*;
import themidibus.*;
void setup() 
{
  //fullScreen();
  size(1324, 768);
  WindowWidth = width;
  WindowHeight = height;
  
  Flag = loadImage("images/checkered-flag-white.png");
  
  Minim = new Minim(this);
  MBus = new MidiBus(this, -1, 1);
  PlayInit();
  
  LaneT = new Lane(0);
  Lane1 = new Lane(1);
  Lane2 = new Lane(2);
  WindowSetup(true);
  Reset(Modes.FREE, true);
  PrintClock( 0 );
  PrintPortList();
}
