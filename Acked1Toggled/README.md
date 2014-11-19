This application periodically toggles between sending even and odd binary digits to two nodes and also counts the number of acknowledgements received from the receiving nodes.

Four nodes may be used to verify the working of this application. This is a transmitting application which can be installeed on one of the nodes leaving atleast one other node to run the 'MessageSniffer' application and installing the remaining ones with 'MessageReceiver'. The receiving nodes are to be named node 3 and node 4. The node installed with 'MessageSniffer' is to be connected to the computer so that it can sense the packets being transmitted in the network and send network data serially to the computer. The count of the transmitting nodes along with the number of lost packets will be shown by running the 'SnifferSerial' application in th terminal window.

This application moves on to the next count only if the acknolwedgement from the last transmission is received.

11/18/2014 - Created of Acked1Toggled in TinyOS repository
             Moved TimerAcked, MessageReceiver and MessageSniffer
