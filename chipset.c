#include "chipset.h"

void chipset_load_sector_into_memory(void * memory, unsigned long sector_address) {
	IO_PARAM1 = (unsigned int) memory;
	IO_PARAM2 = sector_address;
	SDCARD_PORT = SDCARD_READ;
}