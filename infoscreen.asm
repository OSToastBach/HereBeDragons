infoscrn
        ldx #$400
        ldy currchar
info1
        lda ,x
        cmpa ,y
        beq info2
        deca
info2
        sta ,x+
        ;leax 1,x
        leay 1,y
        cmpx #$600
        bne info1
        rts

infoscrnend
        lda vscnt
        cmpa #3
        bne skipinfoend
        clr vscnt
        inc sceneval
        bra infoend2
skipinfoend
        ldx #$400
infoend1
        lda ,x
        cmpa #144       ;207 = white ;144 = black 2
        beq infoskipinc
        inca
infoskipinc
        sta ,x+
        cmpx #$600
        bne infoend1
infoend2
        rts

infoscrnmain
        lda vscnt
        cmpa #12
        bne skipinfo
        clr vscnt
        inc sceneval
        bra endinfo
skipinfo
        lda infoflag
        cmpa #0
        beq sceneinfo
        jsr infoscrninit
        clr infoflag
        ;jsr palswap
sceneinfo
        jsr infoscrn
        bra endinfo
checkinfoend
        jsr infoscrnend
endinfo
        rts

infostring
        fcv "        SO WHAT'S IN A          "
        fcv "                                "
        fcb 143,143,129,134,143,129,130,143,137,134,143,129,131,143,137,134,143,128,138,143,143,131,130,143,131,130,143,137,131,141,143,143
        fcb 143,143,133,138,143,129,133,143,129,130,143,133,130,143,133,138,143,129,136,143,143,139,130,143,129,131,143,143,137,143,143,143
        fcb 143,143,132,137,143,133,138,143,133,138,143,132,136,143,134,137,143,133,128,143,143,140,136,143,132,140,143,143,141,143,143,143
        fcv "                                "
        fcv "  MOTOROLA 6809E CPU @ 0.89MHZ  "
        fcv "WITH LIMITED 16-BIT CAPABILITIES"
        fcv "   POWERFUL ADDRESSING MODES    "
        fcv "                                "
        fcv "   MOTOROLA 6847 VDG FOR GFX:   "
        fcv " UP TO 256X192, UP TO 4 COLOURS "
        fcv " 2 DODGY LOOKING COLOR PALETTES "
        fcv "                                "
        fcv " 32KB RAM, 6-BIT DAC FOR SOUND  "
        fcv "    40 YEARS OLD THIS MONTH!    "