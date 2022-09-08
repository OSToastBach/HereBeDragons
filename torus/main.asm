        org 0

xcnt            rmb 1
vscnt           rmb 1
gfxaddr         rmb 2
scrnflag        rmb 1
        
        org $1000

DBGPAL	macro           ;check frame time
	lda $ff22
	eora #$18
	sta $ff22
	endm

start

        orcc #$50

        ;enable tape output and vsync - thanks chibiakumas/keith!
        lda #%00111110	;Bit 3=0 Bit0=Hsync
        sta $ff01		;Bit 3	CA2: Select Device (Multiplexor LSB)
        lda #%00110111	;Bit 3=0 Bit0=Vsync
        sta $ff03		;Bit 3	CB2: Select Device (Multiplexor MSB)

        ;new irq vector
        lda #$7e        ;hijack with jmp
        sta $010c
        ldx #irq_start  ;point to our irq routine
        stx $010d

        andcc #$ef      ;reenable interrupts

        jsr pmoded

        clr vscnt
        clr scrnflag

        ldx #torusgfx
        stx gfxaddr

        ;clr $ffd7
        jsr clear_d

main
        jmp main

irq_start
        lda $ff02

        ;DBGPAL
        inc vscnt
        lda vscnt
        cmpa #2
        bne actualendiswear

        clr vscnt
        jsr toruscopy2
        jsr torusmain
        ldx gfxaddr
        leax 512,x
        cmpx #torusgfxend
        bne irq_end
        ldx #torusgfx
irq_end
        stx gfxaddr
actualendiswear
        ;DBGPAL
        rti

torusmain
        ldx gfxaddr
        ldy #$400
        clr xcnt
toruscopy
        ldd ,x++
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #8
        bne skipreset
        leay 16,y
        clr xcnt
skipreset
        cmpy #$800
        bne toruscopy
        rts

toruscopy2
        clr xcnt
        ldx #$400
        ldy #$410
toruscopy2lp
        ldd ,x++
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #8
        bne skipreset2
        leax 16,x
        leay 16,y
        clr xcnt
skipreset2
        cmpx #$800
        bne toruscopy2lp
        rts

clear_d
        ldx #$400
        ldd #0
clear_dlp
        std ,x++
        cmpx #$800
        bne clear_dlp
        rts

pmoded
        jsr pmodereset
            ; AGGGC---	C=Color (0=Green 1=Orange)
        lda #%10000000
        sta $FF22
        sta $ffc0+1	;SAM V0=1
        rts

pmodereset
        sta $FFC6	;Clr ScrBase Bit 0	$0200
        sta $FFC8	;Clr ScrBase Bit 1	$0400
        sta $FFCA	;Clr ScrBase Bit 2	$0800
        sta $FFCC	;Clr ScrBase Bit 3	$1000
        sta $FFCE	;Clr ScrBase Bit 4	$2000
        sta $FFD0	;Clr ScrBase Bit 5	$4000
        sta $FFD2	;Clr ScrBase Bit 6	$8000

        sta $FFC8+1	;Set ScrBase Bit 1	$0400

        sta $FFC0	;SAM V0=0
        sta $FFC2	;SAM V1=0
        sta $FFC4	;SAM V2=0
        rts

torusgfx
        includebin "torus5.bin"
torusgfxend

        end start