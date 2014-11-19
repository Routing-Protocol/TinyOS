This application receives and displays a binary count on the leds as long as the packet is not destined for the mote. The 'SnifferSerial' java application run in the terminal window displays the sequence number of the packet along with network information like the number of packets lost, number of retransmissions for each packet, the number of packets acknowledged, the moving average of the retransmission attempts and the packet reception rate(PRR).

This application can act the receiver and the sniffer along with the transmitting application 'TransmitTimerExtra'. When this application is used as the receiver, the leds don't light up when a packet is meant for that mote. When this applicaiton is used as a sniffer, the mote running this applicaiton needs to be connected serially to the computer so that all the captured packets can be used by the java application.

The expected result when using this application as a sniffer is the display of the count on the leds of the mote along witht the display of network information like the number of packets lost, number of retransmissions for each packet, the number of pakcets acknowledged, the moving average of the retransmission attempts and the packet reception rate(PRR) in the terminal window.

08/14/2014 - First upload of the application which also includes the header, module, configuration and makefile.

11/18/2014 - Moved into ToggledExtra folder in repository TinyOS
