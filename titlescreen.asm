cygnetline
        clr xcnt
cygnetlinelp1
        ldd ,x++
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #16
        bne cygnetlinelp1
        rts

titlescreen
        lda vscnt
        cmpa #12
        bne skiptitle
        clr vscnt
        inc sceneval
        bra titlescreenend
skiptitle
        lda titleflag
        cmpa #0
        beq dotitle
        jsr titleinit
        clr titleflag
dotitle
        inc vscnt2
        lda vscnt2
        cmpa #2
        bne titlescreenend
        clr vscnt2
        ldx titlesrc
        cmpx #cygnetsonggfxend
        bne cygreset1
        bra titlescreenend
cygreset1
        ldy titledst
        jsr cygnetline
        stx titlesrc
        sty titledst
titlescreenend
        rts

cygnetsong
        includebin "gfx/cygnetsong.bin"
cygnetsonggfxend