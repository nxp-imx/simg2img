TARGET = simg2img
LIBS = -lm -lz
#CC = gcc
TOOLS_DIR=/opt/poky/1.5_hw/sysroots/i686-pokysdk-linux/usr/bin/cortexa9hf-vfp-neon-poky-linux-gnueabi
CC=$(TOOLS_DIR)/arm-poky-linux-gnueabi-gcc  -march=armv7-a -mthumb-interwork -mfloat-abi=hard -mfpu=neon -mtune=cortex-a9 --sysroot=/opt/poky/1.5_hw/sysroots/cortexa9hf-vfp-neon-poky-linux-gnueabi
CFLAGS = -g -Wall

.PHONY: default all clean

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-rm -f *.o
	-rm -f $(TARGET)
