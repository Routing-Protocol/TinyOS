#include <Timer.h>
#include "MessageSniffer.h"

module MessageSnifferC{

  uses interface Boot;
  uses interface Leds;
  
  uses interface SplitControl as RadioControl;
  uses interface Receive as RadioSnoop[am_id_t id];
  uses interface Timer<TMilli> as Timer1;
     
  uses interface SplitControl as SerialControl;
  uses interface AMSend;
  uses interface Packet;
  uses interface AMPacket;
}
implementation{
	
	message_t packet;
	bool busy = FALSE;
	bool locked = FALSE;
	
	uint16_t counter;
	//uint16_t temp;
	
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
		call SerialControl.start();
	}
	
	event void SerialControl.startDone(error_t error)
	{
		if (error ==SUCCESS)
		{
			call RadioControl.start();
		}
		else
		{
			call SerialControl.start();
		}
	}
	
	event void RadioControl.startDone(error_t error)
	{
		if (error == SUCCESS)
		{
			call Timer1.startPeriodic(TIMER_PERIOD_MILLI);
		}
	    else 
	    {
	    	call RadioControl.start();
	    }
	 }
	 
	 event void RadioControl.stopDone(error_t err)
	 {}
	 
	 event void SerialControl.stopDone(error_t err)
	 {}
	 
	 event void Timer1.fired()
	 {}
	 
	 event message_t* RadioSnoop.receive[am_id_t id](message_t* msg, void* payload, uint8_t len)
	 {
	 	dbg("MessageSnifferC", "Received packet of length %hhu   @ %s. Payload : %hhu \n", len, sim_time_string(), payload);
	 
	    
	    
	    if (call AMPacket.isForMe(msg) == TRUE)
	    {
	    	if (len == sizeof(MessageSnifferMsg))
	    	{
	    		MessageSnifferMsg* mspkt = (MessageSnifferMsg*)payload;
	    		setLeds(mspkt->counter);
	    		
	    		if (locked)
	    		{
	    			return msg;
	    		}
	    		else
	    		{
	    			serial_msg_t* rcm = (serial_msg_t*)call Packet.getPayload(&packet, sizeof(serial_msg_t));
	    			if (rcm == NULL)
	    			{
	    				return msg;
	    			}
	    			
	    			if (call Packet.maxPayloadLength() < sizeof(serial_msg_t))
	    			{
	    				return msg;
	    			}
	    			
	    		//	temp = rcm->movingaverage;
	    				    			
	    			rcm->counter = mspkt->counter;
	    			rcm->nodeid = mspkt->nodeid;
	    			rcm->lostpackets = mspkt->lostpackets;
	    			rcm->retransmission = mspkt->retransmission;
	    			rcm->acknowledged = mspkt->acknowledged;
	    			rcm->movingaverage = mspkt->movingaverage;
	    			rcm->txtime = mspkt->txtime;
	    			rcm->rxtime = mspkt->rxtime;
	    			rcm->processortime = mspkt->processortime;
	    			rcm->energy = mspkt->energy;
	    		}
	    		
	    		if (call AMSend.send (0x00, &packet, sizeof(serial_msg_t)) == SUCCESS)
	    		{
	    			locked = TRUE;
	    		}
	    		
	    		return msg;
	    	}	    	
	    }
	    
	    else 
	    {
	    	setLeds(0x05);
	    }
	    
	    return msg;
	    
	}
	
	event void AMSend.sendDone(message_t* buffer, error_t err)
	{
		if (&packet == buffer)
		{
			locked = FALSE;
		}
	}	
	
}
	
	
	
	
	
	
	
	
	
	
