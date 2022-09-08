sgcolinit
        jsr sg12init
        jsr sg12clr
        clr vscnt2
        rts

titleinit
        jsr pmode1
        ldd #$0000
        jsr clearscrn_1
        clr vscnt2
        rts

creditsinit
        jsr pmoded
        ldd #$0000
        jsr clearscrn_d
        ;jsr testpattern
        clr vscnt2
        clr torusflag
        rts

scrollinit
        jsr pmodeia
        jsr palswap
        ldd #$8080
        jsr clearscrn_d
        ;jsr scroll1
        clr vscnt2
        rts

twistinit
        jsr pmoded
        jsr palswap
        ldd #$0000
        jsr clearscrn_d
        clr twistflag
        rts

sheepinit
        jsr pmoded
        jsr palswap
        ldd #$5555
        jsr clearscrn_d
        clr sheepflag
        rts

infoscrninit
        jsr pmodeia
        ldd #$8F8F
        ;ldd #$7f7f
        jsr clearscrn_d
        lda #0
        sta infoflag
        rts

sg12init
        jsr sg12mode
        jsr sg12clr
        jsr palswap
        rts