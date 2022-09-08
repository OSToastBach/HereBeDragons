copysheep
        ldx sheepgfxaddr
        ldy #$460
        clr xcnt
        clr ycnt
copysheeplp
        lda ,x+
        sta ,y
        leay 1,y
        inc xcnt
        lda xcnt
        cmpa #16
        bne copysheeplp
        leay 48,y
        clr xcnt
        inc ycnt
        lda ycnt
        cmpa #12
        bne copysheeplp
        rts

copysheepscrn
        ldx #$4A0
        ldy #$4B0
        clr xcnt
        clr ycnt
copysheepscrnlp
        ldd ,x++
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #24
        bne copysheepscrnlp
        clr xcnt
        inc ycnt
        leax 16,x
        leay 16,y
        lda ycnt
        cmpa #12
        bne copysheepscrnlp
        rts

sheepmain
        lda vscnt
        cmpa #15
        bne skipsheep
        clr vscnt
        inc sceneval
        bra sheepend
skipsheep
        lda sheepflag
        cmpa #0
        beq dosheep
        jsr sheepinit
dosheep
        jsr copysheepscrn
        inc vscnt2
        lda vscnt2
        cmpa #2
        bne sheepend
        clr vscnt2
        jsr copysheep
        ldx sheepgfxaddr
        leax 192,x
        cmpx #sheepgfxend-32
        bne skipgfxreset
        ldx #sheepgfx
        stx sheepgfxaddr
skipgfxreset
        stx sheepgfxaddr
sheepend
        rts

sheepgfx
    ;includebin "voxel/sheeplong1.bin"
    ;includebin "voxel/sheeplong2.bin"
    ;includebin "voxel/sheeplong3.bin"
    includebin "voxel/sheep5.bin"
    ;includebin "voxel/sheep6.bin"
sheepgfxend