
#include <stdio.h>
#include <stdint.h>
#include <pthread.h>
#include "control.h"

void testCase(void);

int main(int argc, char *argv[]) {

	testCase();
 
	return 1;
}

void testCase(void) {
	uint8_t display_packet[9] = {0x1, 0x34, 0x05, 0x0, 0x48, 0x65, 0x6c, 0x6c, 0x6f};
	uint8_t motor_packet[12] = {0x2, 0x80, 0x08, 0x0, 0x0, 0x0, 0x80, 0x3f, 0x0, 0x0, 0x0, 0xbf};

	printf("-----RUNNING TEST CASE-----\n");
	for(int i=0; i<=8; i++) {
		if(i==0) printf("display_packet = \t{");
		printf("0x%02hhX", display_packet[i]);
		if(i<8) printf(",");
		else printf("}\n");
	}
	parser(display_packet);
	

	for(int i=0; i<=11; i++) {
		if(i==0) printf("motor_packet = \t\t{");
		printf("0x%02hhX", motor_packet[i]);
		if(i<11) printf(",");
		else printf("}\n");
	}
	parser(motor_packet);
}