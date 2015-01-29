;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Jan 03 23:34:58 2015
;--------------------------------------------------------
	.module io
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _putc
	.globl _print
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
;io.c:6: void putc(unsigned char c) {
;	---------------------------------
; Function putc
; ---------------------------------
_putc_start::
_putc:
;io.c:7: USART_PORT = c;
	ld	hl, #2+0
	add	hl, sp
	ld	a, (hl)
	out	(_USART_PORT),a
	ret
_putc_end::
;io.c:16: void print(unsigned char* string) {
;	---------------------------------
; Function print
; ---------------------------------
_print_start::
_print:
;io.c:17: do {
	pop	bc
	pop	de
	push	de
	push	bc
00101$:
;io.c:18: USART_PORT = *string;
	ld	a,(de)
	out	(_USART_PORT),a
;io.c:19: string++;
	inc	de
;io.c:20: } while (*string != 0);
	ld	a,(de)
	or	a, a
	jr	NZ,00101$
	ret
_print_end::
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
