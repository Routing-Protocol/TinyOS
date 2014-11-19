#include <Timer.h>
#include "ToggledReceive.h"


configuration ToggledReceiveAppC{
}
implementation{
	
	components MainC;
	components LedsC;
	components ToggledReceiveC as App;
	
	components ActiveMessageC;
	components new AMReceiverC(AM_TOGGLEDRECEIVE);
	
	
	App.Boot -> MainC;
	App.Leds -> LedsC;
	App.AMControl -> ActiveMessageC;
	App.Receive -> AMReceiverC;
	
}
