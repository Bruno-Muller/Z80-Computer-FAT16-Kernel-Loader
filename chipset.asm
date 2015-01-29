;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Jan 03 23:34:58 2015
;--------------------------------------------------------
	.module chipset
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _chipset_load_sector_into_memory
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
_USART_PORT	=	0x0000
_SDCARD_PORT	=	0x0002
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_IO_PARAM1	=	0x0050
_IO_PARAM2	=	0x0052
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;chipset.c:3: void chipset_load_sector_into_memory(void * memory, unsigned long sector_address) {
;	---------------------------------
; Function chipset_load_sector_into_memory
; ---------------------------------
_chipset_load_sector_into_memory_start::
_chipset_load_sector_into_memory:
;chipset.c:4: IO_PARAM1 = (unsigned int) memory;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 0),a
	ld	hl, #2+1
	add	hl, sp
	ld	a, (hl)
	ld	(#_IO_PARAM1 + 1),a
;chipset.c:5: IO_PARAM2 = sector_address;
	ld	de, #_IO_PARAM2
	ld	hl, #4
	add	hl, sp
	ld	bc, #4
	ldir
;chipset.c:6: SDCARD_PORT = SDCARD_READ;
	ld	a,#0x00
	out	(_SDCARD_PORT),a
	ret
_chipset_load_sector_into_memory_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
