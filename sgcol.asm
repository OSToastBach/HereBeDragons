sgcolmain
        clr xcnt
sgcolmainlp1
        ldd ,x++
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #16
        bne sgcolmainlp1
        rts

multicolour
        lda vscnt
        cmpa #20
        bne skipmulticolour
        clr vscnt
        inc sceneval
        jsr scrollinit
        ldy charindex
        leay 1,y
        sty charindex
        bra multicolourend
skipmulticolour
        lda sgcolflag
        cmpa #0
        beq dosgcol
        clr sgcolflag
        jsr sgcolinit
dosgcol
        inc vscnt2
        lda vscnt2
        cmpa #4
        bne multicolourend
        clr vscnt2
        ldy multiclraddrdst
        cmpy #$1000
        beq multicolourend
        ldx multiclraddrsrc
        ldy multiclraddrdst
        jsr sgcolmain
        stx multiclraddrsrc
        sty multiclraddrdst
multicolourend
        rts

sgcolimg
        includebin "gfx/11col.bin"