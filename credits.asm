creditsmain
        ldx creditsaddr
        ldy #$7F0
        clr xcnt
creditslp1
        lda ,x+
        sta ,y+
        inc xcnt
        lda xcnt
        cmpa #16
        bne creditslp1
        clr xcnt
        rts

patchcredits
        ldd #$0000
        ldx #$7F0
patchcreditslp
        std ,x++
        cmpx #$800
        bne patchcreditslp
        rts

copycredits
        ldx #$400
        ldy #$3F0
        clr xcnt
        clr ycnt
copycreditslp1
        ldd ,x++
        std ,y++
        inc xcnt
        lda xcnt
        cmpa #8
        bne copycreditslp1
        clr xcnt
        inc ycnt
        ;leax 16,x          ;it took me 4 hours to realise
        ;leay 16,y          ;why i didn't need to do this
        lda ycnt
        cmpa #64
        bne copycreditslp1
        rts

credits
        inc vscnt2
        lda vscnt2
        cmpa #6
        bne creditsend
        clr vscnt2
        lda creditsflag
        cmpa #0
        beq docredits
        jsr creditsinit
        clr creditsflag
docredits
        jsr creditsmain
        ldx creditsaddr
        cmpx #creditsgfxend-16
        beq skipscreditsreset
        jsr copycredits
        jsr patchcredits
        ldx creditsaddr
        leax 16,x
        stx creditsaddr
        ldx creditsaddr
        cmpx #creditsgfxend-16
        beq skipscreditsreset
        bra creditsend
skipscreditsreset
        ldx #creditsgfxend-16
        stx creditsaddr
creditsend
        rts

creditsgfx
        includebin "gfx/creditsgreets.bin"
creditsgfxend