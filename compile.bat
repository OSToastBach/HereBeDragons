@echo off
set file=main

echo Assembling...
asm6809.exe -D %file%.asm -o HBD.BIN -l output.txt
if errorlevel 1 goto end
echo Creating Disk Image...
dragondos.exe delete hbd.vdk HBD.BIN
dragondos.exe write hbd.vdk HBD.BIN
echo Creating Tape File (44.1KHz)...
perl ../tools/bin2cas.pl -r 22050 -o hbd.wav -D HBD.BIN
echo Booting Emulator...
xroar.exe -vo sdl -default-machine dragon32 -extbas D:\CODEDEV\Dragon-32\xroar-0.36.2-w64\D32.rom -nodos -kbd-translate -run HBD.BIN
:end