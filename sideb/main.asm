        org 20

vsync_count     rmb 2
imageflag       rmb 1

        org $1000

start

        lds #$3E00      ;set up stacks
        ldu #$3D00

        orcc #$50       ;disable interrupts

        lda $ff23
        ora #%00001000
        sta $ff23

	lda #%00111110	;Bit 3=0 Bit0=Hsync
	sta $ff01		;Bit 3	CA2: Select Device (Multiplexor LSB)
	lda #%00110111	;Bit 3=0 Bit0=Vsync
	sta $FF03		;Bit 3	CB2: Select Device (Multiplexor MSB)

        ;MX-H   MX-L
        ;0      0       DAC
        ;0      1       Cassette
        ;1      0       Cartridge
        ;0      0       Unused

        lda #$7e                ;hijack with jmp
        sta $010c
        ldx #irq_start          ;point to our irq routine
        stx $010d

        andcc #$ef              ;reenable interrupts

        clr sgflag1
        clr sgflag2

        jsr pmode1

        clr imageflag

        clr vsync_count

main
        jmp main

irq_start
        lda $ff02               ;acknowledge interrupt
        inc vsync_count

        lda vsync_count
        cmpa #150
        bne skip0
        inc imageflag
        ldd #$0000
        std vsync_count
skip0
        lda imageflag
        cmpa #0
        bne skip1
        ldx #robotskiss
        jsr copyimage
skip1
        lda imageflag
        cmpa #1
        bne skip2
        ldx #twisterlolly
        jsr copyimage
skip2
        lda imageflag
        cmpa #2
        bne skip3
        ldx #youwouldnt
        jsr copyimage
skip3
        lda imageflag
        cmpa #3
        bne skip4
        ldx #pirates
        jsr copyimage
skip4
        lda imageflag
        cmpa #4
        bne skip5
        ldx #trashbaby
        jsr copyimage
skip5
        lda imageflag
        cmpa #5
        bne skip6
        ldx #cygnetsong
        jsr copyimage
skip6
        lda imageflag
        cmpa #6
        bne skip7
        ldx #squibb
        jsr copyimage
skip7                   ;SGCOLS
        lda sgflag1
        cmpa #1
        bne skipsg1
        jsr sg12mode
        jsr palswap
        clr sgflag1
skipsg1
        lda imageflag
        cmpa #7
        bne skip8
        ldx #dragonraccoon2
        jsr copyimage
skip8                   ;SGCOLS
        lda sgflag1
        cmpa #1
        bne skipsg2
        jsr sg12mode
        clr sgflag1
skipsg2
        lda imageflag
        cmpa #8
        bne skip9
        ldx #cowadragon
        jsr copyimage
skip9
        lda imageflag
        cmpa #9
        bne checksgflag
        lda #0
        sta imageflag
        jsr pmode1

checksgflag
        lda imageflag
        cmpa #7
        bne irq_end
        lda #1
        sta sgflag1

irq_end
        rti


pmodereset                      ;pmode routines from chibiakumas
        lda #0
        sta $FFC6
        sta $FFC8
        sta $FFCA
        sta $FFCC
        sta $FFCE
        sta $FFD0
        sta $FFD2

        sta $FFC8+1             ;set screenbase $400
        sta $FFC0
        sta $FFC2
        sta $FFC4
        rts

pmode1  ;128x96
        jsr pmodereset
        ;     AGGGC---	C=Color (0=Green 1=Orange)
        lda #%11000000
        sta $FF22
        sta $FFC4+1 ;SAM V2=1
        rts

palswap
        lda $FF22
        eora #%00001000	;Switch CSS color palette
        sta $FF22
        rts

copyimage
        ldy #$400
copyloop
        lda ,x+
        sta ,y+
        cmpy #$1000
        bne copyloop
        rts

sg12mode			;64x96
        lda #0
        sta $FF22

        sta $ffc0
        sta $ffc2
        sta $ffc5
        rts

sg12clr
        ldx #$400
        ldd #$8080
sg12clrlp
        std ,x++
        cmpx #$1000
        bne sg12clrlp
        rts

sgflag1     rmb 1
sgflag2     rmb 1

robotskiss
        includebin "gfx/robotskiss.bin"
twisterlolly
        includebin "gfx/twisterlolly.bin"
youwouldnt
        includebin "gfx/youwouldnt.bin"
dragonraccoon2
        includebin "gfx/dragonraccoon2.bin"
cowadragon
        includebin "gfx/cowadragon.bin"
pirates
        includebin "gfx/pirates.bin"
trashbaby
        includebin "gfx/trashbaby.bin"
cygnetsong
        includebin "gfx/cygnetsong.bin"
squibb
        includebin "gfx/squibb.bin"

        end start