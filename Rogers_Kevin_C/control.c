
#include <stdio.h>
#include <control.h>


/*
 * Function:	parser
 * -----------------------------------------------
 * Summary:
 *		Takes a message and parses its type, loads
 *			into 'buffer' or Motor Commands, and
 *			passes into appropriate function.
 * 
 * @return:
 *		void* to be used with pthread_create to
 *			have parser run int searate thread
 * 
 * @PARAMS:
 *		msgIN = uint8_t array message passed in
 *
*/
void* parser(uint8_t* msgIN) {
	int END_OF_DATA = -1;				//equals MESSAGE_LENGTH
	int flag = -1;						//set by MESSAGE_TYPE; 0 = MOTOR, 1 = DISPLAY
	float *cmdFront_Back;				//float to recast uint32_t FORWARD_BACK
	float *cmdLeft_Right;				//float to recast uint32_t LEFT_RIGHT

	//get packet_id
	MESSAGE.PACKET_ID = msgIN[0];

	//get message_type
	MESSAGE.MESSAGE_TYPE = msgIN[1];

	//get message_length
	MESSAGE.MESSAGE_LENGTH = msgIN[3];
	MESSAGE.MESSAGE_LENGTH = (MESSAGE.MESSAGE_LENGTH << 8) + msgIN[2];
	END_OF_DATA = MESSAGE.MESSAGE_LENGTH;

	//set message data pointer
	MESSAGE.MESSAGE_DATA = &(buffer[0]);	

	//determine message type
	switch(MESSAGE.MESSAGE_TYPE) {
		case DISPLAY_MESSAGE_ID:

			//load data into buffer
			for(int i=0; i < END_OF_DATA; i++) {
				//unaffected by Endianness at chars
				buffer[i] = (char) msgIN[i + 4];
			}

			//null terminate ASCII string
			buffer[END_OF_DATA] = '\0';

			logger(1);
			display_message(buffer);
			break;
		case MOTOR_MESSAGE_ID:

			//load data into commands; account for Endianness
			COMMAND.FORWARD_BACK = msgIN[7] << 24;
			COMMAND.FORWARD_BACK += msgIN[6] << 16;
			COMMAND.FORWARD_BACK += msgIN[5] << 8;
			COMMAND.FORWARD_BACK += msgIN[4];

			COMMAND.LEFT_RIGHT = msgIN[11] << 24;
			COMMAND.LEFT_RIGHT += msgIN[10] << 16;
			COMMAND.LEFT_RIGHT += msgIN[9] << 8;
			COMMAND.LEFT_RIGHT += msgIN[8];

			//Recast to float type
			cmdFront_Back = &COMMAND.FORWARD_BACK;
			cmdLeft_Right = &COMMAND.LEFT_RIGHT;
			
			logger(0);
			update_motor(*cmdFront_Back, *cmdLeft_Right);
			break;
		default:
			printf("ERROR: Message ID not recognized\n");
			break;
	}

}

/*
 * Function:	logger
 * -----------------------------------------------
 * Summary:
 *		Prints out parsed Data Message to console
 * 
 * @return:
 *		void
 * 
 * @PARAMS:
 *		flag = to print out Display or Motor Message
 *
*/
void logger(int flag) {
	float *temp = &(COMMAND.FORWARD_BACK);
	float *temp2 = &(COMMAND.LEFT_RIGHT);

	if(flag == 1) 	printf("buffer = %s\n", MESSAGE.MESSAGE_DATA);
	else			printf("forward_back = %f\t\tleft_right = %f\n", *temp, *temp2);
	printf("packet id = 0x%02hhX\n", MESSAGE.PACKET_ID);
	printf("message type = 0x%02hhX\n", MESSAGE.MESSAGE_TYPE);
	printf("message length = 0x%04X\n\n", MESSAGE.MESSAGE_LENGTH);
}

/*
 * Function:	update_motor
 * -----------------------------------------------
 * Summary:
 *		Shell of function; confirms message type
 * 
 * @return:
 *		void
 * 
 * @PARAMS:
 *		forward_back = float command
 *		lef_right = float command
 *
*/
void update_motor(float forward_back, float left_right) {
	printf("MOTOR MESSAGE\n");
}

/*
 * Function:	display_message
 * -----------------------------------------------
 * Summary:
 *		Shell of function; confirms message type
 * 
 * @return:
 *		void
 * 
 * @PARAMS:
 *		data = char* pointer to buffer
 *
*/
void display_message(char* data) {
	printf("DISPLAY MESSAGE\n");
}