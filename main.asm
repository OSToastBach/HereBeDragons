;Here Be Dragons
;Slipstream 2022
;Released at NOVA 2022

;Code, Graphics and Music: TôBach
;Music: Nihilazo
;Graphics: Ando, RaccoonViolet

;made over the course of two months, powered by many thunderdome cd's and all-nighters :)


;notes:
;64x64 = 1024 bytes, start addr = $400, end addr = $800

;indirect fuckery cheese:
;with scroller load all text into one "string", inc scene once == 44, inc index, store away index, init value == 1
;when scroller needed again, restore index and continue scroller routine, clr init value

;scene order
;------------
;title screen
;scroller
;twister
;torus thing
;scroller
;11 colours thing
;scroller
;rotating sheep
;credits

        org 20

;varzz go here

sceneval        rmb 1

;twister vars
twistaddr       rmb 2
twistindex      rmb 2

;infoscrn vars
currchar        rmb 2

;scene stuffs
scenetim        rmb 2

px1             rmb 1
py1             rmb 1

;global varzzz
scnt            rmb 1
vscnt           rmb 1
vscnt2          rmb 1
xcnt            rmb 1
ycnt            rmb 1

;scroller vars
charaddr        rmb 2
stringadd       rmb 2
lettercnt       rmb 1
letteraddcnt    rmb 1
charindex       rmb 2
currstring      rmb 2
scrolltextval   rmb 1
scrollpos       rmb 2

;voxel sheep
sheepgfxaddr    rmb 2

;credits/greets
creditsaddr     rmb 2

;title
titlesrc        rmb 2
titledst        rmb 2

;multicolour
multiclraddrsrc rmb 2
multiclraddrdst rmb 2

;torus
torusgfxaddr    rmb 2

        org $1000

;main coedz
start

        ;lds #$3E00      ;set up stacks
        ;ldu #$3D00

        orcc #$50

        lda $ff23       ;set cassette output
        ora #%00001000
        sta $ff23

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

        clr xcnt
        clr ycnt
        clr scnt
        clr vscnt
        clr vscnt2
        clr sceneval
        clr lettercnt
        clr letteraddcnt
        clr scrolltextval

        lda #1
        sta twistflag
        sta infoflag
        sta sg12flag
        sta scrollflag1
        sta sheepflag
        sta creditsflag
        sta sgcolflag
        sta sineflag
        sta titleflag
        sta torusflag

        ldy #$0000
        sty twistindex
        sty stringadd
        sty charindex
        sty scenetim

        ldx #infostring
        stx currchar

        ldx #char_space
        stx charaddr

        ldx #sheepgfx
        stx sheepgfxaddr

        ldx #creditsgfx
        stx creditsaddr

        ldx #$480
        stx stringadd

        ldx #cygnetsong
        stx titlesrc

        ldx #sgcolimg
        stx multiclraddrsrc

        ldx #$400
        stx titledst
        stx multiclraddrdst

        ldx #string
        stx currstring

        ldx #torusgfx
        stx torusgfxaddr

        lda #9
        sta lettercnt

        inc sceneval

        ;clr $ffd7		;dangerous :)
        ;clr $ffd9              ;even more dangerous :)))

main
        ;do nothing until irq
        jmp main


irq_start
        lda $ff02       ;acknowledge interrupt

        inc scnt
        lda scnt
        cmpa #50        ;1 second, current second stored in vscnt
        bne skipsreset
        lda #0
        sta scnt
        inc vscnt
skipsreset

        ;jmp scenecheckend

framecheck
        ;ldx vscnt
        ;stx $400
        ;lda sceneval
        ;sta $402
framecheckend

scenecheck
        lda sceneval
        cmpa #1
        bne sskip1
        jsr titlescreen
        bra scenecheckend
sskip1
        cmpa #2
        bne sskip2
        jsr scrollmain
        bra scenecheckend
sskip2
        cmpa #3
        bne sskip3
        jsr infoscrnmain
        bra scenecheckend
sskip3
        cmpa #4
        bne sskip4
        jsr infoscrnend
        bra scenecheckend
sskip4
        cmpa #5
        bne sskip5
        jsr scrollmain
        bra scenecheckend
sskip5
        cmpa #6
        bne sskip6
        jsr twistmain
        bra scenecheckend
sskip6
        cmpa #7
        bne sskip7
        jsr torusmain
        bra scenecheckend
sskip7
        cmpa #8
        bne sskip8
        jsr scrollmain
        bra scenecheckend
sskip8
        cmpa #9
        bne sskip9
        jsr multicolour
        bra scenecheckend
sskip9
        cmpa #10
        bne sskip10
        jsr scrollmain
        bra scenecheckend
sskip10
        cmpa #11
        bne sskip11
        jsr sheepmain
        bra scenecheckend
sskip11
        ;jsr sheepmain
        ;jsr torusmain
        jsr credits

scenecheckend
        ;jsr scrollmain
        ;jsr titlescreen

irq_end
        ;ldx vscnt
        ;stx $400

        rti

DBGPAL	macro           ;check frame time
	lda $ff22
	eora #$18
	sta $ff22
	endm

;include all teh filezzz
        include "init.asm"
        include "titlescreen.asm"
        include "twister.asm"
        include "infoscreen.asm"
        include "pmode.asm"
        ;include "sg12test.asm"
        include "sgcol.asm"
        include "scroll.asm"
        include "torus.asm"
        include "voxelsheep.asm"
        include "credits.asm"

;less important vars - i know using a whole byte for a boolean is wasteful - i just cba bitmasking ;)
twistflag       rmb 1
infoflag        rmb 1
sg12flag        rmb 1
scrollflag1     rmb 1
scnrbaseval     rmb 1
sheepflag       rmb 1
creditsflag     rmb 1
sgcolflag       rmb 1
sineflag        rmb 1
titleflag       rmb 1
torusflag       rmb 1

        end start