;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.4.0 #8981 (Apr  5 2014) (MINGW64)
; This file was generated Sat Jan 03 23:34:58 2015
;--------------------------------------------------------
	.module main
	.optsdcc -mz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _fat16_compare_file_name
	.globl _print
	.globl _chipset_load_sector_into_memory
	.globl _IO_PARAM2
	.globl _IO_PARAM1
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
;main.c:30: void main() {	
;	---------------------------------
; Function main
; ---------------------------------
_main_start::
_main:
	push	ix
	ld	ix,#0
	add	ix,sp
	ld	hl,#-36
	add	hl,sp
	ld	sp,hl
;main.c:39: const unsigned long AbsoluteFirstRootDirSecNum = bpb->BPB_RsvSecCnt + bpb->BPB_NumFATs * bpb->BPB_FATs16 + partition->firstPartitionSector;
	ld	hl,#0x130E
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(#0x1310)
	ld	hl,#0x1316
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,a
	ld	h,#0x00
	push	de
	push	bc
	push	hl
	call	__mulint_rrx_s
	pop	af
	pop	af
	pop	de
	add	hl,de
	push	hl
	ld	de,#0x12C6
	ld	hl, #0x0022
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	pop	de
	ld	l,e
	ld	h,d
	ld	bc,#0x0000
	ld	a,l
	add	a, -4 (ix)
	ld	l,a
	ld	a,h
	adc	a, -3 (ix)
	ld	h,a
	ld	a,c
	adc	a, -2 (ix)
	ld	c,a
	ld	a,b
	adc	a, -1 (ix)
	ld	b,a
	ld	-15 (ix),l
	ld	-14 (ix),h
	ld	-13 (ix),c
	ld	-12 (ix),b
;main.c:40: const unsigned long FirstDataSector = bpb->BPB_RsvSecCnt + (bpb->BPB_NumFATs * bpb->BPB_FATs16) + RootDirSectors;
	ld	hl,#0x0020
	add	hl,de
	ld	-19 (ix),l
	ld	-18 (ix),h
	ld	-17 (ix),#0x00
	ld	-16 (ix),#0x00
;main.c:49: unsigned int lastFatSectorLoaded = 0; // long
	ld	-24 (ix),#0x00
	ld	-23 (ix),#0x00
;main.c:54: DirectoryEntry* kernel_file_entry = NULL;
	ld	-34 (ix),#0x00
	ld	-33 (ix),#0x00
;main.c:55: unsigned int  kernel_root_directory_sector = 0;
	ld	-4 (ix),#0x00
	ld	-3 (ix),#0x00
;main.c:60: for (sector = 0; sector < RootDirSectors; sector++) {
	ld	-20 (ix),#0x00
00124$:
	ld	a,-20 (ix)
	sub	a, #0x20
	jp	NC,00111$
;main.c:62: chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + sector);
	ld	h,-20 (ix)
	ld	l,#0x00
	ld	de,#0x0000
	ld	a,-15 (ix)
	add	a, h
	ld	c,a
	ld	a,-14 (ix)
	adc	a, l
	ld	b,a
	ld	a,-13 (ix)
	adc	a, e
	ld	e,a
	ld	a,-12 (ix)
	adc	a, d
	ld	d,a
	push	de
	push	bc
	ld	hl,#0x2100
	push	hl
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:63: entry = rootDirectory;
	ld	-6 (ix),#0x00
	ld	-5 (ix),#0x21
;main.c:65: for (i=0; i<16; i++, entry++) {
	ld	-11 (ix),#0x00
	ld	-22 (ix),#0x00
	ld	-21 (ix),#0x21
00122$:
;main.c:66: if (entry->DIR_Name[0] == 0x00) {sector = RootDirSectors; break;} // end of directory
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	ld	a,(hl)
	or	a, a
	jr	NZ,00102$
	ld	-20 (ix),#0x20
	jr	00125$
00102$:
;main.c:67: if (entry->DIR_Name[0] == 0xE5) continue; // deleted file
	sub	a, #0xE5
	jr	Z,00109$
;main.c:68: if (entry->DIR_Attr == ATTR_DIRECTORY) continue; // sub directory
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	ld	de, #0x000B
	add	hl, de
	ld	a,(hl)
	sub	a, #0x10
	jr	Z,00109$
;main.c:69: if (fat16_compare_file_name(entry->DIR_Name) == TRUE) {
	ld	l,-22 (ix)
	ld	h,-21 (ix)
	push	hl
	call	_fat16_compare_file_name
	pop	af
	dec	l
	jr	NZ,00109$
;main.c:70: kernel_file_entry = entry;
	ld	a,-6 (ix)
	ld	-34 (ix),a
	ld	a,-5 (ix)
	ld	-33 (ix),a
;main.c:71: kernel_root_directory_sector = sector;
	ld	a,-20 (ix)
	ld	-4 (ix),a
	ld	-3 (ix),#0x00
;main.c:72: sector = RootDirSectors;
	ld	-20 (ix),#0x20
;main.c:73: break;
	jr	00125$
00109$:
;main.c:65: for (i=0; i<16; i++, entry++) {
	inc	-11 (ix)
	ld	a,-22 (ix)
	add	a, #0x20
	ld	-22 (ix),a
	ld	a,-21 (ix)
	adc	a, #0x00
	ld	-21 (ix),a
	ld	a,-22 (ix)
	ld	-6 (ix),a
	ld	a,-21 (ix)
	ld	-5 (ix),a
	ld	a,-11 (ix)
	sub	a, #0x10
	jr	C,00122$
00125$:
;main.c:60: for (sector = 0; sector < RootDirSectors; sector++) {
	inc	-20 (ix)
	jp	00124$
00111$:
;main.c:79: if (kernel_file_entry == NULL) {
	ld	a,-33 (ix)
	or	a,-34 (ix)
	jr	NZ,00116$
;main.c:80: print("\r\nKERNEL.BIN not found in root directory !");
	ld	hl,#___str_0
	push	hl
	call	_print
	pop	af
;main.c:81: while(1);
00113$:
	jr	00113$
00116$:
;main.c:84: print("\r\nLoad KERNEL.BIN");
	ld	hl,#___str_1
	push	hl
	call	_print
	pop	af
;main.c:86: chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + kernel_root_directory_sector);
	ld	a,-4 (ix)
	ld	-4 (ix),a
	ld	a,-3 (ix)
	ld	-3 (ix),a
	ld	-2 (ix),#0x00
	ld	-1 (ix),#0x00
	ld	a,-15 (ix)
	add	a, -4 (ix)
	ld	-4 (ix),a
	ld	a,-14 (ix)
	adc	a, -3 (ix)
	ld	-3 (ix),a
	ld	a,-13 (ix)
	adc	a, -2 (ix)
	ld	-2 (ix),a
	ld	a,-12 (ix)
	adc	a, -1 (ix)
	ld	-1 (ix),a
	ld	l,-2 (ix)
	ld	h,-1 (ix)
	push	hl
	ld	l,-4 (ix)
	ld	h,-3 (ix)
	push	hl
	ld	hl,#0x2100
	push	hl
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:88: cluster = kernel_file_entry->DIR_FstClusLO;
	pop	bc
	pop	iy
	push	iy
	push	bc
	ld	a,26 (iy)
	ld	-32 (ix),a
	ld	a,27 (iy)
	ld	-31 (ix),a
;main.c:90: do {
	ld	hl,#0x2500
	ex	(sp), hl
00119$:
;main.c:92: AbsoluteFirstSectorOfCluster  = ((cluster-2) * bpb->BPB_SecPerClus) + FirstDataSector + partition->firstPartitionSector;
	ld	e,-32 (ix)
	ld	d,-31 (ix)
	dec	de
	dec	de
	ld	hl,#0x130D
	ld	l,(hl)
	ld	h,#0x00
	push	hl
	push	de
	call	__mulint_rrx_s
	pop	af
	pop	af
	ld	de,#0x0000
	ld	a,l
	add	a, -19 (ix)
	ld	-4 (ix),a
	ld	a,h
	adc	a, -18 (ix)
	ld	-3 (ix),a
	ld	a,d
	adc	a, -17 (ix)
	ld	-2 (ix),a
	ld	a,e
	adc	a, -16 (ix)
	ld	-1 (ix),a
	ld	de,#0x12C6
	ld	hl, #0x001A
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	a,-4 (ix)
	add	a, -10 (ix)
	ld	-10 (ix),a
	ld	a,-3 (ix)
	adc	a, -9 (ix)
	ld	-9 (ix),a
	ld	a,-2 (ix)
	adc	a, -8 (ix)
	ld	-8 (ix),a
	ld	a,-1 (ix)
	adc	a, -7 (ix)
	ld	-7 (ix),a
	ld	a,-10 (ix)
	ld	-26 (ix),a
	ld	a,-9 (ix)
	ld	-25 (ix),a
;main.c:93: chipset_load_sector_into_memory(kernel_data, AbsoluteFirstSectorOfCluster);
	ld	a,-26 (ix)
	ld	-10 (ix),a
	ld	a,-25 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	-7 (ix),#0x00
	pop	de
	push	de
	ld	l,-8 (ix)
	ld	h,-7 (ix)
	push	hl
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	push	hl
	push	de
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:94: kernel_data += 512;
	ld	a,-36 (ix)
	add	a, #0x00
	ld	-36 (ix),a
	ld	a,-35 (ix)
	adc	a, #0x02
	ld	-35 (ix),a
;main.c:97: FatOffset = cluster * 2; // FAT Entry index
	ld	e,-32 (ix)
	ld	d,-31 (ix)
	sla	e
	rl	d
;main.c:98: AbsoluteThisFatSecNum = bpb->BPB_RsvSecCnt + (FatOffset / bpb->BPB_BytsPerSec) + partition->firstPartitionSector; // FAT Entry Sector
	ld	hl,#0x130E
	ld	a,(hl)
	ld	-10 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-9 (ix),a
	ld	hl,#0x130B
	ld	a,(hl)
	ld	-6 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-5 (ix),a
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	push	de
	call	__divuint_rrx_s
	pop	af
	pop	af
	ld	-3 (ix),h
	ld	-4 (ix),l
	ld	a,-10 (ix)
	add	a, -4 (ix)
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a, -3 (ix)
	ld	-9 (ix),a
	ld	de,#0x12C6
	ld	hl, #0x0020
	add	hl, sp
	ex	de, hl
	ld	bc, #0x0004
	ldir
	ld	a,-10 (ix)
	ld	-10 (ix),a
	ld	a,-9 (ix)
	ld	-9 (ix),a
	ld	-8 (ix),#0x00
	ld	-7 (ix),#0x00
	ld	a,-10 (ix)
	add	a, -4 (ix)
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a, -3 (ix)
	ld	-9 (ix),a
	ld	a,-8 (ix)
	adc	a, -2 (ix)
	ld	-8 (ix),a
	ld	a,-7 (ix)
	adc	a, -1 (ix)
	ld	-7 (ix),a
	ld	a,-10 (ix)
	ld	-28 (ix),a
	ld	a,-9 (ix)
	ld	-27 (ix),a
;main.c:99: ThisFatEntryOffset = (cluster % bpb->BPB_BytsPerSec); //(FATOffset % bpb->BPB_BytsPerSec);
	ld	l,-6 (ix)
	ld	h,-5 (ix)
	push	hl
	ld	l,-32 (ix)
	ld	h,-31 (ix)
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	ld	-30 (ix),l
	ld	-29 (ix),h
;main.c:101: if (lastFatSectorLoaded != AbsoluteThisFatSecNum) {
	ld	a,-24 (ix)
	sub	a, -28 (ix)
	jr	NZ,00179$
	ld	a,-23 (ix)
	sub	a, -27 (ix)
	jr	Z,00118$
00179$:
;main.c:102: chipset_load_sector_into_memory(fat, AbsoluteThisFatSecNum);
	ld	e,-28 (ix)
	ld	d,-27 (ix)
	ld	hl,#0x0000
	push	hl
	push	de
	ld	hl,#0x2300
	push	hl
	call	_chipset_load_sector_into_memory
	ld	hl,#6
	add	hl,sp
	ld	sp,hl
;main.c:103: lastFatSectorLoaded = AbsoluteThisFatSecNum;
	ld	a,-28 (ix)
	ld	-24 (ix),a
	ld	a,-27 (ix)
	ld	-23 (ix),a
00118$:
;main.c:106: cluster = fat[ThisFatEntryOffset];
	ld	a,-30 (ix)
	ld	-10 (ix),a
	ld	a,-29 (ix)
	ld	-9 (ix),a
	sla	-10 (ix)
	rl	-9 (ix)
	ld	a,-10 (ix)
	add	a, #0x00
	ld	-10 (ix),a
	ld	a,-9 (ix)
	adc	a, #0x23
	ld	-9 (ix),a
	ld	l,-10 (ix)
	ld	h,-9 (ix)
	ld	a,(hl)
	ld	-32 (ix),a
	inc	hl
	ld	a,(hl)
	ld	-31 (ix),a
;main.c:107: } while (cluster < 0xFFF8);
	ld	a,-32 (ix)
	sub	a, #0xF8
	ld	a,-31 (ix)
	sbc	a, #0xFF
	jp	C,00119$
	ld	sp, ix
	pop	ix
	ret
_main_end::
___str_0:
	.db 0x0D
	.db 0x0A
	.ascii "KERNEL.BIN not found in root directory !"
	.db 0x00
___str_1:
	.db 0x0D
	.db 0x0A
	.ascii "Load KERNEL.BIN"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
