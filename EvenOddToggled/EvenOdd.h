#ifndef EVEN_ODD_TOGGLED_H
#define EVEN_ODD_TOGGLED_H

enum 
{
	AM_EVENODDTOGGLED = 6,
	TIMER_PERIOD_MILLI = 250,
	TIMER_PERIOD_MILLI_NEW = 5240
};

typedef nx_struct EvenOddToggledMsg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;	
} EvenOddToggledMsg;

#endif /* EVEN_ODD_TOGGLED_H */
