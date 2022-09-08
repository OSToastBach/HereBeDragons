@echo off
set file=main

echo Assembling...
asm6809.exe -D %file%.asm -o TORUS.BIN -l output.txt
if errorlevel 1 goto end
rem echo Creating Disk Image...
rem dragondos.exe delete hbd.vdk HBD.BIN
rem dragondos.exe write hbd.vdk HBD.BIN
rem echo Creating Tape File (96KHz)...
rem perl ../tools/bin2cas.pl -r 96000 -o hbd.wav hbd.bin -b 16
echo Booting Emulator...
xroar.exe -vo sdl -default-machine dragon32 -extbas D:\CODEDEV\Dragon-32\xroar-0.36.2-w64\D32.rom -nodos -kbd-translate -run TORUS.BIN
:end