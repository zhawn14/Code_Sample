
CC=gcc
CFLAGS=-I.
DEPS = control.h
LIB = 

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

main: main.o control.o
	$(CC) -o main main.o control.o $(LIB) --no-warnings