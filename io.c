#include "io.h"
/*
volatile unsigned char CHAR_AVAILABLE = FALSE;
volatile unsigned char CHAR_RECEIVED;
*/
void putc(unsigned char c) {
	USART_PORT = c;
}
/*
unsigned char getc() {
	while(CHAR_AVAILABLE == FALSE);
	CHAR_AVAILABLE = FALSE;
	return CHAR_RECEIVED;
}
*/
void print(unsigned char* string) {
	do {
		USART_PORT = *string;
		string++;
	} while (*string != 0);
}
/*
void print_hex(unsigned char hex) {
	unsigned char tmp = (hex>>4) & 0x0F;
    putc(tmp<0x0A?tmp+'0':tmp-0x0A+'A');
    tmp = hex & 0x0F;
    putc(tmp<0x0A?tmp+'0':tmp-0x0A+'A');
}

void print_unsigned_char(unsigned char data) {
    if (data>99) putc(data/100 + '0');
    if (data>9) putc((data/10)%10 + '0');
    putc(data%10 + '0');
}

void print_unsigned_int_hex(unsigned int data) {
	Int tmp;
	tmp.value=data;

	print_hex(tmp.bytes[1]);
	print_hex(tmp.bytes[0]);
}

void print_unsigned_long_hex(unsigned long data) {
	Long tmp;
	signed char i;
	tmp.value=data;
	
	for (i=3;i>=0;i--) {
		print_hex(tmp.bytes[i]);
	}
}*/