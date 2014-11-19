#include <Timer.h>
#include "EvenOdd.h"


module EvenOddC{
	
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface Receive;
	uses interface SplitControl as AMControl;
	
}

implementation{
	
	uint8_t node1 = 4;
	uint8_t node2 = 3;
	
	uint16_t counter;
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
		if (err == SUCCESS)
		{
			call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
		}
		else 
		{
			call AMControl.start();
		}
	}
	
	event void AMControl.stopDone(error_t err)
	{}
	
	event void Timer0.fired()
	{
		counter++;
		
		if (!busy)
		{
			EvenOddMsg* eopkt = (EvenOddMsg*)(call Packet.getPayload(&pkt, sizeof(EvenOddMsg)));
			
			if (eopkt == NULL)
			{
				return;
			}
			
			eopkt->nodeid = TOS_NODE_ID;
			eopkt->counter = counter;
			
			if (eopkt->counter % 2 == 0)
			{
				if (call AMSend.send(node1, &pkt, sizeof(EvenOddMsg)) == SUCCESS)
				{
					busy = TRUE;
				}
			}
			else
			{
				if (call AMSend.send(node2, &pkt, sizeof(EvenOddMsg)) == SUCCESS)
				{
					busy = TRUE;
				}
			}
		}
	}
	
	event void AMSend.sendDone(message_t* msg, error_t err)
	{
		if (&pkt == msg)
		{
			busy = FALSE;
			dbg("EvenOddC", "Message was sent @ %s, \n", sim_time_string());
		}
	}
	
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		dbg("EvenOddC", "Received packet was of length %hhu, received @ %s.    Payload : %hhu \n", len, sim_time_string(), payload);
		
		if (len == sizeof(EvenOddMsg))
		{
			EvenOddMsg* eopkt = ( EvenOddMsg*)payload;
			
			setLeds(eopkt->counter);
			
			return msg;
		}
	}
	
}
