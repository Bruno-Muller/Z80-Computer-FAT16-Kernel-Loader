#ifndef CHIPSET_H
#define	CHIPSET_H

__sfr __at (0x00) USART_PORT;
__sfr __at (0x02) SDCARD_PORT;

volatile __at (0x50) unsigned int IO_PARAM1;
volatile __at (0x52) unsigned long IO_PARAM2;

#define SDCARD_READ		0x00

void chipset_load_sector_into_memory(void * memory, unsigned long sector_address);


#endif /* CHIPSET_H */