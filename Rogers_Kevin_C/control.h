
#include <stdio.h>
#include <stdint.h>

#define DISPLAY_MESSAGE_ID		0x34		//PACKET_ID for Display Message
#define MOTOR_MESSAGE_ID		0x80		//PACKET_ID for Motor Message

static struct packet MESSAGE;				//Static Message packet
static struct motor COMMAND;				//Static Motor packet
static uint8_t buffer[0xFFFF];				//Static buffer to hold MESSAGE_DATA

struct packet {
	uint8_t 	PACKET_ID;					//Byte holding Message ID
	uint8_t 	MESSAGE_TYPE;				//Byte holding type of Message
	uint16_t 	MESSAGE_LENGTH;				//2 Byte holding MESSAGE_DATA length
	uint8_t*	MESSAGE_DATA;				//Byte array of Message data
};

struct motor {
	uint32_t		FORWARD_BACK;				//4 byte motor message from MESSAGE_DATA 0-3
	uint32_t		LEFT_RIGHT;					//4 byte motor message from MESSAGE_DATA 4-7
};

void* parser(uint8_t* msgIN);											//Takes in Byte array and parses data
void logger(int flag);													//Logs Data Message from parser()
void display_message(char* data);										//Function to handle Motor Message
void update_motor(float forward_back, float left_right);				//Function to handle Display Message
