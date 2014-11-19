#include <Timer.h>
#include "TimerAcked.h"


module TimerAckedC{
	
	uses interface Boot;
	uses interface Timer<TMilli> as Timer0;
	uses interface Timer<TMilli> as Timer1;
	uses interface Packet;
	uses interface AMPacket;
	uses interface AMSend;
	uses interface SplitControl as AMControl;
	uses interface PacketAcknowledgements as PacketAck;
	
}

implementation{
	
	uint16_t counter;
	uint16_t new_counter;
	uint16_t LostPackets = 0;
	
	message_t pkt;
	
	bool busy = FALSE;
	bool COUNTER = TRUE;
	
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
	
	task void SendMsg()
	{
		TimerAckedMsg* tapkt = (TimerAckedMsg*)(call Packet.getPayload(&pkt, sizeof(TimerAckedMsg)));
		
		if (tapkt == NULL)
		{
			return;
		}
		
		tapkt->nodeid = TOS_NODE_ID;
		tapkt->counter = counter;
		tapkt->lostpackets = LostPackets;
		
		if (tapkt->counter % 0x02 ==0)
		{
			call PacketAck.requestAck(&pkt);
			if (call AMSend.send(node1, &pkt, sizeof(TimerAckedMsg)) == SUCCESS)
			{
				busy = TRUE;
			}
		}
		
		else
		{
			call PacketAck.requestAck(&pkt);
			if (call AMSend.send(node2, &pkt, sizeof(TimerAckedMsg)) == SUCCESS)
			{
				busy = TRUE;
			}
		}
	}
	
	event void Timer0.fired()
	{
		if (COUNTER == TRUE)
		{
			counter++;
		}
		
		if (!busy)
		{
			post SendMsg();
		}
	}
	
	event void AMSend.sendDone(message_t* msg, error_t err)
	{
		if (&pkt == msg)
		{
			busy = FALSE;
			dbg("TimerAckedC", "message was sent @ %s, \n", sim_time_string());
		}
		
		if (call PacketAck.wasAcked(msg))
		{
			COUNTER =TRUE;
			call AMControl.start();
		}	
		else
		{
			LostPackets++;
			COUNTER = FALSE;
			post SendMsg();
		}
	}	
	
}
