#include <Timer.h>
#include "EvenOdd.h"


configuration EvenOddAppC{
}
implementation{
	
	components MainC;
	components LedsC;
	components EvenOddC as App;
	components new TimerMilliC() as Timer0;
	components ActiveMessageC;
	components new AMSenderC(AM_EVENODD);
	components new AMReceiverC(AM_EVENODD);
	
	
	App.Boot -> MainC;
	App.Leds -> LedsC;
	App.Timer0 -> Timer0;
	App.Packet -> AMSenderC;
	App.AMPacket -> AMSenderC;
	App.AMControl -> ActiveMessageC;
	App.AMSend -> AMSenderC;
	App.Receive -> AMReceiverC;


}
