torusmain
        lda vscnt
        cmpa #12
        bne skiptorus
        clr vscnt
        inc sceneval
        jsr scrollinit
        bra actualendiswear
skiptorus
        lda torusflag
        cmpa #0
        beq skiptorusinit
        jsr creditsinit
skiptorusinit
        ;jsr palswap
        inc vscnt2
        lda vscnt2
        cmpa #3
        bne actualendiswear

        ;DBGPAL
        clr vscnt2

        jsr torusdraw
        jsr toruscopy2
        ldx torusgfxaddr
        leax 512,x
        ;DBGPAL
        cmpx #torusgfxend
        bne torusend
        ldx #torusgfx
torusend
        stx torusgfxaddr
actualendiswear
        rts

torusdraw
        ldx torusgfxaddr
        ldy #$400
        clr xcnt
toruscopy
        ldd ,x++    ;only one increment for other cool effect
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #8
        bne torusskipreset
        leay 16,y
        clr xcnt
torusskipreset
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
        bne torusskipreset2
        leax 16,x
        leay 16,y
        clr xcnt
torusskipreset2
        cmpx #$800
        bne toruscopy2lp
        rts

torusgfx
        includebin "torus/torus5.bin"
torusgfxend