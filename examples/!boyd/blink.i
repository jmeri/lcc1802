; generated by lcc-xr18NW $Version: 5.0 - XR18NW $ on Fri Apr 07 08:14:26 2017
SP:	equ	2 ;stack pointer
memAddr: equ	14
retAddr: equ	6
retVal:	equ	15
regArg1: equ	12
regArg2: equ	13
	listing off
	RELAXED ON
;definitions and prolog functions needed for smc1802 programs (Hi Bill)
;dec 21 packaged version for the christmas compiler (Ho Ho Ho)
;Dec 24 fixed shift macros to use memaddr as a work register and not corrupt the shift count
;jan 6 fixed shift left macro as above
;jan 11 saving as lcc1802epiloNG.inc for the NG compiler
;jan 12 minor correction to rldmi
;jan 14 minor correction to ldi4
;jan 16 adding shri4I
;jan20 correct error in shl2r
;jan21 moved 4 byte macros to bottom and added shrc4
;Jan 28 archived before beginning work on Birthday Compiler
;Feb 7 adding nointerrupts/interrupts to control interruptability
;Feb 13 changing address mode macros
;Feb 14 removing nointerrupts, adding reserve/release for stack frame, ld2z macro
;Mar 3 changing reserve/release to use inc/dec for 8 or less bytes
;Mar 4 adding incm macro for multiple increments
;mar 5 adding jzi2 macro to speed up if processing
;mar 6 adding ldn1, str1 for register indirect addressing
;mar 17 adding decm macro
;mar 28 adding jumpv macro
;may 15 adding jnzu1, jzu1 macros
;june 21 adding demote macro
;Oct 2, 2013 DH version for dhrystone optimization 
;Oct 2, 2013 added str2 macro 2 byte store at addr pointed to by register
;oct 4,	added st2i 2 byte immediate sore, pushf,pushm,pushl sequences, 
;oct 24, added ldaXs for stack pointed addresses, added mvcn1, mvc1 for 1 byte storage to storage moves, jneu1i for single byte immediate compare
;Feb 17 2014 added "inc sp" to restore stack pointer in jeqI1, affected strncmp.
;Feb 18 2017 added org to LCCCODELOC to allow for non-zero origin
;Feb 19 2017 beginning to adapt for 1806
;17-03-06 remove inc/dec from ccall, cretn6, add inc to popr
;17-03-07 add popf,popm,popl for optimization
;17-03-14 removed savemi, rldmi,cretn6
;17-03-27 added jequ1i
	org	LCCCODELOC	;wjr 17-02-18 allow code relocation
R0:	equ	0
R1:	equ	1
R2:	equ	2
R3:	equ	3
R4:	equ	4
R5:	equ	5
R6:	equ	6
R7:	equ	7
R8:	equ	8
R9:	equ	9
R10:	equ	10
R11:	equ	11
R12:	equ	12
R13:	equ	13
R14:	equ	14
R15:	equ	15
RL0:	equ	1 ;long register pairs are identified by their odd numbered register
RL6:	equ	7 
RL8:	equ	9 ;temp 1
RL10:	equ	11;temp 2
RL12:	equ	13 ;return value register for longs
Rp1p2:	equ	13 ;argument register for longs
Rt1:	equ	8  ;1st temp register
Rt2:	equ	9  ;2nd temp register
RCALL:	equ 	4 ;standard call routine
RRET:	equ 	5 ;standard return register
RPC:	equ 	3 ; standard program counter
;	listing	off
	macexp off	;this seems to have to go before the definitions
;macro definitions
;more natural 1802 macros
	listing	on
	lbr	lcc1802Init
	listing on
_PIN4:
	db 0
_test:
	db 15
	db 15
	db 15
	db 15
	db 5
	db 0
	db 8
	db 1
