COMPONENT=MessageSnifferAppC

CFLAGS += -DTOSH_DATA_LENGTH=50

BUILD_EXTRA_DEPS += SnifferSerial.class
CLEAN_EXTRA = *.class SnifferSerialMsg.java

CFLAGS += -I$(TOSDIR)/lib/T2Hack

SnifferSerial.class: $(wildcard *.java) SnifferSerialMsg.java
	javac -target 1.4 -source 1.4 *.java

SnifferSerialMsg.java:
	mig java -target=null $(CFLAGS) -java-classname=SnifferSerialMsg MessageSniffer.h serial_msg -o $@

include $(MAKERULES)

