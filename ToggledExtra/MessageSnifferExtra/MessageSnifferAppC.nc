#include <Timer.h>
#include "MessageSniffer.h"


configuration MessageSnifferAppC{
}
implementation{

  components MainC;
  components LedsC;
  components MessageSnifferC as app;
  
  components ActiveMessageC as AMRadio;
  components new AMReceiverC(AM_BLINK);
  components new TimerMilliC()as Timer1;
  
  components SerialActiveMessageC as AMSerial;
  
  
  
  app.Boot -> MainC;
  app.Leds -> LedsC;
  
  app.RadioControl -> AMRadio;
  app.RadioSnoop -> AMRadio.Snoop;
  app.Timer1 -> Timer1;
  
  app.SerialControl -> AMSerial;
  app.AMSend -> AMSerial.AMSend[AM_SERIAL_MSG];
  app.Packet -> AMSerial;
  app.AMPacket -> AMSerial;
  
   
}
