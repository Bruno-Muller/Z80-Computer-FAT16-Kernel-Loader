;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Jan 03 23:34:58 2015
;--------------------------------------------------------
	.module fat16
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _IO_PARAM2
	.globl _IO_PARAM1
	.globl _fat16_compare_file_name
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
;fat16.c:21: unsigned char fat16_compare_file_name(const char* const name1) {
;	---------------------------------
; Function fat16_compare_file_name
; ---------------------------------
_fat16_compare_file_name_start::
_fat16_compare_file_name:
	push	ix
	ld	ix,#0
	add	ix,sp
;fat16.c:24: for (i=0; i<11; i++) {
	ld	c,#0x00
00104$:
;fat16.c:25: if (name1[i] != name2[i]) {
	ld	l,4 (ix)
	ld	h,5 (ix)
	ld	b,#0x00
	add	hl, bc
	ld	d,(hl)
	ld	hl,(_fat16_compare_file_name_name2_1_6)
	ld	b,#0x00
	add	hl, bc
	ld	e,(hl)
	ld	a,d
	sub	a, e
	jr	Z,00105$
;fat16.c:26: return FALSE;
	ld	l,#0x00
	jr	00106$
00105$:
;fat16.c:24: for (i=0; i<11; i++) {
	inc	c
	ld	a,c
	sub	a, #0x0B
	jr	C,00104$
;fat16.c:29: return TRUE;
	ld	l,#0x01
00106$:
	pop	ix
	ret
_fat16_compare_file_name_end::
_fat16_compare_file_name_name2_1_6:
	.dw ___str_0
___str_0:
	.ascii "KERNEL  BIN"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
