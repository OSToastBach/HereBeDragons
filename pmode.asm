;pmode routines from chibiakumas - thanks keith! <3

pmode1  ;128x96, 4 colours
        jsr pmodereset
        ;     AGGGC---	C=Color (0=Green 1=Orange)
        lda #%11000000
        sta $FF22
        sta $FFC4+1 ;SAM V2=1
        rts

pmoded  ;64x64, 4 colours
        jsr pmodereset
            ; AGGGC---	C=Color (0=Green 1=Orange)
        lda #%10000000
        sta $FF22
        sta $ffc0+1	;SAM V0=1
        rts

pmodereset
        ;reset screen, set screen address
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

sg12mode			
        ;32(64)x96, 11(12?) colours, uses as much memory as pmode1
        lda #0
        sta $FF22

        sta $ffc0
        sta $ffc2
        sta $ffc5
        rts

pmodeia ;normal text mode
	jsr pmodereset
		; AGGGC---	C=Color (0=Green 1=Orange)
	lda #%00000000
	sta $FF22
	rts

palswap ;swap palette from red, yellow, green, blue to pink, white, green, orange
        lda $FF22
        eora #%00001000	;Switch CSS color palette
        sta $FF22
        rts

clearscrn_d     ;64x64 clear
        ldx #$400
clearscrn_d_loop
        std ,x++
        cmpx #$0800
        bne clearscrn_d_loop
        rts

clearscrn_1     ;128x96 clear
        ldx #$400
clearscrn_1_loop
        std ,x++
        cmpx #$1000
        bne clearscrn_1_loop
        rts

sg12clr         ;sg12 clear
        ldx #$400
        ldd #$8080
sg12clrlp
        std ,x++
        cmpx #$1000
        bne sg12clrlp
        rts