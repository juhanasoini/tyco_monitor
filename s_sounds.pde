void PlayInit()
{
  PlayerStop();
  Player = Minim.loadFile("sounds/start-revving.mp3");
  Player.cue( 0 );
  Player.play();
}
void PlayStart()
{
  Player = Minim.loadFile("sounds/startende_race_autos.mp3");
  Player.cue( 1995 );
  Player.play();
}

void PlayEnd()
{
  PlayerStop();
  Player = Minim.loadFile("sounds/finished.mp3");
  Player.cue( 0 );
  Player.play();
}

void PlayByPass()
{
  PlayerStop();
  Player = Minim.loadFile("sounds/Doppler-4.wav");
  Player.cue( 0 );
  Player.play();
}
void PlaySuperFin()
{
  PlayerStop();
  Player = Minim.loadFile("sounds/Top-Gun.mp3");
  Player.cue( 12000 );
  Player.play();
}

void PlayerStop()
{
  if (Player != null && Player.isPlaying() )
  {
    Player.pause();
  }
}

void PlayNote(int Pitch)
{  
    MBus.sendNoteOn(0, Pitch, 127); 
}

void OffNote(int Pitch)
{
    MBus.sendNoteOff(0, Pitch, 127);
}

void PlayNote(int Pitch, int channel, int velocity)
{  
    MBus.sendNoteOn(channel, Pitch, velocity);
}
