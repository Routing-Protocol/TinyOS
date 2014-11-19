This application receives and displays a binary count on the leds of the mote. The 'SnifferSerial' java application run in the terminal window displays the count of each mote along with the number of packets lost by the respective mote.

This applciation works with a receiving application, 'MessageReceive' and a trasnmitting application like 'ACKedTransmit', 'TimerAcked' or 'TransmitTimer'. This node needs to run on a mote serially connected to the computer so that it can sense all the packets being trasnmitted in its range adn send the data to the computer to be displayed.

The expected result when using this application is the display of the count and the number of unacknowledged packets from all the transmissions which don't have this node as the destination.

08/14/2014 - First upload of the application which includes the header, module, configuration and makefile.

11/18/2014 - MessageSniffer moved into Acked3Toggled in repository - TinyOS
