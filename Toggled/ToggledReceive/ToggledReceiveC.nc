#include <Timer.h>
#include "ToggledReceive.h"

module ToggledReceiveC{
	
	uses interface Boot;
	uses interface Leds;
	uses interface Packet;
	uses interface AMPacket;
	uses interface Receive;
	uses interface SplitControl as AMControl;
	
}

implementation{
	
	message_t pkt;
	bool busy = FALSE;
	
	
	void setLeds(uint16_t val)
	{
		if (val & 0x01)
		    call Leds.led0On();
		else
		    call Leds.led0Off();
		if (val & 0x02)
		    call Leds.led1On();
		else
		    call Leds.led1Off();
		if (val & 0x04)
		    call Leds.led2On();
		else
		    call Leds.led2Off();
	}
	
	
	event void Boot.booted()
	{
		call AMControl.start();
	}
	
	event void AMControl.startDone(error_t err)
	{
		if (err != SUCCESS)
		{
			call AMControl.start();
		}
	}
	
	event void AMControl.stopDone(error_t err)
	{}
	
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		dbg("ToggledReceiveC", "Received packet of lenght %hhu @ %s with payload : %hhu \n", len, sim_time_string(), payload);
		
		if (len == sizeof(ToggledReceiveMsg))
		{
			ToggledReceiveMsg* trpkt = (ToggledReceiveMsg*)payload;
			setLeds(trpkt->counter);
		}
		
		return msg;
	}	
	
}
