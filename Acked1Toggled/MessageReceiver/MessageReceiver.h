#ifndef MESSAGE_RECEIVER_H
#define MESSAGE_RECEIVER_H

enum
{
	AM_MESSAGERECEIVER = 6
};

typedef nx_struct MessageReceiverMsg
{
	nx_uint16_t nodeid;
	nx_uint16_t counter;
	nx_uint16_t lostpackets;	
} MessageReceiverMsg;

#endif /* MESSAGE_RECEIVER_H */
