
int numberOfHundreths( int time )
{
  int MILLIS_PER_SEC = 1000;
  return ceil(( time % MILLIS_PER_SEC )/10);
}
int numberOfMillis( int time )
{
  int MILLIS_PER_SEC = 1000;
  return ( time % MILLIS_PER_SEC );
}

int numberOfSeconds( int time )
{
  int MILLIS_PER_SEC = 1000;
  return ( ( time / MILLIS_PER_SEC ) % 60 );
}
int numberOfMinutes( int time ) 
{
  int MILLIS_PER_SEC = 1000;
  int MILLIS_PER_MIN = 60000;
  return ( ( ( time / MILLIS_PER_MIN) % MILLIS_PER_SEC ) % 60 );
}
int numberOfHours( int time ) 
{
  int MILLIS_PER_MIN = 60000;
  int MILLIS_PER_HOUR = 3600000;
  return (( time / MILLIS_PER_HOUR) % MILLIS_PER_MIN);
}
