
int WindowWidth = 1324;
int WindowHeight = 768;
int XPadding = 20;
boolean TimingStarted;
int TimingDuration;
int TimingStartTime;

int FreeTimingLapCount;
int PreviousFreeTimingLapTimed;

boolean CountdownDone;
boolean CountdownStarted;
boolean CountdownCleared;
int CountDownPhase;
int CountdownStartedAt;

int Pitch = 64;
int PitchHigh = 100;

PImage Flag;

Serial SerialPort;
boolean BTConnected = false;

enum Modes {
  NONE,
  TIME_TRIAL,
  RACE,
  RACE_COUNTDOWN,
  FREE
}
Modes Mode;

Lane LaneT;
Lane Lane1;
Lane Lane2;

int LaneBlockY = 400;
int LaneBlockOneX = XPadding;
int LaneBlockTwoX = 552;
int LaneBlockWidth = 472;

PShape logo;
String Font = "Courier New";
String BoldFont = "Courier New Lihavoitu";

MidiBus MBus; // The MidiBus
Minim Minim;
AudioPlayer Player;
