void HandleCountdown(int phase)
{
  int middleX = WindowWidth/2;
  int leftX = middleX -280 -20;
  int rightX = middleX + 280 + 20;
  int y = WindowHeight/2;
  
  
  if(phase==0)
  {
    ClearBoard();
    GreenCircle(leftX, y);
    GreenCircle(middleX, y);
    GreenCircle(rightX, y);
    //StartTiming();//Arduino should call this
    PlayNote(PitchHigh);
    delayd(350);
    OffNote(PitchHigh);
    CountdownDone = true;
  }
  else if(phase == 4)
  {
    CountdownStartedAt = frameCount;
    ClearBoard();
  }
  else if(phase == 3)
  {
    RedCircle(leftX, y);
    PlayNote(Pitch);
    delayd(350);
    OffNote(Pitch);
  }
  else if(phase == 2)
  {
    RedCircle(middleX, y);
    PlayNote(Pitch);
    delayd(350);
    OffNote(Pitch);
  }
  else if(phase == 1)
  {
    RedCircle(rightX, y);
    PlayNote(Pitch);
    delayd(350);
    OffNote(Pitch);
  }  
}

void RedCircle( int x, int y )
{
  fill( 255, 26, 0 );
  circle(x, y, 280);
}
void GreenCircle( int x, int y )
{
  fill( 0, 255, 0 );
  circle(x, y, 280);
}
