#include <Timer.h>
#include "ACKedTransmit.h"

configuration ACKedTransmitAppC{
}
implementation{
	
	components MainC;
	components ACKedTransmitC as app;
	
	components new TimerMilliC() as Timer0;
	components new TimerMilliC() as Timer1;
	
	components ActiveMessageC;
	components new AMSenderC(AM_ACKEDTRANSMIT);
	
	
	
	app.Boot -> MainC;
	
	app.Timer0 -> Timer0;
	app.Timer1 -> Timer1;
	
	app.AMControl -> ActiveMessageC;
	app.AMSend -> AMSenderC;
	app.Packet -> AMSenderC;
	app.AMPacket -> AMSenderC;
	
	app.PacketAck -> ActiveMessageC;
}
