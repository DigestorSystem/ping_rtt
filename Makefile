CC      = /usr/bin/gcc
CFLAGS  = -Wall -g

OBJ = datei1.o datei2.o datei3.o datei4.o datei5.o

all: nc 

nc: 
	$(CC) $(CFLAGS) -o prog $(OBJ) $(LDFLAGS)

%.o: %.c
        $(CC) $(CFLAGS) -c $<