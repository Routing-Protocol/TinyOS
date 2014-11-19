#ifndef MESSAGE_SNIFFER_H
#define MESSAGE_SNIFFER_H

enum
{
	AM_BLINK = 6,
	TIMER_PERIOD_MILLI = 5240,	
	AM_SERIAL = 0x56
};


typedef nx_struct MessageSnifferMsg 
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;
} MessageSnifferMsg;

typedef nx_struct serial_msg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;	
} serial_msg_t;


#endif /* MESSAGE_SNIFFER_H */
