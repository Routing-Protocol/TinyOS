This application periodically toggles between sending even and odd binary digits to two nodes and also counts the number of acknowledgements received from the receiving nodes.

Four nodes maybe used to verify the working of this application. This is a transmitting application which may be installed on one node while atleast one of the other three are to be installed with the application 'MessageSniffer' and installing the application 'MessageReceiver' on the others. The receiving nodes are to be named node 3 and node 4. The node installed with 'MessageSniffer' is to be connected to the computer so that it can sense the packets being transmitted and send information serially to the computer.

The expected result is the nodes named 3 and 4 receive a count periodically toggled between even and odd binary digits which is displayed on their respective leds. The number of lost packets is kept in each transmitting node and sent in the packet along with the binary count which can be found out by the 'Sniffer node' connected serially to the computer which also gives the binary count being transmitted by running the 'SnifferSerial'java application in the terminal window.

This application tries to retransmit a packet 8 times before moving on to the next count.

11/18/2014 - Created Acked2Toggled folder in TinyOS repository
             Moved applications ACKedTransmit, MessageReceiver and MessageSniffer in Acked2Toggled
             
