#ifndef TIMER_ACKED_H
#define TIMER_ACKED_H


enum
{
	AM_TIMERACKED = 6,
	TIMER_PERIOD_MILLI = 2048,
	TIMER_PERIOD_MILLI_NEW = 5240
};

typedef nx_struct TimerAckedMsg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;
} TimerAckedMsg;

#endif /* TIMER_ACKED_H */
