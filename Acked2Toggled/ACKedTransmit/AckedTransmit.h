#ifndef ACKED_TRANSMIT_H
#define ACKED_TRANSMIT_H


enum
{
	AM_ACKEDTRANSMIT = 6,
	TIMER_PERIODIC_MILLI_0 = 2048,
	TIMER_PERIODIC_MILLI_1 = 5240,
	TIMER_PERIODIC_MILLI_2 = 314
};

typedef nx_struct ACKedTrasnmitMsg 
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;
}ACKedTransmitMsg;

#endif /* ACKED_TRANSMIT_H */
