#ifndef MESSAGE_SNIFFER_H
#define MESSAGE_SNIFFER_H

enum
{
	AM_BLINK = 6,
	TIMER_PERIOD_MILLI = 5240,	
	AM_SERIAL_MSG = 0x56
};

typedef nx_struct MessageSnifferMsg 
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;
	nx_uint16_t retransmission;
	nx_uint16_t acknowledged;
	nx_uint16_t movingaverage;
	nx_uint16_t battery;
	nx_uint32_t txtime;
	nx_uint32_t rxtime;
	nx_uint32_t processortime;
	nx_uint32_t energy;
} MessageSnifferMsg;

typedef nx_struct serial_msg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;	
	nx_uint16_t retransmission;
	nx_uint16_t acknowledged;
	nx_uint16_t movingaverage;
	nx_uint16_t battery;
	nx_uint32_t txtime;
	nx_uint32_t rxtime;
	nx_uint32_t processortime;
	nx_uint32_t energy;
} serial_msg_t;


#endif /* MESSAGE_SNIFFER_H */
