#include <Timer.h>
#include "EvenOddToggled.h"


configuration EvenOddToggledAppC{
}
implementation{
	
	components MainC;
	components LedsC;
	components EvenOddToggledC as App;
	
	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	
	components ActiveMessageC;
	components new AMSenderC(AM_EVENODDTOGGLED);
	components new AMReceiverC(AM_EVENODDTOGGLED);
	
	
	App.Boot -> MainC;
	App.Leds -> LedsC;
	App.Timer0 -> Timer0;
	App.Timer1 -> Timer1;
	App.Packet -> AMSenderC;
	App.AMPacket -> AMSenderC;
	App.AMControl -> ActiveMessageC;
	App.AMSend -> AMSenderC;
	App.Receive -> AMReceiverC;
	
}
