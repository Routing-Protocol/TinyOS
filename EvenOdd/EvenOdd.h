#ifndef EVEN_ODD_H
#define EVEN_ODD_H


enum
{
	AM_EVENODD = 6,
	TIMER_PERIOD_MILLI = 5000
};

typedef nx_struct EvenOddMsg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
} EvenOddMsg;

#endif /* EVEN_ODD_H */
