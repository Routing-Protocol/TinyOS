#include <Timer.h>
#include "MessageReceiver.h"


configuration MessageReceiverAppC{
}
implementation{
	
	components MainC;
	components LedsC;
	components MessageReceiverC as App;
	
	components ActiveMessageC;
	components new AMReceiverC(AM_MESSAGERECEIVER);
	
	
	
	App.Boot -> MainC;
	App.Leds -> LedsC;
	App.AMControl -> ActiveMessageC;
	App.Receive -> AMReceiverC;	
	
}
