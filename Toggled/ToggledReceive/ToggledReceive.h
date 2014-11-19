#ifndef TOGGLED_RECEIVE_H
#define TOGGLED_RECEIVE_H


enum
{
	AM_TOGGLEDRECEIVE = 6
};

typedef nx_struct ToggledReceiveMsg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
} ToggledReceiveMsg;

#endif /* TOGGLED_RECEIVE_H */
