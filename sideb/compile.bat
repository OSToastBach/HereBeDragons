@echo off
set file=main

echo Assembling...
asm6809.exe -D %file%.asm -o SIDEB.BIN -l output.txt
if errorlevel 1 goto end
echo Creating Disk Image...
dragondos.exe delete sideb.vdk SIDEB.BIN
dragondos.exe write sideb.vdk SIDEB.BIN
echo Creating Tape File (44.1KHz)...
perl ../../tools/bin2cas.pl -r 22050 -o sideb.wav -D SIDEB.BIN
echo Booting Emulator...
xroar.exe -vo sdl -default-machine dragon32 -extbas D:\CODEDEV\Dragon-32\xroar-0.36.2-w64\D32.rom -nodos -kbd-translate -run SIDEB.BIN
:end