;$$function start$$ _main
_main: ;copt is peeping your size 2 frame with oct 23 rules
;{
;	asm(" req\n seq\n"
 req
 seq
 dec 2
 out 7
 req
        RLDI    R11,_TEST
        RLDI    R10,8
 sex 11
 out 7
 out 7
 out 7
 out 7
 out 7
 out 7
 out 7
 out 7
 br $
;}
L1:
        sret    6
;$$function end$$ _main
;lcc1802Epilog.inc initialization and runtime functions needed for lcc1802 programs
;Dec 21 2012 - out5/putc moved to separate putc.inc for christmas compiler
;this is the version published with the lcc1802121229 release
;jan 1 2013 incleasing stack beginning lcation to 3fff (16K)
;jan 2 removed test routines, moved code not needing short branches to before the align 256
;jan 11 going back to SCRT conventions for NG compiler
;Jan 21 adding _mulu4 32 bit multiplication - really s.b. mulI4
;Jan 28 archived before beginning work on Birthday Compiler
;Feb 5 dubdab algorithm being brought in for ltoa itoa
;Feb 12 fixed bugs in modi2/u2
;feb 27 changed stack to start at 7fff
;mar 3, 2013 saved as epiloNO for optimization round
;mar 28,2013 - LCCepilofl.inc changes scrt to standard big-endian stack
;april 4 adding digit count argument to dubdabx
;Oct 2, 2013 redoing mulu2 for faster results with small arg1 - dhrystone
;oct 12 divu2 redone for faster perf on small numbers, remainder now in regarg1 - modu2/modi2 changed to match
;16-09-20 allow stack relocation 
;16-11-26 calculate onems delay from cpu speed in LCC1802CPUSPEED
;17-03-07 adjusting stack offset for 1805/6 stack discipline
;17-03-13 protecting work areas in divi2,divi4 routines from 1806 SCAL
;17-03-15 onems compensates for reduced subroutine overhead in 1806
rwork	equ	memAddr	;work register
lcc1802init:	
        RLDI    RCALL,$$_DIE
        RLDI    RRET,$$_DIE
        RLDI    SP,LCCSTACKLOC
	sex	SP
        RLDI    RPC,$$_00000
	sep	RPC
$$_00000:
        SCAL    6
        dw      _MAIN
$$_die:	lbr	$$_die		;loop here when main returns
	db	0xde,0xad
;the following routines don't have short jumps and don't need to worry about alignment
_setqOn:
	seq
        sret    6
_setqOff:
	req
        sret    6
_modU2:	;16 bit unsigned remainder
	; just calls the 16 bit division then puts remainder into return value
        SCAL    6
        dw      _DIVU2
    glo regArg1
    plo retVal
    ghi regArg1
    phi retVal
        sret    6
_modI2:	;16 bit signed remainder
	; just calls the 16 bit division then puts remainder into return value
        SCAL    6
        dw      _DIVI2
    glo regArg1
    plo retVal
    ghi regArg1
    phi retVal
        sret    6
_out4:	
	glo	regArg1
	dec	sp
	str	sp
	out	4
        sret    6
;the following routines have short branches so all the code has to stay within the same page
	align 256
;Standard Call routine invoked as D4xxxx - big-endian stack convention
	sep     R3 ;go to subroutine
_call	sex	SP ;make sure X=SP
	glo	retAddr ;save previous return pointer on stack
	dec	sp
	stxd
	ghi	retAddr
	str	sp	
	glo	RPC ;copy old PC to retAddr
	plo	retAddr
	ghi	RPC
	phi	retAddr
	lda	retAddr ;pick up subroutine address into RPC
	phi	RPC
	lda	retAddr
	plo	RPC
	br	_call-1
;Standard subroutine return 
	sep	RPC	;return to the original program
_return	glo	retAddr	;transfer the current return address to RPC
	plo	RPC
	ghi	retAddr
	phi	RPC
	lda	SP	;pick up old return address
	phi	retAddr
	lda	SP
	plo	retAddr
	br	_return-1
_oneMs:		;execute 1ms worth of instructions including call(15)/return(10) sequence. takes about 1 ms
;subroutine overhead soaks up 27 instruction time.
;each loop is 2 instruction times
;so the number of loops needed is 
;CPU speed/16000 less the 27 all divide by two
LCC1802CPUSPEED EQU 1600000	;1.6MHZ default
LCC1802SUBOVHD  EQU 14		;1806 SCAL/SRET subroutine overhead
	ldi	(LCC1802CPUSPEED/1000/16-LCC1802SUBOVHD)/2
$$mslp:	smi	1
	bnz	$$mslp
        sret    6
;16 bit right shifting multiply which is faster for smaller operands
; credit to http://map.grauw.nl/articles/mult_div_shifts.php#lrmultr
_mulU2:		;retval(product)=regarg1(multiplicand)*regarg2(multiplier)
        ldi     0
        plo     RETVAL
        phi     RETVAL
$$mulrlp:
        ghi     REGARG2
        shr
        phi     REGARG2
        glo     REGARG2
        shrc
        plo     REGARG2
	bnf $$mulrnoadd
;	bottom bit of multiplier is one so add multiplicand to product
        glo     REGARG1
        str     sp
        glo     RETVAL
        ADD             ;calculate the low order byte
        plo     RETVAL
        ghi     REGARG1
        str     sp
        ghi     RETVAL
        ADC             ;calculate the high byte
        phi     RETVAL
$$mulrnoadd:
	ghi regarg2	;check for all bits of multiplier shifted out
	bnz $$mulrshft	;nope, continue
	glo regarg2	;check bottom byte
	bz $$mulrdone
$$mulrshft:
        glo     REGARG1
        shl
        plo     REGARG1
        ghi     REGARG1
        shlc
        phi     REGARG1
	br $$mulrlp
$$mulrdone:		;here the product is in retval
        sret    6
;this is a divisor shifting algorithm which is faster for smaller operands
;credit to http://research.microsoft.com/pubs/70645/tr-2008-141.pdf
;changed oct 12 to save R10 & 1/2 R11 on stack
_divu2: ;retval=regarg1(x or dividend)/regarg2(y or divisor)
	;uses R14(rwork) to hold original divisor y0, 
	;regarg1 to hold develop remainder, 
	;R10 to hold working dividend R11.0 as a temp
        dec     sp
        glo     R10
        stxd
        ghi     R10
        stxd
	glo R11		;and bottom
	stxd		;of R11 - leaves stack clear of work area
        glo     REGARG1
        plo     R10
        ghi     REGARG1
        phi     R10
        ldi     0
        plo     RETVAL
        phi     RETVAL
        glo     REGARG2
        plo     RWORK
        ghi     REGARG2
        phi     RWORK
                                ;result in D, rwork.hi, DF
        glo REGARG2
        str sp
        glo R10
        sm
        plo R11
        ghi REGARG2
        str sp
        ghi R10
        smb
	bnf $$computequot	;DF=0 means it didn't fit
	phi R10	;R10=R10-regarg2
	glo R11
	plo R10
$$again:	;this is the divisor doubling phase
                                ;result in D, rwork.hi, DF
        glo REGARG2
        str sp
        glo R10
        sm
        plo R11
        ghi REGARG2
        str sp
        ghi R10
        smb
 	bnf $$computequot	;df=0 means it didn't fit
	phi R10	;R10=R10-regarg2
	glo R11
	plo R10 	
        glo     REGARG2
        shl
        plo     REGARG2
        ghi     REGARG2
        shlc
        phi     REGARG2
 	br $$again
 $$computequot:	;here we're computing the quotient
                                ;result in D, rwork.hi, DF
        glo REGARG2
        str sp
        glo REGARG1
        sm
        plo R11
        ghi REGARG2
        str sp
        ghi REGARG1
        smb
 	bnf $$testexit
 	phi regarg1		;complete the subtraction
 	glo R11
 	plo regarg1
 	inc retval
 $$testexit:
 	ghi rwork
 	sm	;top of regarg2 is still on stack
 	bnz $$ney0y
 	glo regarg2
 	str sp
 	glo rwork
 	sm	;test low order bytes
 	bz	$$out	;if = we're done
 $$ney0y:
        glo     RETVAL
        shl
        plo     RETVAL
        ghi     RETVAL
        shlc
        phi     RETVAL
        ghi     REGARG2
        shr
        phi     REGARG2
        glo     REGARG2
        shrc
        plo     REGARG2
 	br $$computequot	;continue
 $$out:
 ;here the quotient is in retval, remainder in regarg1
  	inc sp	;release work area
	lda sp	;recover
	plo R11	;bottom byte of R11
        inc     sp
        lda     sp
        phi     R10
        ldn     sp
        plo     R10
        sret    6
;signed integer division retVal=regArg1/regArg2, remainder in regArg1
;uses unsigned division of absolute values then negates the quotient if the signs were originally different
_divI2:
    dec	sp	;leave a work area available
    ghi regArg1
    str sp	;save the sign of the 1st arg
    shl
    bnf $$pos1	;if the 1st arg is -v
        glo     REGARG1                     ;(flip all the bits and add 1)
        xri     0xff
        plo     REGARG1
        ghi     REGARG1
        xri     0xff
        phi     REGARG1
        inc     REGARG1
$$pos1: ;1st is now +v, check 2nd
    ghi regArg2
    xor	
    str sp ;the stack now has bit 8 set if the signs are different
    ghi regArg2
    shl
    bnf $$pos2	;if the 2nd arg is -v
        glo     REGARG2                     ;(flip all the bits and add 1)
        xri     0xff
        plo     REGARG2
        ghi     REGARG2
        xri     0xff
        phi     REGARG2
        inc     REGARG2
$$pos2: ; both args now +v
    dec sp	;protect workarea on the 1802
        SCAL    6
        dw      _DIVU2
    inc sp	;recover work area
;now the quotient is in retVal and the remainder is in regArg2
    lda	sp ;get back the sign bits and restore SP
    shl
    bnf $$done ;if the signs were different
        glo     RETVAL                     ;(flip all the bits and add 1)
        xri     0xff
        plo     RETVAL
        ghi     RETVAL
        xri     0xff
        phi     RETVAL
        inc     RETVAL
$$done:
        sret    6
	align 256    ;32 bit operations follow
_divu4:
;This is an unsigned 32 bit restoring division
;The arguments are in RL8 and RL10, the result RL8/RL10 is in RL8, and the remainder is in Rp1p2
;Rp1p2:RL8 form a 64 bit work area A:Q
;the dividend, in RL10 is repeatedly combined with the top 32 bits and the two shifted left
;the algorithm is described in http://www2.informatik.hu-berlin.de/~rok/ca/TEMP/CA_2000/engl/ca12/ca12_1-4.pdf
	ldi 32		;set loop count
	plo memaddr	;in temp register
        ldi     (0)&255
        plo     RP1P2
        ldi     ((0)>>8)&255; 
        phi     RP1P2
        ldi     ((0)>>16)&255; 
        plo     RP1P2-1
        ldi     ((0)>>24)&255; 
        phi     RP1P2-1
$$loop:
        glo     RL8     ;start with low byte of second register
        shl             ;shift left once
        plo     RL8     ; save it
        ghi     RL8     ;high byte of second RL8
        shlc            ;shift one bit carrying
        phi     RL8     ;save it
        glo     RL8-1   ;now the bottom byte of top RL8
        shlc
        plo     RL8-1
        ghi     RL8-1   ;finally the top byte of the high order RL8
        shlc            ;gets the last shift
        phi     RL8-1   ;and we're done
        glo     RP1P2     ;start with low byte of second register
        shlc            ;shift left once continuing carry
        plo     RP1P2     ; save it
        ghi     RP1P2     ;high byte of second RP1P2
        shlc            ;shift one bit carrying
        phi     RP1P2     ;save it
        glo     RP1P2-1   ;now the bottom byte of top RP1P2
        shlc
        plo     RP1P2-1
        ghi     RP1P2-1   ;finally the top byte of the high order RP1P2
        shlc            ;gets the last shift
        phi     RP1P2-1   ;and we're done
        dec     sp ;make a work ares
        glo     RL10    ;long register pairs are addressed by their second member
        str     sp      ;so arithmetic operations start there
        glo     RP1P2
        SM             ;calculate the low order byte
        plo     RP1P2
        ghi     RL10
        str     sp
        ghi     RP1P2
        SMB             ;calculate the second byte
        phi     RP1P2
        glo     RL10-1
        str     sp
        glo     RP1P2-1
        SMB             ;calculate the third byte
        plo     RP1P2-1
        ghi     RL10-1
        str     sp
        ghi     RP1P2-1
        SMB             ;calculate the high byte
        phi     RP1P2-1
        inc     sp      ;release the work area
	ani 0x80	;check the top bit
	bz $$norestore	;if it's 0
		glo RL8
		ani 0xfe	;turn off the bottom bit
		plo RL8
        dec     sp ;make a work ares
        glo     RL10    ;long register pairs are addressed by their second member
        str     sp      ;so arithmetic operations start there
        glo     RP1P2
        ADD             ;calculate the low order byte
        plo     RP1P2
        ghi     RL10
        str     sp
        ghi     RP1P2
        ADC             ;calculate the second byte
        phi     RP1P2
        glo     RL10-1
        str     sp
        glo     RP1P2-1
        ADC             ;calculate the third byte
        plo     RP1P2-1
        ghi     RL10-1
        str     sp
        ghi     RP1P2-1
        ADC             ;calculate the high byte
        phi     RP1P2-1
        inc     sp      ;release the work area
	br $$endlp 	;else
$$norestore:
		glo RL8
		ori 1	;turn on the bottom bit
		plo RL8
	;end if
$$endlp:
	dec memaddr	;check the cycle count
	glo memaddr
	bnz $$loop	;back for more if needed
        sret    6
_mulu4:
	;this is a 32 bit signed multiplication using booth's algorithm
	;much thanks to David Schultz for the code and Charles Richmond for help with the algorithm
	;input is in register pairs R8:R9 and R10:R11 (called RL8 and RL10)
	;output is in R8:R9, with the top 32 bits in r12:13 (called Rp1p2)
	;the bottom byte of memaddr is used as a cycle count
	;initially	R12:13=0,	R8:R9=operand 1, DF=0
	;for 32 cycles we check the low bit of R8:R9 and DF
	;for 01 we add the R10:R11 to R12:13 and shift the whole 64 bits right once into DF
	;for 10 we subtract and shift
	;for 00 and 11 we just shift
        ldi     (0)&255
        plo     RP1P2
        ldi     ((0)>>8)&255; 
        phi     RP1P2
        ldi     ((0)>>16)&255; 
        plo     RP1P2-1
        ldi     ((0)>>24)&255; 
        phi     RP1P2-1
    ldi 32
    plo memaddr		;cycle count
    adi 0		;clear df
$$mloop:
    glo RL8
    ani 1		;isolate bottom bit of result
    bnf	$$check_sub	;
    bnz	$$shift		;that would be the 11 case
;this is case 01: add second operand to top 32 bits and shift all 64 bits right
        dec     sp ;make a work ares
        glo     RL10    ;long register pairs are addressed by their second member
        str     sp      ;so arithmetic operations start there
        glo     RP1P2
        ADD             ;calculate the low order byte
        plo     RP1P2
        ghi     RL10
        str     sp
        ghi     RP1P2
        ADC             ;calculate the second byte
        phi     RP1P2
        glo     RL10-1
        str     sp
        glo     RP1P2-1
        ADC             ;calculate the third byte
        plo     RP1P2-1
        ghi     RL10-1
        str     sp
        ghi     RP1P2-1
        ADC             ;calculate the high byte
        phi     RP1P2-1
        inc     sp      ;release the work area
    br $$shift
$$check_sub:
    bz $$shift	;that would be the 00 case
;this is case 10: subtract 2nd operand from top 32 bits then shift right
        dec     sp ;make a work ares
        glo     RL10    ;long register pairs are addressed by their second member
        str     sp      ;so arithmetic operations start there
        glo     RP1P2
        SM             ;calculate the low order byte
        plo     RP1P2
        ghi     RL10
        str     sp
        ghi     RP1P2
        SMB             ;calculate the second byte
        phi     RP1P2
        glo     RL10-1
        str     sp
        glo     RP1P2-1
        SMB             ;calculate the third byte
        plo     RP1P2-1
        ghi     RL10-1
        str     sp
        ghi     RP1P2-1
        SMB             ;calculate the high byte
        phi     RP1P2-1
        inc     sp      ;release the work area
$$shift:
        ghi     RP1P2-1   ;long RP1P2 pairs start at RP1P2-1
        shl             ;set DF to the sign
        ghi     RP1P2-1   ;get the top byte back
        shrc            ;shift one bit extending the sign
        phi     RP1P2-1
        glo     RP1P2-1
        shrc
        plo     RP1P2-1
        ghi     RP1P2     ;get the top byte of the low order RP1P2
        shrc            ;shift one bit extending the sign
        phi     RP1P2
        glo     RP1P2     ;finish with the low byte of the 2nd RP1P2 of the pair
        shrc
        plo     RP1P2
        ghi     RL8-1   ;long RL8 pairs start at RL8-1
        shrc            ;shift one bit extending the sign
        phi     RL8-1
        glo     RL8-1
        shrc
        plo     RL8-1
        ghi     RL8     ;get the top byte of the low order RL8
        shrc            ;shift one bit extending the sign
        phi     RL8
        glo     RL8     ;finish with the low byte of the 2nd RL8 of the pair
        shrc
        plo     RL8
    dec memaddr		;cycle count
    glo memaddr
    bnz $$mloop		;repeat cycle once for each bit position
        sret    6
	align 256
;signed integer division RL8=RL8/RL10, remainder in Rp1p2
;uses unsigned division of absolute values then negates the quotient if the signs were originally different
_divI4:
    dec	sp	;leave a work area available
    ghi RL8-1	;get the top of the dividend
    str sp	;save the sign of the 1st arg
    shl
    bnf $$pos1	;if the 1st arg is -v
        glo     RL8    ;long regs are equated to the second reg which has the low order word 
        XRI     (0XFFFFFFFF)&255
        plo     RL8
        ghi     RL8
        XRI     ((0XFFFFFFFF)>>8)&255; 
        phi     RL8
        glo     RL8-1
        XRI     ((0XFFFFFFFF)>>16)&255; 
        plo     RL8-1
        ghi     RL8-1
        XRI     ((0XFFFFFFFF)>>24)&255; 
        phi     RL8-1
        glo     RL8    ;long regs are equated to the second reg which has the low order word 
        ADI     (1)&255
        plo     RL8
        ghi     RL8
        ADCI     ((1)>>8)&255; 
        phi     RL8
        glo     RL8-1
        ADCI     ((1)>>16)&255; 
        plo     RL8-1
        ghi     RL8-1
        ADCI     ((1)>>24)&255; 
        phi     RL8-1
$$pos1: ;1st is now +v, check 2nd
    ghi RL10-1
    xor	
    str sp ;the stack now has bit 8 set if the signs are different
    ghi RL10-1
    shl
    bnf $$pos2	;if the 2nd arg is -v
        glo     RL10    ;long regs are equated to the second reg which has the low order word 
        XRI     (0XFFFFFFFF)&255
        plo     RL10
        ghi     RL10
        XRI     ((0XFFFFFFFF)>>8)&255; 
        phi     RL10
        glo     RL10-1
        XRI     ((0XFFFFFFFF)>>16)&255; 
        plo     RL10-1
        ghi     RL10-1
        XRI     ((0XFFFFFFFF)>>24)&255; 
        phi     RL10-1
        glo     RL10    ;long regs are equated to the second reg which has the low order word 
        ADI     (1)&255
        plo     RL10
        ghi     RL10
        ADCI     ((1)>>8)&255; 
        phi     RL10
        glo     RL10-1
        ADCI     ((1)>>16)&255; 
        plo     RL10-1
        ghi     RL10-1
        ADCI     ((1)>>24)&255; 
        phi     RL10-1
$$pos2: ; both args now +v
    dec sp	;protect workarea on the 1802
        SCAL    6
        dw      _DIVU4
    inc sp	;recover work area
;now the quotient is in RL8 and the remainder is in Rp1p2
    lda	sp ;get back the sign bits and restore SP
    shl
    bnf $$done ;if the signs were different
        glo     RL8    ;long regs are equated to the second reg which has the low order word 
        XRI     (0XFFFFFFFF)&255
        plo     RL8
        ghi     RL8
        XRI     ((0XFFFFFFFF)>>8)&255; 
        phi     RL8
        glo     RL8-1
        XRI     ((0XFFFFFFFF)>>16)&255; 
        plo     RL8-1
        ghi     RL8-1
        XRI     ((0XFFFFFFFF)>>24)&255; 
        phi     RL8-1
        glo     RL8    ;long regs are equated to the second reg which has the low order word 
        ADI     (1)&255
        plo     RL8
        ghi     RL8
        ADCI     ((1)>>8)&255; 
        phi     RL8
        glo     RL8-1
        ADCI     ((1)>>16)&255; 
        plo     RL8-1
        ghi     RL8-1
        ADCI     ((1)>>24)&255; 
        phi     RL8-1
$$done:
        sret    6
_dubdabx:	
;experimental binay-ascii conversion using the double-dabble algorithm
;thanks to Charles Richmond for the suggestion and code
;long interger is passed in rp1p2
;buffer pointer is passed at sp+2+4**+1 for 1806
;a pointer to the 1st non-zero byte in the buffer is passed back in r15
;r8-11 are used as temps
;r8 is the working pointer
;r15.0 is bit count(32) and the return value register
;r9.0 is digit count
;r10 is the number of digits wanted in the result including leading 0's - 0 means no leading 0's
        glo     SP
        adi     ((2+4+1))#256
        plo     MEMADDR
        ghi     SP
        adci    ((2+4+1))>>8; was/256
        phi     MEMADDR
        lda     memAddr
        phi     R8
        ldn     memAddr
        plo     R8
        glo     SP
        adi     ((2+4+2+1))#256
        plo     MEMADDR
        ghi     SP
        adci    ((2+4+2+1))>>8; was/256
        phi     MEMADDR
        lda     memAddr
        phi     R10
        ldn     memAddr
        plo     R10
        glo     R8
        plo     R15
        ghi     R8
        phi     R15
	ldi 11	;digit count+1 for trailing 0
	plo r9
$$clrlp:	;clear the passed buffer
	ldi 0	
	str r8	;clear a byte
	inc r8
	dec r9
	glo r9	;check the count
	bnz $$clrlp ;back for more
        glo     R15
        plo     R8
        ghi     R15
        phi     R8
	ldi 32	;bit count
	plo r15
;now i'm going to spin off any leading 0's in the binary number
$$cktop:
	ghi rp1p2-1	;get the top bit of the number
	shl		;check for a 1
	bdf $$bitloop	;move on if we have one
        glo     RP1P2     ;start with low byte of second register
        shl             ;shift left once
        plo     RP1P2     ; save it
        ghi     RP1P2     ;high byte of second RP1P2
        shlc            ;shift one bit carrying
        phi     RP1P2     ;save it
        glo     RP1P2-1   ;now the bottom byte of top RP1P2
        shlc
        plo     RP1P2-1
        ghi     RP1P2-1   ;finally the top byte of the high order RP1P2
        shlc            ;gets the last shift
        phi     RP1P2-1   ;and we're done
	dec r15		;reduce the number of times to shift
	glo r15
	bnz $$cktop	;
	inc r15		;our whole number was 0 but force at least one pass
$$bitloop:
	ldi 10	;digit count
	plo r9
$$dcklp:
	ldn r8 	;pick up a digit
	smi 5	;see if it's greater than 4
	bnf $$dnoadd ;if not, bypass add
	adi 0x08	;add the 5 black and 3 more
	str r8	;put it back
$$dnoadd:
	inc r8
	dec r9	;decrement digit count
	glo r9
	bnz $$dcklp ;and back for next digit
        glo     RP1P2     ;start with low byte of second register
        shl             ;shift left once
        plo     RP1P2     ; save it
        ghi     RP1P2     ;high byte of second RP1P2
        shlc            ;shift one bit carrying
        phi     RP1P2     ;save it
        glo     RP1P2-1   ;now the bottom byte of top RP1P2
        shlc
        plo     RP1P2-1
        ghi     RP1P2-1   ;finally the top byte of the high order RP1P2
        shlc            ;gets the last shift
        phi     RP1P2-1   ;and we're done
	ldi 10	;load the digit count again
	plo r9
;r8 is now just past the units location and ready to walk back
$$dshlp:
	dec r8	;walk back from 0's position
	ldn r8	;get the digit back
	shlc	;continue the shift
	phi r15 ;save it for the carry test
	ani 0x0f ;clear the 10 bit
	str r8	;put the digit back
	ghi r15	;now test for carry
	smi 0x10 ; this will make df 1 if the 10 bit is set
	dec r9	;decrement the digit count
	glo r9
	bnz $$dshlp ;back for more if needed
	dec r15
	glo r15
	bnz $$bitloop
        glo     R8
        plo     R15
        ghi     R8
        phi     R15
	ldi 10		;digit count again
	plo r9
$$upnxt:
	ldn r8		;get digit
	ori 0x30	;make ascii
	str r8		;put it back
	inc r8		;next digit
	dec r9		;counter
	glo r9
	bnz $$upnxt	;upgrade all 10 spots
        glo     SP
        adi     ((2+4+2+1+1))#256
        plo     MEMADDR
        ghi     SP
        adci    ((2+4+2+1+1))>>8; was/256
        phi     MEMADDR
	sex memaddr	;set up
	ldi 10		;max number of 0's to skip
	sm		;desired number of digits to skip
	sex sp		;reset index register
	plo r9		;number of leading 0's to skip
$$cknext:
	ldn r15		;check digit
	smi 0x30	;for '0'
	bnz $$done
	inc r15		;next digit
	dec r9		;reduce count
	glo r9
	bnz $$cknext
$$done:
        sret    6
_modU4:	;32 bit unsigned remainder
	; just calls the 32 bit division then puts remainder into return value
        SCAL    6
        dw      _DIVU4
        glo     RP1P2
        plo     RL8
        ghi     RP1P2
        phi     RL8
        glo     RP1P2-1
        plo     RL8-1
        ghi     RP1P2-1
        phi     RL8-1
        sret    6
_modI4:	;32 bit signed remainder
	; just calls the 32 bit division then puts remainder into return value
        SCAL    6
        dw      _DIVI4
        glo     RP1P2
        plo     RL8
        ghi     RP1P2
        phi     RL8
        glo     RP1P2-1
        plo     RL8-1
        ghi     RP1P2-1
        phi     RL8-1
        sret    6
;IO1802.inc contains input/output runtime routines for LCC1802
;The port is in regArg1, the output byte is in regArg2
	align 64
_putc:
_out5:	
	glo	regArg1
	dec	sp
	str	sp
	out	5
        sret    6
_inp:		;raw port input
		;stores a small tailored program on the stack and executes it
	dec	sp	;work backwards
	ldi	0xD3	;return instruction
	stxd		
	glo	regarg1	;get the port number
	ani	0x07	;clean it
	bz	+	; inp(0) isn't valid
	ori	0x68	;make it an input instruction
	stxd		;store it for execution
        glo     SP
        plo     RT1
        ghi     SP
        phi     RT1
	inc	rt1	;rt1 points to the 6x instruction
	sep	rt1	;execute it
;we will come back to here with the input byte in D
	inc	sp	;step over the work area
	plo	retVal	;save it to return
	ldi	0
	phi	retval	;clear top byte
+	inc	sp	;need to get rid of the 6x instruction
	inc	sp	;and the D3
        sret    6
_out:		;raw port output
		;stores a small tailored program on the stack and executes it
		;this could be bolder:
		;store the program as 6x cc D5 where x is the port number and cc is the char
		;then SEP sp
		;the D5 would return to the calling program and finish fixing the stack.
		;saves 6 instructions but it's a bit tricky.
	dec	sp	;work backwards
	ldi	0xD3	;return instruction
	stxd		
        glo     SP
        plo     RT1
        ghi     SP
        phi     RT1
	glo	regarg1	;get the port number
	ani	0x07	;clean it
	ori	0x60	;make it an out instruction - 60 is harmless
	stxd		;store it for execution
	glo	regarg2	;get the byte to be written
	str	sp	;store it where sp points
	sep	rt1	;execute it
;we will come back to here with sp stepped up by one
+	inc	sp	;need to get rid of the 6x instruction
	inc	sp	;and the D3
        sret    6
