#include <Timer.h>
#include "ACKedTransmit.h"


module ACKedTransmitC{
	
	uses interface Boot;
	
	uses interface Timer<TMilli> as Timer0;
	uses interface Timer<TMilli> as Timer1;

		
	uses interface SplitControl as AMControl;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	
	uses interface PacketAcknowledgements as PacketAck;
	
}
implementation{
	
	uint16_t counter;
	uint16_t LostPackets;
	uint8_t retx;
	
	message_t pkt;
	
	bool BUSY = FALSE;
	bool ACKed = TRUE;
	
	uint8_t node1 = 0x03;
	uint8_t node2 = 0x04;
	uint8_t node3 = 0x99; 
	


	event void Boot.booted()
	{
		call AMControl.start();
	}
	
	event void AMControl.startDone(error_t err)
	{
		if (err == SUCCESS)
		{
			call Timer1.startPeriodic(TIMER_PERIODIC_MILLI_1);
			
			call Timer0.startPeriodic(TIMER_PERIODIC_MILLI_0);
		
		}
		
		else 
		{
			call AMControl.start();
		}
	}
	
	event void AMControl.stopDone(error_t err)
	{
		call AMControl.start();	   	
	}
	
	
	event void Timer1.fired()
	{
		node3 = node2;
		node2 = node1;
		node1 = node3;
	}
	
	task void SendMsg()
	{
		ACKedTransmitMsg* ACKpkt = (ACKedTransmitMsg*)(call Packet.getPayload(&pkt, sizeof(ACKedTransmitMsg)));
		if (ACKpkt == NULL)
		{
			return;
		}
		
		ACKpkt->nodeid = TOS_NODE_ID;
		ACKpkt->counter = counter;
		ACKpkt->lostpackets = LostPackets;
		
		if (ACKpkt->counter%0x02 == 0)
		{
			call PacketAck.requestAck(&pkt);
			if (call AMSend.send(node1, &pkt, sizeof(ACKedTransmitMsg)) == SUCCESS)      //node1
			{
				BUSY = TRUE;
			}
		}
		
		else 
		{
			call PacketAck.requestAck(&pkt);
			if (call AMSend.send(node2, &pkt, sizeof(ACKedTransmitMsg)) == SUCCESS)      //node2
			{
				BUSY = TRUE;
			}
		}				
	}
	
	event void Timer0.fired()
	{
		if (ACKed == TRUE)
		{
			counter++;
		}
		
		if (!BUSY || retx < 8)
		{
			post SendMsg();
		}
	}
	
	
		
	event void AMSend.sendDone(message_t* msg, error_t err)
	{
		if (&pkt == msg)
		{
			BUSY = FALSE;
			dbg("ACKedTransmitC", "Message sent @ %s, \n", sim_time_string());
		}
		
		
		
		if (call PacketAck.wasAcked(msg))
		{
			retx = 0;
			ACKed = TRUE;
			call AMControl.start();
		}
		
		else 
		{
			retx++;
			LostPackets++;
			ACKed = FALSE;
			
			if (retx < 8)
			{
				post SendMsg();
			}			
			else 
			{
				call AMControl.start();
			}	
		}
		
	}	
}
