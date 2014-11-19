#include <Timer.h>
#include "EvenOddToggled.h"


module EvenOddToggledC{
	
	uses interface Boot;
	uses interface Leds;
	uses interface Timer<TMilli> as Timer0;
	uses interface Timer<TMilli> as Timer1;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface Receive;
	uses interface SplitControl as AMControl;
	
}


implementation{
	
	uint16_t counter;
	uint16_t new_counter;
	
	message_t pkt;
	bool busy = FALSE;
	
	uint8_t node1 = 0x03;
	uint8_t node2 = 0x04;
	uint8_t node3 = 0x99;
	
	
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
			call Timer1.startPeriodic(TIMER_PERIOD_MILLI_NEW);
			call Timer0.startPeriodic(TIMER_PERIOD_MILLI);
		}	
		else 
		{
			call AMControl.start();
		}
	}
	
	event void AMControl.stopDone(error_t err)
	{}
	
	event void Timer1.fired()
	{
		node3 = node2;
		node2 = node1;
		node1 = node3;
	}
	
	event void Timer0.fired()
	{
		counter++;
		
		if (!busy)
		{
			EvenOddToggledMsg* eotpkt = (EvenOddToggledMsg*)(call Packet.getPayload(&pkt, sizeof(EvenOddToggledMsg)));
			
			if (eotpkt == NULL)
			{
				return;
			}
			
			eotpkt->nodeid = TOS_NODE_ID;
			eotpkt->counter = counter;
			
			if (eotpkt->counter % 0x02 == 0)
			{
				if (call AMSend.send(node1,&pkt,sizeof(EvenOddToggledMsg)) == SUCCESS)
				{
					busy = TRUE;					
				}
			}
			
			else
			{
				if (call AMSend.send(node2,&pkt,sizeof(EvenOddToggledMsg)) == SUCCESS)
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
			dbg("EvenOddToggledC", "Message was sent @ %s, \n", sim_time_string());
		}
	}
	
	event message_t* Receive.receive(message_t* msg, void* payload, uint8_t len)
	{
		dbg("EvenOddToggledC", "Received message of length %hhu @ %s with the Payload : %hhu", len, sim_time_string(), payload);
		
		if (len == sizeof(EvenOddToggledMsg))
		{
			EvenOddToggledMsg* eotpkt = (EvenOddToggledMsg*)payload;
			setLeds(eotpkt->counter);
		}
		
		return msg;
	}
	
}
