#include "bool.h"
#include "chipset.h"
#include "fat16.h"
#include "io.h"
#include "mbr.h"
#include "z80.h"

#define ROOT_ENTRY_COUNT	0x200
#define BYTE_PER_SECTOR		0x200
#define FAT16_BPB_SIZE		0x200
#define BIOS_SIZE			0x1000


#define ROOT_ENTRY_COUNT	0x200
#define BYTE_PER_SECTOR		0x200
#define FAT16_BPB_SIZE		0x200

#define MBR_ADDRESS			0x1100
#define BPB_ADDRESS			0x1300
#define ROOT_DIR_ADDRESS	0x2100
#define FAT_ADDRESS			0x2300
#define KERNEL_ADDRESS		0x2500

#define MBR_PTR				(void*) MBR_ADDRESS
#define BPB_PTR				(void*) BPB_ADDRESS
#define ROOT_DIR_PTR		(void*) ROOT_DIR_ADDRESS
#define FAT_PTR				(void*)	FAT_ADDRESS
#define KERNEL_PTR			(void*) KERNEL_ADDRESS

void main() {	
	// MBR
	const MasterBootRecord* const mbr = MBR_PTR;
	const PartitionDescriptor* const partition = &mbr->partitionTable[0];
	unsigned char i;
	
	// BPB
	const BiosParameterBlock* const bpb = BPB_PTR;
	unsigned char const RootDirSectors = ((ROOT_ENTRY_COUNT*32) + (BYTE_PER_SECTOR - 1))/BYTE_PER_SECTOR;
	const unsigned long AbsoluteFirstRootDirSecNum = bpb->BPB_RsvSecCnt + bpb->BPB_NumFATs * bpb->BPB_FATs16 + partition->firstPartitionSector;
	const unsigned long FirstDataSector = bpb->BPB_RsvSecCnt + (bpb->BPB_NumFATs * bpb->BPB_FATs16) + RootDirSectors;
	
	// Root Directory
	DirectoryEntry* const rootDirectory = ROOT_DIR_PTR;
	unsigned char sector;
	DirectoryEntry* entry;
	
	// Fat
	unsigned int* fat = FAT_PTR;
	unsigned int lastFatSectorLoaded = 0; // long
	unsigned int AbsoluteFirstSectorOfCluster, FatOffset, AbsoluteThisFatSecNum; // long
	unsigned int ThisFatEntryOffset, cluster;
	
	// Kernel file
	DirectoryEntry* kernel_file_entry = NULL;
	unsigned int  kernel_root_directory_sector = 0;
	char* const kernel_file = KERNEL_PTR;
	char* kernel_data = kernel_file;
		
	// List Root Directory and Search KERNEL.BIN
	for (sector = 0; sector < RootDirSectors; sector++) {
		// Load a root directory sector;
		chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + sector);
		entry = rootDirectory;

		for (i=0; i<16; i++, entry++) {
			if (entry->DIR_Name[0] == 0x00) {sector = RootDirSectors; break;} // end of directory
			if (entry->DIR_Name[0] == 0xE5) continue; // deleted file
			if (entry->DIR_Attr == ATTR_DIRECTORY) continue; // sub directory
			if (fat16_compare_file_name(entry->DIR_Name) == TRUE) {
				kernel_file_entry = entry;
				kernel_root_directory_sector = sector;
				sector = RootDirSectors;
				break;
			}
		}
	}
	
	// If KERNEL not found
	if (kernel_file_entry == NULL) {
		print("\r\nKERNEL.BIN not found in root directory !");
		while(1);
	}
	
	print("\r\nLoad KERNEL.BIN");

	chipset_load_sector_into_memory(rootDirectory, AbsoluteFirstRootDirSecNum + kernel_root_directory_sector);

	cluster = kernel_file_entry->DIR_FstClusLO;

	do {
		// Load sector of data (1 cluster = 1 sector)
		AbsoluteFirstSectorOfCluster  = ((cluster-2) * bpb->BPB_SecPerClus) + FirstDataSector + partition->firstPartitionSector;
		chipset_load_sector_into_memory(kernel_data, AbsoluteFirstSectorOfCluster);
		kernel_data += 512;

		// Load FAT
		FatOffset = cluster * 2; // FAT Entry index
		AbsoluteThisFatSecNum = bpb->BPB_RsvSecCnt + (FatOffset / bpb->BPB_BytsPerSec) + partition->firstPartitionSector; // FAT Entry Sector
		ThisFatEntryOffset = (cluster % bpb->BPB_BytsPerSec); //(FATOffset % bpb->BPB_BytsPerSec);
	
		if (lastFatSectorLoaded != AbsoluteThisFatSecNum) {
			chipset_load_sector_into_memory(fat, AbsoluteThisFatSecNum);
			lastFatSectorLoaded = AbsoluteThisFatSecNum;
		}
		
		cluster = fat[ThisFatEntryOffset];
	} while (cluster < 0xFFF8);
}