#include "fat16.h"
/*
void fat16_print_file_name(const char* const string) {
	unsigned char i;
	char c;
	
	for (i=0; i<8; i++) {
		c = string[i];
		if (c == ' ') break;
		putc(c);
	}
	putc('.');
	
	for (i=8; i<11; i++) {
		c = string[i];
		if (c == ' ') break;
		putc(c);
	}
}
*/
unsigned char fat16_compare_file_name(const char* const name1) {
	static const char* const name2 = "KERNEL  BIN";
	unsigned char i;
	for (i=0; i<11; i++) {
		if (name1[i] != name2[i]) {
			return FALSE;
		}
	}
	return TRUE;
}

