cd %1
D:
sdasz80 -o crt0.s
sdcc -mz80 -c main.c
sdcc -mz80 -c chipset.c
sdcc -mz80 -c fat16.c
sdcc -mz80 -c io.c
sdcc -mz80 --code-loc 0x1509 --data-loc 0x2000 --no-std-crt0 -o bootstrap.ihx main.rel crt0.rel chipset.rel fat16.rel io.rel
makebin -p bootstrap.ihx bootstrap.bin
pause