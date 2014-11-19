#include <Timer.h>
#include "TimerAcked.h"


configuration TimerAckedAppC{
}
implementation{
	
	components MainC;
	components TimerAckedC as App;
	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	components ActiveMessageC;
	components new AMSenderC(AM_TIMERACKED);
	
	
	App.Boot -> MainC;
	App.Timer0 -> Timer0;
	App.Timer1 -> Timer1;
	App.Packet -> AMSenderC;
	App.AMPacket -> AMSenderC;
	App.AMControl -> ActiveMessageC;
	App.AMSend -> AMSenderC;
	App.PacketAck -> ActiveMessageC;
	
}
