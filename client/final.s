						;TO-CHECK:
						;		1) ROUNDING ERROR => 1 FOR UNACCURATE0.001, 2 FOR ROUNDING ERROR?
						;		make R3=M, not 0.5M => save 1 line


						;		;test_for_first_2
						;testPACKTRIPLET	DCD		0x2865459 ;hex is equavalent of BCD
						;testUNPACKTRIPLET	DCD		100999
						;		ldr		r1,=testUNPACKTRIPLET
						;		ldr		R1,[r1]
						;		BL		UNPACKTRIPLET
						;		end

						;testPACKTWORD	DCD		0x46546715,0x1315
						;		adr		r1,testPACKTWORD
						;		BL		PACKTWORD
						;		end

						;testUNPACKTWORD	FILL		4*2
						;testUNPACKTWORD_n	DCD		0x889112cb
						;		adr		R1,testUNPACKTWORD
						;		ldr		r0,=testUNPACKTWORD_n
						;		ldr		r0,[r0]
						;		BL		UNPACKTWORD
						;		end

						;testMULTRIPLE	DCD		500,550
						;		adr		r1,testMULTRIPLE
						;		ldr		r2,[r1,#4]
						;		ldr		r1,[r1]
						;		bl		MULTRIPLE
						;		end

						;====================	PART 2 TEST=================
						;A1		DCD	123,456 ;MSW -> LSW (FD)
						;B1		DCD	789,852
						;C1		FILL	4*4
						;		LDR	R0,=A1
						;		LDR	R1,=B1
						;		LDR	R2,=C1
						;		mov	r3,#2
						;		bl	MULTIPLY_T2
						;		end

						;A1		DCD	789,879,798,789 ;LSW	  -> MSW
						;B1		DCD	879,879,789,987 ;LS triple -> MS triple
						;C1		FILL	4*8

						;A1		DCD		741,789,456,123 ;LSW	  -> MSW
						;B1		DCD		520,410,963,852 ;LS triple -> MS triple
						;C1		FILL		4*8 ;320,475,907,333,429,124,304,105 (LS -> MS)

						;A1		DCD		456,123,741,789 ;LSW	  -> MSW
						;B1		DCD		520,410,963,852 ;LS triple -> MS triple
						;C1		FILL		4*8 ; 120 157 129 926 090 282 620 673(LS -> MS)

						;A1		DCD		456 ;LSW	  -> MSW
						;B1		DCD		520 ;LS triple -> MS triple
						;C1		FILL		4*8 ; 120 157 129 926 090 282 620 673(LS -> MS)

						;A1		DCD		456,123,741,789 ;LSW	  -> MSW
						;B1		DCD		520,410,963,852 ;LS triple -> MS triple
						;C1		FILL		4*8 ; 120 157 129 926 090 282 620 673(LS -> MS)

						;error	due to sub part?
						;A1		DCD		454,987,982,489,795,681,545,116 ;LSW	  -> MSW
						;B1		DCD		454,987,982,489,795,681,545,116 ;LS triple -> MS triple
						;C1		FILL		4*8 ;(LS -> MS)

						;116545681795489982987454	116545681795489982987454*116545681795489982987454 168984464445978979344678
						;A1		DCD		454,987,982,489,795,681,545,116, 454,987,982,489,795,681,545,116, 678,344,979,978,445,464,984,168 ,454,456,897,131,456,547,313,879, 464,486,754,897,133,987,863,974, 464,486,754,897,133,987,863,974, 564,654,456,766,467,437,684,861, 454,987,982,489,795,681,545,116 ;LSW	  -> MSW
						;B1		DCD		678,344,979,978,445,464,984,168, 454,987,982,489,795,681,545,116, 678,344,979,978,445,464,984,168 ,464,486,754,897,133,987,863,974, 864,834,725,464,546,456,121,789, 454,987,982,489,795,681,545,116, 464,486,754,897,133,987,863,974, 464,486,754,897,133,987,863,974 ;LS triple -> MS tripleC1						FILL		4*32 ;(LS -> MS)
						;C1		FILL		8*64
						;A1		DCD		454,987,982,489,795,681,545,116 ;LSW	  -> MSW
						;B1		DCD		678,344,979,978,445,464,984,168 ;LS triple -> MS triple
						;C1		FILL		4*8 ;812 669 615 085 001 034 842 274 686 606 356 702 621 409 694 019(LS -> MS)

						;A1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LSW	  -> MSW
						;B1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LS triple -> MS triple
						;C1		FILL		4*128 ;(LS -> MS)

						;A1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LSW	  -> MSW
						;B1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LS triple -> MS triple
						;C1		FILL		4*8 ;321,654,987,320,012,679,345,12 (LS -> MS)

;A1						DCD		705,839,705,865,892,708,751,852,701,840,763,881,722,770,839,835,776,811,768,839,805,733,810,789,723,883,872,735,848,820,824,753,795,751,756,753,874,755,849,724,790,749,806,894,845,822,721,740,889,803,879,878,714,795,763,740,835,846,842,882,894,813,762,866
;B1						DCD		893,726,846,838,888,785,791,722,773,865,778,900,715,788,877,864,899,821,855,855,889,796,735,839,818,847,797,846,878,734,821,733,863,838,776,809,831,745,812,870,797,876,761,704,863,776,827,849,810,879,811,795,712,734,749,757,749,820,787,741,890,782,807,858
;C1						FILL		4*128 ;321,654,987,320,012,679,345,12 (LS -> MS)
;
;						LDR		R0,=A1
;						LDR		R1,=B1
;						LDR		R2,=C1
;						SUB		r3,R1,R0
;						LSR		R3,R3,#2
;						BL		MULTIPLY
;						END
						;====PACKTRIPLET====
						;		INPUT is unchanged
						;In		R1: LS12 => 3BCD(C,B,A);	MS20 => any (should be 0)
						;Out		R0: LS10 => TCD;	MS22 => all0
						;Temp	R2,R3

						;get		10C+B
PACKTRIPLET				AND		R2,R1,#0xF00 	;8C
						AND		R3,R1,#0x0F0	;B
						LSR		R2,R2,#5
						ADD		R2,R2,R2,LSR #2 	;8C+2C
						ADD		R2,R2,R3,LSR #4	;10C+B
						;get		A+10(B+10C)
						AND		R3,R1,#0x00F	;A
						ADD		R3,R3,R2,LSL #1	;A+2(8C+2C)
						ADD		R0,R3,R2,LSL #3	;A+10(8C+2C)
						;end
						MOV		PC,LR

						;====UNPACKTRIPLET====
						;In		R1: LS10 => TCD;	MS22 => any
						;Out		R0: LS12 => 3BCD(C,B,A);	MS20 => all0
						;Temp	R2,R3

UNPACKTRIPLET				LSL		R1,R1,#22 ;{!!!!!!!!!! NOT FULLY OPTIMISED)
						LSR		R1,R1,#22
						;get		C by *1/100 est *0000001010 [2 line less than OP1 version]
						MOV		R2,R1,LSR #7 	;*0.0000001
						ADD		R2,R2,R1,LSR #9	;*(0.0000001+0.000000001)
						SUB		R1,R1,R2,LSL #6
						SUB		R1,R1,R2,LSL #5
						SUB		R1,R1,R2,LSL #2	;R1=input-100*R2
						CMP		R1,#100	; check rounding error
UNPACKTRIPLET_L1			SUBHS	R1,R1,#100
						ADDHS	R2,R2,#1
						CMP		R1,#100	; ***May required, not sure
						BHS		UNPACKTRIPLET_L1

						MOV		R0,R2,LSL #8	;put C in output


						;get		B&A by R1/10 est *0001100110
						MOV		R2,R1,LSR #4
						ADD		R2,R2,R1,LSR #5
						ADD		R2,R2,R1,LSR #8
						ADD		R2,R2,R1,LSR #9
						SUB		R1,R1,R2,LSL #3
						SUB		R1,R1,R2,LSL #1	;R1=input-100*C-10R2

						CMP		R1,#10	; check rounding error
UNPACKTRIPLET_L2			SUBHS	R1,R1,#10
						ADDHS	R2,R2,#1
						CMP		R1,#10	; ***May required, not sure
						BHS		UNPACKTRIPLET_L2

						ORR		R0,R0,R2,LSL #4	;put B in output
						ORR		R0,R0,R1	;put A in output
						;end
						MOV		PC,LR

						;====PACKTWORD====
						;		not optimised
						;		USE PACKTRIPLET, UNROLL if assist on cycle
						;In		R1: Address of the 9BCD
						;Out		R0: TWORD
						;Temp	R2,R3,R4,R12

PACKTWORD					STMFD	R13!,{R4,LR}
						LDR		R12,[R1,#4]
						LDR		R1,[R1]
						;1st		TCD
						BL		PACKTRIPLET 	;call subroutine,R1 is unchanged
						mov		R4,R0
						;2nd		TCD
						LSR		R1,R1,#12
						BL		PACKTRIPLET
						ORR		R4,R4,R0,LSL #11
						;3nd		TCD (if UNROLL, caulcate it first, use 1 less reg and some cycle)
						LSR		R1,R1,#12
						ORR		R1,R1,R12,LSL #8
						BL		PACKTRIPLET
						ORR		R0,R4,R0,LSL #22
						;end
						LDMFD	R13!,{R4,PC}

						;====UNPACKTWORD====
						;		not optimised
						;		USE UNPACKTRIPLET, UNROLL if assist on cycle
						;In		R1: Address of the 9 BCD for output
						;		R0: TWORD
						;Out		NONE
						;Temp	r1,R2,R3,R4,R12

UNPACKTWORD				STMFD	R13!,{R4,R5,LR}
						MOV		R12,R1
						MOV		R4,R0
						;1st		3BCD
						MOV		R1,R4
						BL		UNPACKTRIPLET
						MOV		R5,R0
						;2nd		3BCD
						MOV		R1,R4,LSR #11
						BL		UNPACKTRIPLET
						ORR		R5,R5,R0,LSL #12
						;3rd		3BCD
						MOV		R1,R4,LSR #22
						BL		UNPACKTRIPLET
						ORR		R5,R5,R0,LSL #24
						STR		R5,[R12],#4
						MOV		R5,R0,LSR #8
						STR		R5,[R12]
						;store
						LDMFD	R13!,{R4,R5,PC}

						;====MULTRIPLE====
						;In		R1: 1TCD (STRCILY 10 bit)
						;		R2: 1TCD (May exceed 10 bit => binary, not TCD)
						;Out		R0:
						;Temp	R3,

MULTRIPLE					MOV		R0,#0
						;MUL
						LSLS		R1,R1,#23 ;mov 1 for caucaltion & 22 for set up
						ADDCS	R0,R0,R2,LSL #9
						ADDMI	R0,R0,R2,LSL #8
						LSLS		R1,R1,#2
						ADDCS	R0,R0,R2,LSL #7
						ADDMI	R0,R0,R2,LSL #6
						LSLS		R1,R1,#2
						ADDCS	R0,R0,R2,LSL #5
						ADDMI	R0,R0,R2,LSL #4
						LSLS		R1,R1,#2
						ADDCS	R0,R0,R2,LSL #3
						ADDMI	R0,R0,R2,LSL #2
						LSLS		R1,R1,#2
						ADDCS	R0,R0,R2,LSL #1
						ADDMI	R0,R0,R2,LSL #0
						;split(METHOD_Y)	max error:998000/1024 => 4 if loop

						;split(METHOD_X)	/1000 est *000000000100000110001
						;MOV		R1,R0,LSL #22	;R1 => dec part from est, use to check rounding error. DOES not work (was ADC)
						MOV		R2,R0,LSR #10 	;R2 => int part from est
						;ADDS	R1,R1,R0, LSL #28	;check if dec overflow
						ADD		R2,R2,R0,LSR #16	;add overflow to carry
						;ADDS	R1,R1,R0, LSL #29
						ADD		R2,R2,R0,LSR #17	;*00000000010000011000
						;		R0*=R0-1000R2
						SUB		R0,R0,R2,LSL #10
						ADD		R0,R0,R2,LSL #4
						ADD		R0,R0,R2,LSL #3
						;		check R0 less than 1000
						CMP		R0,#1000	; check rounding error
						SUBHS	R0,R0,#1000
						ADDHS	R2,R2,#1
						CMP		R0,#1000	; check rounding error
MULTRIPLE_L1				SUBHS	R0,R0,#1000
						ADDHS	R2,R2,#1
						CMP		R0,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTRIPLE_L1 ;very unlikely to trigger, use BL reduce cycle by 1, triger in 999*999
						;gen		output
						ORR		R0,R0,R2,LSL #11

						;end
						mov		PC,LR


						;====MULTIPLY====
						;		Use Toom1,2,(3,4) for with if condition at end, default TC2 (possibly 3? if it would help)
						;		All pointers (FA) are start-full pointers to an ascending array of little-endian ordered (LS triplet lowest word) LSB-aligned triplets stored one word per triplet.
						;
						;		A = 123456, where R0 is its pointer as input
						;		��  +-------+--------------+
						;		��  | 0x100 | 0x00 00 00 7B| <= pointer of R0 as input
						;		��  +-------+--------------+
						;		��  | 0x104 | 0x00 00 01 C8|
						;		��  +-------+--------------+
						;		diraction of more siginificant triplet digit
						;
						;In		R0: pointer for LS of A(TCD)
						;		R1: pointer for LS of B(TCD)
						;		R2: pointer for LS of C_OUTPUT(TCD)
						;		R3: size of M (length of TCD)
						;Out		NULL
						;Temp	R4(counter),r5,r6


MULTIPLY ;MULTIPLY wapper�� jump to T2? use as wapper?
						CMP		R3,#1
						BEQ		MULTIPLY_EXP

						;LDR		R12,=bufferMULT ; FA ;USE R13 TO OPT (consider stack allocation with R0123 & NOTE:FA=>FD)
						STMFD	R13!,{R4,R5,R6,R7,R8,R9,R10,R11,LR} ; APCS compliant, all register can be used for scratch registers


						BL		MULTIPLY_T2 ; no need to be APCS compliant

						LDMFD	R13!,{R4,R5,R6,R7,R8,R9,R10,R11,PC}
						;		end of code for MULTIPLY


MULTIPLY_EXP				STMFD	R13!,{R0,R1,R2,R3,LR} ;strach not need to save

						;MUL
						LDR		R0,[R0]
						LDR		R1,[R1]

						MOV		R3,#0
						LSLS		R0,R0,#23 ;mov 1 for caucaltion & 22 for set up
						ADDCS	R3,R3,R1,LSL #9
						ADDMI	R3,R3,R1,LSL #8
						LSLS		R0,R0,#2
						ADDCS	R3,R3,R1,LSL #7
						ADDMI	R3,R3,R1,LSL #6
						LSLS		R0,R0,#2
						ADDCS	R3,R3,R1,LSL #5
						ADDMI	R3,R3,R1,LSL #4
						LSLS		R0,R0,#2
						ADDCS	R3,R3,R1,LSL #3
						ADDMI	R3,R3,R1,LSL #2
						LSLS		R0,R0,#2
						ADDCS	R3,R3,R1,LSL #1
						ADDMI	R3,R3,R1,LSL #0

						MOV		R0,R3,LSR #10 	;R0 => int part from est
						ADD		R0,R0,R3,LSR #16	;add overflow to carry
						ADD		R0,R0,R3,LSR #17	;*00000000010000011000
						SUB		R3,R3,R0,LSL #10
						ADD		R3,R3,R0,LSL #4
						ADD		R3,R3,R0,LSL #3
						CMP		R3,#1000	; check rounding error
						SUBHS	R3,R3,#1000
						ADDHS	R0,R0,#1
						CMP		R3,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_EXP_L1			SUBHS	R3,R3,#1000
						ADDHS	R0,R0,#1
						CMP		R3,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_EXP_L1

						STR		R3,[R2]
						STR		R0,[R2,#4]

						;end
						LDMFD	R13!,{R0,R1,R2,R3,PC}




MULTIPLY_T2
						CMP		R3,#2 ;CMP M,#2 ;BE 4 TO OPT
						BLS		MULTIPLY_T1
						STMFD	R13!,{R0,R1,R2,R3,r12,LR} ;str current R0,R1,R2,R3

						;make	output as A1B1:A0B0
						;R3=0.5M
						LSR		R3,R3,#1	;get M/2
						BL		MULTIPLY_T2	;get A0B0 at LSW
						ADD		R0,R0,R3,LSL #2
						ADD		R1,R1,R3,LSL #2
						ADD		R2,R2,R3,LSL #3	; (*4*1) muti 2 as output is twice size of input
						BL		MULTIPLY_T2	;get A1B1 at MSW

						;caculate	(A0-A1)&(B1-B0) /CAN BE OPTMISED (use base 2^11)
						;X		CAN BE OPTMISED: add & mut less mome opt
						;X		set R0,R1,R2
						;X		R3,R12	USE AS TEMP REG FOR R0,R1
						;X		sub 2M , add 2M on exist, there is no stack operation in between

						;		R12:0000 0000 0000 0000 00CC CCCC CC00 0AON
						;		A=0 => IS B 		A=1 => IS A (ONLY FOR SUB4)
						;		N=0 => POSTIVE 	N=1 => NEGATIVE
						;		C=> COUNTER
						;		O =>dont care, overflow of N

						CMP		R3,#4 ; to ADD2 if 0.5M=2, ADD4 if 0.5M=4, ADD8 if 0.5M>4
						;BHI		MULTIPLY_T2_Z1_SUB8 ; FOR OPTIMISE
						;BEQ		MULTIPLY_T2_Z1_SUB4
						BGE		MULTIPLY_T2_Z1_SUB4

MULTIPLY_T2_Z1_SUB2
MULTIPLY_T2_Z1_SUB2_B		ADD		R1,R1,#8 ;+2
						LDMDB	R1!,{R4,R5,R6,R7}
						CMP		R7, R5
						CMPEQ	R6,R4
						;B0=B1
						;TO		SPEICAL BRANCH, SKIP MULTIPLY_T2_Z1_MUL (0 ANYWAY)
						;B1<B0	negative
						BCC		MULTIPLY_T2_Z1_SUB2_B_NEG
						;B1>B0	postive
						MOV		R12,#0X0
						SUBS		R6,R6,R4
						ADDMI	R6,R6,#1000
						SBC		R7,R7,R5

MULTIPLY_T2_Z1_SUB2_A		ADD		R0,R0,#8 ;+2
						LDMDB	R0!,{R8,R9,R10,R11}
						CMP		R9, R11
						CMPEQ	R8, R10
						;A0=A1
						;TO		SPEICAL BRANCH, SKIP MULTIPLY_T2_Z1_MUL (0 ANYWAY)
						;A0<A1	negative
						BCC		MULTIPLY_T2_Z1_SUB2_A_NEG
						;A0>A1	postive
						SUBS		R8,R8,R10
						ADDMI	R8,R8,#1000
						SBC		R9,R9,R11

						;STORE
MULTIPLY_T2_Z1_SUB2_STR		STMDB	R13,{R6,R7,R8,R9}
						SUB		R0,R13,#8 	;2*4
						SUB		R1,R13,#16 ;2*4*2
						SUB		R13,R13,#32 ;2*4*2+4*4 ;space for (A0-A1)*(B1-B0)
						MOV		R2,R13

MULTIPLY_T2_Z1_MUL			BL		MULTIPLY_T2 ; SPECIAL BRANCH TO MULTIPLY_T1_ADD

						TST		R12,#0X1 ;MASK FOR N
						BNE		MULTIPLY_T2_Z1_ADD_NEG_WAPPER ; FOR OPTIMISE

MULTIPLY_T2_Z1_ADD_POS_WAPPER	ADD		R0,R13,R3,LSL #4 ;(1M+2*0.5M)*4=16*0.5M
						LDR		R0,[R0,#8] ; R0 is R2 in parents branch,
						ADD		R12,R0,R3,LSL #3
						;		R0=pointer of parent R2 A0B0, R12=pointer of A2B2, R2=pointer of current R2 (A1+A0)*(B1+B0)
						;		place result to back to R2
						;		no rounding

MULTIPLY_T2_Z1_ADD_POS		LDMIA	R12!,{R8,R9,R10,R11}
						LDMIA	R0!, {R4,R5,R6,R7}


						ADD		R4,R4,R8
						ADD		R5,R5,R9
						ADD		R6,R6,R10
						ADD		R7,R7,R11

						LDMIA	R2,{R8,R9,R10,R11}
						ADD		R4,R4,R8
						ADD		R5,R5,R9
						ADD		R6,R6,R10
						ADD		R7,R7,R11

						STMIA	R2!,{R4,R5,R6,R7}
						CMP		R1,R2
						BNE		MULTIPLY_T2_Z1_ADD_POS

MULTIPLY_T2_Z1_FINAL_W		SUB		R2,R2,R3,LSL #3
						SUB		R0,R0,R3,LSL #2
						MOV		R7,#0
						;		R0=pointer for A1B1, R2=pointer for not rounded Z1, R12 not used

MULTIPLY_T2_Z1_FINAL		LDMIA	R2!,{R8,R9,R10,R11}
						ADD		R8,R8,R7 ;from previous carry
						LDMIA	R0,{R4,R5,R6,R7}

						ADD		R9,R5,R9
						ADD		R10,R6,R10
						ADD		R11,R7,R11
						ADDS		R8,R4,R8 ;set flag, if negative

						;rounding,	may be negative

						;ROUNDING	R8 (rounding part in MULTIPLY_T1, CHANGE R11 TO R4)
						BMI		MULTIPLY_T2_Z1_FINAL_R8_N
MULTIPLY_T2_Z1_FINAL_R8		MOV		R4,R8,LSR #10 	;R4 => int part from est
						ADD		R4,R4,R8,LSR #16	;add overflow to carry
						ADD		R4,R4,R8,LSR #17	;*00000000010000011000
						SUB		R8,R8,R4,LSL #10
						ADD		R8,R8,R4,LSL #4
						ADD		R8,R8,R4,LSL #3
						CMP		R8,#1000	; check rounding error
						SUBHS	R8,R8,#1000
						ADDHS	R4,R4,#1
						CMP		R8,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R8_L	SUBHS	R8,R8,#1000
						ADDHS	R4,R4,#1
						CMP		R8,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T2_Z1_FINAL_R8_L
						ADDS		R9,R9,R4

						;ROUNDING	R9 (rounding part in MULTIPLY_T1, CHANGE R11 TO R4)
						BMI		MULTIPLY_T2_Z1_FINAL_R9_N
MULTIPLY_T2_Z1_FINAL_R9		MOV		R4,R9,LSR #10 	;R4 => int part from est
						ADD		R4,R4,R9,LSR #16	;add overflow to carry
						ADD		R4,R4,R9,LSR #17	;*00000000010000011000
						SUB		R9,R9,R4,LSL #10
						ADD		R9,R9,R4,LSL #4
						ADD		R9,R9,R4,LSL #3
						CMP		R9,#1000	; check rounding error
						SUBHS	R9,R9,#1000
						ADDHS	R4,R4,#1
						CMP		R9,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R9_L	SUBHS	R9,R9,#1000
						ADDHS	R4,R4,#1
						CMP		R9,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T2_Z1_FINAL_R9_L
						ADDS		R10,R10,R4

						;ROUNDING	R10
						BMI		MULTIPLY_T2_Z1_FINAL_R10_N
MULTIPLY_T2_Z1_FINAL_R10		MOV		R4,R10,LSR #10 	;R4 => int part from est
						ADD		R4,R4,R10,LSR #16	;add overflow to carry
						ADD		R4,R4,R10,LSR #17	;*00000000010000011000
						SUB		R10,R10,R4,LSL #10
						ADD		R10,R10,R4,LSL #4
						ADD		R10,R10,R4,LSL #3
						CMP		R10,#1000	; check rounding error
						SUBHS	R10,R10,#1000
						ADDHS	R4,R4,#1
						CMP		R10,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R10_L	SUBHS	R10,R10,#1000
						ADDHS	R4,R4,#1
						CMP		R10,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T2_Z1_FINAL_R10_L
						ADDS		R11,R11,R4

						;ROUNDING	R11
						BMI		MULTIPLY_T2_Z1_FINAL_R11_N
MULTIPLY_T2_Z1_FINAL_R11		MOV		R7,R11,LSR #10 	;R4 => int part from est
						ADD		R7,R7,R11,LSR #16	;add overflow to carry
						ADD		R7,R7,R11,LSR #17	;*00000000010000011000
						SUB		R11,R11,R7,LSL #10
						ADD		R11,R11,R7,LSL #4
						ADD		R11,R11,R7,LSL #3
						CMP		R11,#1000	; check rounding error
						SUBHS	R11,R11,#1000
						ADDHS	R7,R7,#1
						CMP		R11,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R11_L	SUBHS	R11,R11,#1000
						ADDHS	R7,R7,#1
						CMP		R11,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T2_Z1_FINAL_R11_L


MULTIPLY_T2_Z1_FINAL_R		CMP		R1,R2
						STMIA	R0!,{R8,R9,R10,R11}
						BNE		MULTIPLY_T2_Z1_FINAL
						;exit	loop if is last one

						LSL		R5,R3,#4 ;temp R5, as "ADD R13,R13,R3, LSL #4" is not vaild ; can be optmised
						ADD		R13,R13,R5
						CMP		R7,#0
						LDMFDeq	R13!,{R0,R1,R2,R3,r12,PC}

MULTIPLY_T2_Z1_FINAL_OVERFLOW	LDR		R4,[R0] ;get next MS TRIPLET OF CURRENT OUTPUT (start pointer for A2B2)
						ADD		R4,R4,R7
						SUBS		R5,R4, #1000 ; ANOTHER TEMP REG R5

						;no		further overflow
						STRlt	R4,[R0]
						LDMFDlt	R13!,{R0,R1,R2,R3,r12,PC}

						;further	overflow
						MOV		R7,#1
						STR		R5,[R0],#4
						B		MULTIPLY_T2_Z1_FINAL_OVERFLOW

						end		; END of MULTIPLY, this line should not executed

						;		============ BELOW ARE FUNCTIONS
MULTIPLY_T2_Z1_SUB2_B_NEG	MOV		R12,#0X1
						SUBS		R6,R4,R6
						ADDMI	R6,R6,#1000
						SBC		R7,R5,R7
						B		MULTIPLY_T2_Z1_SUB2_A

MULTIPLY_T2_Z1_SUB2_A_NEG	add		R12,R12,#0X1
						SUBS		R8,R10,R8
						ADDMI	R8,R8,#1000
						SBC		R9,R11,R9
						B		MULTIPLY_T2_Z1_SUB2_STR


MULTIPLY_T2_Z1_ADD_NEG_WAPPER	ADD		R0,R13,R3,LSL #4 ;(1M+2*0.5M)*4=16*0.5M
						LDR		R0,[R0,#8] ; R0 is R2 in parents branch,
						ADD		R12,R0,R3,LSL #3
						MOV		R7,#0
						;		R0=pointer of parent R2 A0B0, R12=pointer of A2B2, R2=pointer of current R2 (A1-A0)*(B1-B0)
						;		place result to R0+R3 (LSL #2)

MULTIPLY_T2_Z1_ADD_NEG		LDMIA	R12!,{R8,R9,R10,R11}
						LDMIA	R0!, {R4,R5,R6,R7}


						ADD		R4,R4,R8
						ADD		R5,R5,R9
						ADD		R6,R6,R10
						ADD		R7,R7,R11

						LDMIA	R2,{R8,R9,R10,R11}
						SUB		R4,R4,R8
						SUB		R5,R5,R9
						SUB		R6,R6,R10
						SUB		R7,R7,R11

						STMIA	R2!, {R4,R5,R6,R7}
						CMP		R1,R2
						BNE		MULTIPLY_T2_Z1_ADD_NEG
						B		MULTIPLY_T2_Z1_FINAL_W

						;need	opt, use shift & est, see example:789741123456*852963410520, cause too much loop
MULTIPLY_T2_Z1_FINAL_R8_N	RSB		R8,R8,#0
						MOV		R4,R8,LSR #10 	;R4 => BORROW
						ADD		R4,R4,R8,LSR #16
						ADD		R4,R4,R8,LSR #17
						SUB		R8,R8,R4,LSL #10
						ADD		R8,R8,R4,LSL #4
						ADDS		R8,R8,R4,LSL #3
						ADDGT	R4,R4,#1
						SUBSGT	R8,R8,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R8_N_L	ADDGT	R4,R4,#1
						SUBSGT	R8,R8,#1000			;CHECK
						BGT		MULTIPLY_T2_Z1_FINAL_R8_N_L

						RSB		R8,R8,#0
						SUBS		R9,R9,R4
						BGE		MULTIPLY_T2_Z1_FINAL_R9

MULTIPLY_T2_Z1_FINAL_R9_N	RSB		R9,R9,#0
						MOV		R4,R9,LSR #10 	;R4 => BORROW
						ADD		R4,R4,R9,LSR #16
						ADD		R4,R4,R9,LSR #17
						SUB		R9,R9,R4,LSL #10
						ADD		R9,R9,R4,LSL #4
						ADDS		R9,R9,R4,LSL #3
						ADDGT	R4,R4,#1
						SUBSGT	R9,R9,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R9_N_L	ADDGT	R4,R4,#1
						SUBSGT	R9,R9,#1000			;CHECK
						BGT		MULTIPLY_T2_Z1_FINAL_R9_N_L

						RSB		R9,R9,#0
						SUBS		R10,R10,R4
						BGE		MULTIPLY_T2_Z1_FINAL_R10

MULTIPLY_T2_Z1_FINAL_R10_N	RSB		R10,R10,#0
						MOV		R4,R10,LSR #10 	;R4 => BORROW
						ADD		R4,R4,R10,LSR #16
						ADD		R4,R4,R10,LSR #17
						SUB		R10,R10,R4,LSL #10
						ADD		R10,R10,R4,LSL #4
						ADDS		R10,R10,R4,LSL #3
						ADDGT	R4,R4,#1
						SUBSGT	R10,R10,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R10_N_L	ADDGT	R4,R4,#1
						SUBSGT	R10,R10,#1000			;CHECK
						BGT		MULTIPLY_T2_Z1_FINAL_R10_N_L

						RSB		R10,R10,#0
						SUBS		R11,R11,R4
						BGE		MULTIPLY_T2_Z1_FINAL_R11

MULTIPLY_T2_Z1_FINAL_R11_N	RSB		R11,R11,#0
						MOV		R7,R11,LSR #10 	;R7 => BORROW
						ADD		R7,R7,R11,LSR #16
						ADD		R7,R7,R11,LSR #17
						SUB		R11,R11,R7,LSL #10
						ADD		R11,R11,R7,LSL #4
						ADDS		R11,R11,R7,LSL #3
						ADDGT	R7,R7,#1
						SUBSGT	R11,R11,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R11_N_L	ADDGT	R7,R7,#1
						SUBSGT	R11,R11,#1000			;CHECK
						BGT		MULTIPLY_T2_Z1_FINAL_R11_N_L

						RSB		R7,R7,#0
						RSB		R11,R11,#0
						B		MULTIPLY_T2_Z1_FINAL_R


						;MULTIPLY_T2_Z1_SUB8
MULTIPLY_T2_Z1_SUB4			;R2 	=> pointer for of B1 & A1
						;R0,R1	=> pointer for of B0 & A0
						;R12[13..4]	=> for countdown, already shifted by 2 0.5M=R12[13..6]
						;can		be OPT (STR 1 REG, use it for pointer of A2B2)
						;


MULTIPLY_T2_Z1_SUB4_A_W		ADD		R2,R0,R3,LSL #2
						MOV		R12,#0X4 	;set A=1,N=0
						ADD		R12,R12,R3,LSL #6	;set A=1,N=0,C=0.5M, as 0.5M in range of 0 - 32
						SUB		R13,R13,R3,LSL #2	;make space for |A0-A1|

MULTIPLY_T2_Z1_SUB4_A		LDMDB	R0!,{R4,R5,R6,R7}
						LDMDB	R2!,{R8,R9,R10,R11}

						CMP		R7,R11
						CMPEQ	R6,R10
						CMPEQ	R5,R9
						CMPEQ	R4,R8
						SUB		R12,R12,#0X100 ;counter-4

						;B1<B0	negative
						ADDCC	R12,R12,#0X1
						BCC		MULTIPLY_T2_Z1_SUB4_1SUB0_W
						;B1>B0	postive
						BHI		MULTIPLY_T2_Z1_SUB4_0SUB1_W

						;B0=B1	check if is last one
						TST		R12,#0X3FC0 ;get counter & test
						BNE		MULTIPLY_T2_Z1_SUB4_A
						;if		is last, still equal => (A0-A1)(B1-B0)=0 => OPT
						;		temp soulstion
						B		MULTIPLY_T2_Z1_SUB4_0SUB1_W

MULTIPLY_T2_Z1_SUB4_B_W		ADD		R2,R1,R3,LSL #2
						AND		R12,R12,#0X1 	;only copy N, A=0, , reset counter,
						ADD		R12,R12,R3,LSL #6		;A=0, C=0.5M, N=previous
						SUB		R13,R13,R3,LSL #3 ;make space for |B0-B1|, was at MSW of |A0-A1|

MULTIPLY_T2_Z1_SUB4_B		LDMDB	R1!,{R4,R5,R6,R7}
						LDMDB	R2!,{R8,R9,R10,R11}

						CMP		R11,R7
						CMPEQ	R10,R6
						CMPEQ	R9,R5
						CMPEQ	R8,R4
						SUB		R12,R12,#0X100 	;counter-4

						;B1<B0	negative
						ADDCC	R12,R12,#0X1
						BCC		MULTIPLY_T2_Z1_SUB4_0SUB1_W
						;B1>B0	postive
						BHI		MULTIPLY_T2_Z1_SUB4_1SUB0_W

						;B0=B1	check if is last one
						TST		R12,#0X3FC0			;get counter & test
						BNE		MULTIPLY_T2_Z1_SUB4_B
						;if		is last, still equal => (A0-A1)(B1-B0)=0 => OPT
						;		temp soulstion
						B		MULTIPLY_T2_Z1_SUB4_0SUB1_W


						;in		MULTIPLY_T2_Z1_SUB4_0SUB1 & _1SUB0,
						;R12		=> R/W counter & R A
						;R2		=> pointer for A1 & B1 (start LSW)
						;R0		=> pointer for A0 & B0 (start LSW), can overwrite R0, as cacl A before B
						;R13		=> pointer for output (start LSW)
MULTIPLY_T2_Z1_SUB4_0SUB1_W	TST		R12,#0X4 			;get A flag
						SUBne	R0,R0,R12,LSR #4	;A=1 for A, reset pointer
						SUBeq	R0,R1,R12,LSR #4	;A=0 for B, reset pointer
						ADD		R2,R0,R3,LSL #2
						AND		r12,R12,#0x5			;reset counter
						ADD		R12,R12,R3, LSL #6	;set counter
						mov		r7,r11				;FORCE SET CARRY FLAG

MULTIPLY_T2_Z1_SUB4_0SUB1	cmp		r7,r11
						LDMIA	R0!,{R4,R5,R6,R7}
						LDMIA	R2!,{R8,R9,R10,R11}

						SBCS		R4,R4,R8
						ADDMI	R4,R4,#1000
						SBCS		R5,R5,R9
						ADDMI	R5,R5,#1000
						SBCS		R6,R6,R10
						ADDMI	R6,R6,#1000
						SBCS		R8,R7,R11 ;preservie R7, for cmp r7,r11
						ADDMI	R8,R8,#1000
						STMIA	R13!,{R4,R5,R6,R8}

						SUB		R12,R12,#0X100
						TST		R12,#0X3FC0
						BNE		MULTIPLY_T2_Z1_SUB4_0SUB1

						TST		R12,#0X4
						BNE		MULTIPLY_T2_Z1_SUB4_B_W ;A=1, form A, cal B next
						;		A=0, form B, do MULTIPLY_T2_Z1_MUL next
						MOV		R0,R13 ;pointer at LSW of |A1-A0|
						SUB		R1,R13,R3,LSL #2 ;move pointer to LSW of |B0-B1|
						SUB		R2,R1,R3,LSL #3 ;move pointer to LSW of Z1
						MOV		R13,R2
						B		MULTIPLY_T2_Z1_MUL

MULTIPLY_T2_Z1_SUB4_1SUB0_W	TST		R12,#0X4 			;get A flag
						SUBne	R0,R0,R12,LSR #4	;A=1 for A, reset pointer
						SUBeq	R0,R1,R12,LSR #4	;A=0 for B, reset pointer
						ADD		R2,R0,R3,LSL #2
						AND		r12,R12,#0x5			;reset counter
						ADD		R12,R12,R3, LSL #6	;set counter
						mov		r7,r11			;FORCE SET CARRY FLAG

MULTIPLY_T2_Z1_SUB4_1SUB0	cmp		r11,r7
						LDMIA	R0!,{R4,R5,R6,R7}
						LDMIA	R2!,{R8,R9,R10,R11}

						SBCS		R4,R8,R4
						ADDMI	R4,R4,#1000
						SBCS		R5,R9,R5
						ADDMI	R5,R5,#1000
						SBCS		R6,R10,R6
						ADDMI	R6,R6,#1000
						SBCS		R8,R11,R7
						ADDMI	R8,R8,#1000
						STMIA	R13!,{R4,R5,R6,R8}

						SUB		R12,R12,#0X100
						TST		R12,#0X3FC0
						BNE		MULTIPLY_T2_Z1_SUB4_1SUB0

						TST		R12,#0X4
						BNE		MULTIPLY_T2_Z1_SUB4_B_W ;A=1 form A, cal B next
						;		A=0 form A, do MULTIPLY_T2_Z1_MUL next
						MOV		R0,R13 ;pointer at LSW of |A1-A0|
						SUB		R1,R13,R3,LSL #2 ;move pointer to LSW of |B0-B1|
						SUB		R2,R1,R3,LSL #3 ;move pointer to LSW of Z1
						MOV		R13,R2
						B		MULTIPLY_T2_Z1_MUL


MULTIPLY_T1 	;	  R5|R4
						;		X R7|R6
						;result:	R11|R10|R9|R8
						;R11:	TEMP FOR SHIFT & ROUNDING
						LDR		R4,[R0]
						LDR		R5,[R0,#4]
						LDR		R6,[R1]
						LDR		R7,[R1,#4]

						;FIRST	R8=R4*R6
						MOV		R8,#0

						LSLS		R11,R4,#23 ;mov 1 for caucaltion & 22 for set up
						ADDCS	R8,R8,R6,LSL #9
						ADDMI	R8,R8,R6,LSL #8
						LSLS		R11,R11,#2
						ADDCS	R8,R8,R6,LSL #7
						ADDMI	R8,R8,R6,LSL #6
						LSLS		R11,R11,#2
						ADDCS	R8,R8,R6,LSL #5
						ADDMI	R8,R8,R6,LSL #4
						LSLS		R11,R11,#2
						ADDCS	R8,R8,R6,LSL #3
						ADDMI	R8,R8,R6,LSL #2
						LSLS		R11,R11,#2
						ADDCS	R8,R8,R6,LSL #1
						ADDMI	R8,R8,R6,LSL #0

						;LAST	R10=R5*R7
						MOV		R10,#0

						LSLS		R11,R5,#23 ;mov 1 for caucaltion & 22 for set up
						ADDCS	R10,R10,R7,LSL #9
						ADDMI	R10,R10,R7,LSL #8
						LSLS		R11,R11,#2
						ADDCS	R10,R10,R7,LSL #7
						ADDMI	R10,R10,R7,LSL #6
						LSLS		R11,R11,#2
						ADDCS	R10,R10,R7,LSL #5
						ADDMI	R10,R10,R7,LSL #4
						LSLS		R11,R11,#2
						ADDCS	R10,R10,R7,LSL #3
						ADDMI	R10,R10,R7,LSL #2
						LSLS		R11,R11,#2
						ADDCS	R10,R10,R7,LSL #1
						ADDMI	R10,R10,R7,LSL #0

						;MIDDLE	R9=(R5+R4)(R7+R6)-FIRST-LAST
						MOV		R9,#0
						ADD		R5,R5,R4
						ADD		R7,R6,R7

						LSLS		R11,R5,#22 ;mov 1 for caucaltion & 22 for set up
						ADDCS	R9,R9,R7,LSL #10
						LSLS		R11,R11,#1
						ADDCS	R9,R9,R7,LSL #9
						ADDMI	R9,R9,R7,LSL #8
						LSLS		R11,R11,#2
						ADDCS	R9,R9,R7,LSL #7
						ADDMI	R9,R9,R7,LSL #6
						LSLS		R11,R11,#2
						ADDCS	R9,R9,R7,LSL #5
						ADDMI	R9,R9,R7,LSL #4
						LSLS		R11,R11,#2
						ADDCS	R9,R9,R7,LSL #3
						ADDMI	R9,R9,R7,LSL #2
						LSLS		R11,R11,#2
						ADDCS	R9,R9,R7,LSL #1
						ADDMI	R9,R9,R7,LSL #0

						SUB		R9,R9,R8
						SUB		R9,R9,R10
						MOV		R11,#0

						;EXIST	LOOP IF IS FROM (A0-A1)(B1-B0)
						CMP		R13, R2
						STMIAEQ	R2,{R11,R10,R9,R8} ;OPT: dont store to memory, use directlly
						MOVEQ	PC,LR

						;ROUNDING	R8
						MOV		R11,R8,LSR #10 	;R11 => int part from est
						ADD		R11,R11,R8,LSR #16	;add overflow to carry
						ADD		R11,R11,R8,LSR #17	;*00000000010000011000
						SUB		R8,R8,R11,LSL #10
						ADD		R8,R8,R11,LSL #4
						ADD		R8,R8,R11,LSL #3
						CMP		R8,#1000	; check rounding error
						SUBHS	R8,R8,#1000
						ADDHS	R11,R11,#1
						CMP		R8,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T1_L1				SUBHS	R8,R8,#1000
						ADDHS	R11,R11,#1
						CMP		R8,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T1_L1
						ADD		R9,R9,R11

						;ROUNDING	R9
						MOV		R11,R9,LSR #10 	;R11 => int part from est
						ADD		R11,R11,R9,LSR #16	;add overflow to carry
						ADD		R11,R11,R9,LSR #17	;*00000000010000011000
						SUB		R9,R9,R11,LSL #10
						ADD		R9,R9,R11,LSL #4
						ADD		R9,R9,R11,LSL #3
						CMP		R9,#1000	; check rounding error
						SUBHS	R9,R9,#1000
						ADDHS	R11,R11,#1
						CMP		R9,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T1_L2				SUBHS	R9,R9,#1000
						ADDHS	R11,R11,#1
						CMP		R9,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T1_L2
						ADD		R10,R10,R11

						;ROUNDING	R10 & R11
						MOV		R11,R10,LSR #10 	;R11 => int part from est
						ADD		R11,R11,R10,LSR #16	;add overflow to carry
						ADD		R11,R11,R10,LSR #17	;*00000000010000011000
						SUB		R10,R10,R11,LSL #10
						ADD		R10,R10,R11,LSL #4
						ADD		R10,R10,R11,LSL #3
						CMP		R10,#1000	; check rounding error
						SUBHS	R10,R10,#1000
						ADDHS	R11,R11,#1
						CMP		R10,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T1_L3				SUBHS	R10,R10,#1000
						ADDHS	R11,R11,#1
						CMP		R10,#1000	; check rounding error caused by rounding error from decimal
						BHS		MULTIPLY_T1_L3

						STMIA	R2,{R11,R10,R9,R8}
						MOV		PC,LR



RECIPROCAL				MOV		PC, LR

SQUAREROOT				MOV		PC,LR
;TO-CHECK:
;		1) ROUNDING ERROR => 1 FOR UNACCURATE0.001, 2 FOR ROUNDING ERROR?
;		make R3=M, not 0.5M => save 1 line


;		;test_for_first_2
;testPACKTRIPLET	DCD		0x2865459 ;hex is equavalent of BCD
;testUNPACKTRIPLET	DCD		100999
;		ldr		r1,=testUNPACKTRIPLET
;		ldr		R1,[r1]
;		BL		UNPACKTRIPLET
;		end

;testPACKTWORD	DCD		0x46546715,0x1315
;		adr		r1,testPACKTWORD
;		BL		PACKTWORD
;		end

;testUNPACKTWORD	FILL		4*2
;testUNPACKTWORD_n	DCD		0x889112cb
;		adr		R1,testUNPACKTWORD
;		ldr		r0,=testUNPACKTWORD_n
;		ldr		r0,[r0]
;		BL		UNPACKTWORD
;		end

;testMULTRIPLE	DCD		500,550
;		adr		r1,testMULTRIPLE
;		ldr		r2,[r1,#4]
;		ldr		r1,[r1]
;		bl		MULTRIPLE
;		end

;====================	PART 2 TEST=================
;A1		DCD	123,456 ;MSW -> LSW (FD)
;B1		DCD	789,852
;C1		FILL	4*4
;		LDR	R0,=A1
;		LDR	R1,=B1
;		LDR	R2,=C1
;		mov	r3,#2
;		bl	MULTIPLY_T2
;		end

;A1		DCD	789,879,798,789 ;LSW	  -> MSW
;B1		DCD	879,879,789,987 ;LS triple -> MS triple
;C1		FILL	4*8

;A1		DCD		741,789,456,123 ;LSW	  -> MSW
;B1		DCD		520,410,963,852 ;LS triple -> MS triple
;C1		FILL		4*8 ;320,475,907,333,429,124,304,105 (LS -> MS)

;A1		DCD		456,123,741,789 ;LSW	  -> MSW
;B1		DCD		520,410,963,852 ;LS triple -> MS triple
;C1		FILL		4*8 ; 120 157 129 926 090 282 620 673(LS -> MS)

;A1		DCD		456 ;LSW	  -> MSW
;B1		DCD		520 ;LS triple -> MS triple
;C1		FILL		4*8 ; 120 157 129 926 090 282 620 673(LS -> MS)

;A1		DCD		456,123,741,789 ;LSW	  -> MSW
;B1		DCD		520,410,963,852 ;LS triple -> MS triple
;C1		FILL		4*8 ; 120 157 129 926 090 282 620 673(LS -> MS)

;error	due to sub part?
;A1		DCD		454,987,982,489,795,681,545,116 ;LSW	  -> MSW
;B1		DCD		454,987,982,489,795,681,545,116 ;LS triple -> MS triple
;C1		FILL		4*8 ;(LS -> MS)

;116545681795489982987454	116545681795489982987454*116545681795489982987454 168984464445978979344678
;A1		DCD		454,987,982,489,795,681,545,116, 454,987,982,489,795,681,545,116, 678,344,979,978,445,464,984,168 ,454,456,897,131,456,547,313,879, 464,486,754,897,133,987,863,974, 464,486,754,897,133,987,863,974, 564,654,456,766,467,437,684,861, 454,987,982,489,795,681,545,116 ;LSW	  -> MSW
;B1		DCD		678,344,979,978,445,464,984,168, 454,987,982,489,795,681,545,116, 678,344,979,978,445,464,984,168 ,464,486,754,897,133,987,863,974, 864,834,725,464,546,456,121,789, 454,987,982,489,795,681,545,116, 464,486,754,897,133,987,863,974, 464,486,754,897,133,987,863,974 ;LS triple -> MS tripleC1						FILL		4*32 ;(LS -> MS)
;C1		FILL		8*64
;A1		DCD		454,987,982,489,795,681,545,116 ;LSW	  -> MSW
;B1		DCD		678,344,979,978,445,464,984,168 ;LS triple -> MS triple
;C1		FILL		4*8 ;812 669 615 085 001 034 842 274 686 606 356 702 621 409 694 019(LS -> MS)

;A1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LSW	  -> MSW
;B1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LS triple -> MS triple
;C1		FILL		4*128 ;(LS -> MS)

;A1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LSW	  -> MSW
;B1		DCD		111,111,111,111,111,111,111,111,111,111,111,111,111,111,111,111 ;LS triple -> MS triple
;C1		FILL		4*8 ;321,654,987,320,012,679,345,12 (LS -> MS)

;A1						DCD		705,839,705,865,892,708,751,852,701,840,763,881,722,770,839,835,776,811,768,839,805,733,810,789,723,883,872,735,848,820,824,753,795,751,756,753,874,755,849,724,790,749,806,894,845,822,721,740,889,803,879,878,714,795,763,740,835,846,842,882,894,813,762,866
;B1						DCD		893,726,846,838,888,785,791,722,773,865,778,900,715,788,877,864,899,821,855,855,889,796,735,839,818,847,797,846,878,734,821,733,863,838,776,809,831,745,812,870,797,876,761,704,863,776,827,849,810,879,811,795,712,734,749,757,749,820,787,741,890,782,807,858
;C1						FILL		4*128 ;321,654,987,320,012,679,345,12 (LS -> MS)
;
;						LDR		R0,=A1
;						LDR		R1,=B1
;						LDR		R2,=C1
;						SUB		r3,R1,R0
;						LSR		R3,R3,#2
;						BL		MULTIPLY
;						END
;====PACKTRIPLET====
;		INPUT is unchanged
;In		R1: LS12 => 3BCD(C,B,A);	MS20 => any (should be 0)
;Out		R0: LS10 => TCD;	MS22 => all0
;Temp	R2,R3

;get		10C+B
PACKTRIPLET				AND		R2,R1,#0xF00 	;8C
AND		R3,R1,#0x0F0	;B
LSR		R2,R2,#5
ADD		R2,R2,R2,LSR #2 	;8C+2C
ADD		R2,R2,R3,LSR #4	;10C+B
;get		A+10(B+10C)
AND		R3,R1,#0x00F	;A
ADD		R3,R3,R2,LSL #1	;A+2(8C+2C)
ADD		R0,R3,R2,LSL #3	;A+10(8C+2C)
;end
MOV		PC,LR

;====UNPACKTRIPLET====
;In		R1: LS10 => TCD;	MS22 => any
;Out		R0: LS12 => 3BCD(C,B,A);	MS20 => all0
;Temp	R2,R3

UNPACKTRIPLET				LSL		R1,R1,#22 ;{!!!!!!!!!! NOT FULLY OPTIMISED)
LSR		R1,R1,#22
;get		C by *1/100 est *0000001010 [2 line less than OP1 version]
MOV		R2,R1,LSR #7 	;*0.0000001
ADD		R2,R2,R1,LSR #9	;*(0.0000001+0.000000001)
SUB		R1,R1,R2,LSL #6
SUB		R1,R1,R2,LSL #5
SUB		R1,R1,R2,LSL #2	;R1=input-100*R2
CMP		R1,#100	; check rounding error
UNPACKTRIPLET_L1			SUBHS	R1,R1,#100
ADDHS	R2,R2,#1
CMP		R1,#100	; ***May required, not sure
BHS		UNPACKTRIPLET_L1

MOV		R0,R2,LSL #8	;put C in output


;get		B&A by R1/10 est *0001100110
MOV		R2,R1,LSR #4
ADD		R2,R2,R1,LSR #5
ADD		R2,R2,R1,LSR #8
ADD		R2,R2,R1,LSR #9
SUB		R1,R1,R2,LSL #3
SUB		R1,R1,R2,LSL #1	;R1=input-100*C-10R2

CMP		R1,#10	; check rounding error
UNPACKTRIPLET_L2			SUBHS	R1,R1,#10
ADDHS	R2,R2,#1
CMP		R1,#10	; ***May required, not sure
BHS		UNPACKTRIPLET_L2

ORR		R0,R0,R2,LSL #4	;put B in output
ORR		R0,R0,R1	;put A in output
;end
MOV		PC,LR

;====PACKTWORD====
;		not optimised
;		USE PACKTRIPLET, UNROLL if assist on cycle
;In		R1: Address of the 9BCD
;Out		R0: TWORD
;Temp	R2,R3,R4,R12

PACKTWORD					STMFD	R13!,{R4,LR}
LDR		R12,[R1,#4]
LDR		R1,[R1]
;1st		TCD
BL		PACKTRIPLET 	;call subroutine,R1 is unchanged
mov		R4,R0
;2nd		TCD
LSR		R1,R1,#12
BL		PACKTRIPLET
ORR		R4,R4,R0,LSL #11
;3nd		TCD (if UNROLL, caulcate it first, use 1 less reg and some cycle)
LSR		R1,R1,#12
ORR		R1,R1,R12,LSL #8
BL		PACKTRIPLET
ORR		R0,R4,R0,LSL #22
;end
LDMFD	R13!,{R4,PC}

;====UNPACKTWORD====
;		not optimised
;		USE UNPACKTRIPLET, UNROLL if assist on cycle
;In		R1: Address of the 9 BCD for output
;		R0: TWORD
;Out		NONE
;Temp	r1,R2,R3,R4,R12

UNPACKTWORD				STMFD	R13!,{R4,R5,LR}
MOV		R12,R1
MOV		R4,R0
;1st		3BCD
MOV		R1,R4
BL		UNPACKTRIPLET
MOV		R5,R0
;2nd		3BCD
MOV		R1,R4,LSR #11
BL		UNPACKTRIPLET
ORR		R5,R5,R0,LSL #12
;3rd		3BCD
MOV		R1,R4,LSR #22
BL		UNPACKTRIPLET
ORR		R5,R5,R0,LSL #24
STR		R5,[R12],#4
MOV		R5,R0,LSR #8
STR		R5,[R12]
;store
LDMFD	R13!,{R4,R5,PC}

;====MULTRIPLE====
;In		R1: 1TCD (STRCILY 10 bit)
;		R2: 1TCD (May exceed 10 bit => binary, not TCD)
;Out		R0:
;Temp	R3,

MULTRIPLE					MOV		R0,#0
;MUL
LSLS		R1,R1,#23 ;mov 1 for caucaltion & 22 for set up
ADDCS	R0,R0,R2,LSL #9
ADDMI	R0,R0,R2,LSL #8
LSLS		R1,R1,#2
ADDCS	R0,R0,R2,LSL #7
ADDMI	R0,R0,R2,LSL #6
LSLS		R1,R1,#2
ADDCS	R0,R0,R2,LSL #5
ADDMI	R0,R0,R2,LSL #4
LSLS		R1,R1,#2
ADDCS	R0,R0,R2,LSL #3
ADDMI	R0,R0,R2,LSL #2
LSLS		R1,R1,#2
ADDCS	R0,R0,R2,LSL #1
ADDMI	R0,R0,R2,LSL #0
;split(METHOD_Y)	max error:998000/1024 => 4 if loop

;split(METHOD_X)	/1000 est *000000000100000110001
;MOV		R1,R0,LSL #22	;R1 => dec part from est, use to check rounding error. DOES not work (was ADC)
MOV		R2,R0,LSR #10 	;R2 => int part from est
;ADDS	R1,R1,R0, LSL #28	;check if dec overflow
ADD		R2,R2,R0,LSR #16	;add overflow to carry
;ADDS	R1,R1,R0, LSL #29
ADD		R2,R2,R0,LSR #17	;*00000000010000011000
;		R0*=R0-1000R2
SUB		R0,R0,R2,LSL #10
ADD		R0,R0,R2,LSL #4
ADD		R0,R0,R2,LSL #3
;		check R0 less than 1000
CMP		R0,#1000	; check rounding error
SUBHS	R0,R0,#1000
ADDHS	R2,R2,#1
CMP		R0,#1000	; check rounding error
MULTRIPLE_L1				SUBHS	R0,R0,#1000
ADDHS	R2,R2,#1
CMP		R0,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTRIPLE_L1 ;very unlikely to trigger, use BL reduce cycle by 1, triger in 999*999
;gen		output
ORR		R0,R0,R2,LSL #11

;end
mov		PC,LR


;====MULTIPLY====
;		Use Toom1,2,(3,4) for with if condition at end, default TC2 (possibly 3? if it would help)
;		All pointers (FA) are start-full pointers to an ascending array of little-endian ordered (LS triplet lowest word) LSB-aligned triplets stored one word per triplet.
;
;		A = 123456, where R0 is its pointer as input
;		��  +-------+--------------+
;		��  | 0x100 | 0x00 00 00 7B| <= pointer of R0 as input
;		��  +-------+--------------+
;		��  | 0x104 | 0x00 00 01 C8|
;		��  +-------+--------------+
;		diraction of more siginificant triplet digit
;
;In		R0: pointer for LS of A(TCD)
;		R1: pointer for LS of B(TCD)
;		R2: pointer for LS of C_OUTPUT(TCD)
;		R3: size of M (length of TCD)
;Out		NULL
;Temp	R4(counter),r5,r6


MULTIPLY ;MULTIPLY wapper�� jump to T2? use as wapper?
CMP		R3,#1
BEQ		MULTIPLY_EXP

;LDR		R12,=bufferMULT ; FA ;USE R13 TO OPT (consider stack allocation with R0123 & NOTE:FA=>FD)
STMFD	R13!,{R4,R5,R6,R7,R8,R9,R10,R11,LR} ; APCS compliant, all register can be used for scratch registers


BL		MULTIPLY_T2 ; no need to be APCS compliant

LDMFD	R13!,{R4,R5,R6,R7,R8,R9,R10,R11,PC}
;		end of code for MULTIPLY


MULTIPLY_EXP				STMFD	R13!,{R0,R1,R2,R3,LR} ;strach not need to save

;MUL
LDR		R0,[R0]
LDR		R1,[R1]

MOV		R3,#0
LSLS		R0,R0,#23 ;mov 1 for caucaltion & 22 for set up
ADDCS	R3,R3,R1,LSL #9
ADDMI	R3,R3,R1,LSL #8
LSLS		R0,R0,#2
ADDCS	R3,R3,R1,LSL #7
ADDMI	R3,R3,R1,LSL #6
LSLS		R0,R0,#2
ADDCS	R3,R3,R1,LSL #5
ADDMI	R3,R3,R1,LSL #4
LSLS		R0,R0,#2
ADDCS	R3,R3,R1,LSL #3
ADDMI	R3,R3,R1,LSL #2
LSLS		R0,R0,#2
ADDCS	R3,R3,R1,LSL #1
ADDMI	R3,R3,R1,LSL #0

MOV		R0,R3,LSR #10 	;R0 => int part from est
ADD		R0,R0,R3,LSR #16	;add overflow to carry
ADD		R0,R0,R3,LSR #17	;*00000000010000011000
SUB		R3,R3,R0,LSL #10
ADD		R3,R3,R0,LSL #4
ADD		R3,R3,R0,LSL #3
CMP		R3,#1000	; check rounding error
SUBHS	R3,R3,#1000
ADDHS	R0,R0,#1
CMP		R3,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_EXP_L1			SUBHS	R3,R3,#1000
ADDHS	R0,R0,#1
CMP		R3,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_EXP_L1

STR		R3,[R2]
STR		R0,[R2,#4]

;end
LDMFD	R13!,{R0,R1,R2,R3,PC}




MULTIPLY_T2
CMP		R3,#2 ;CMP M,#2 ;BE 4 TO OPT
BLS		MULTIPLY_T1
STMFD	R13!,{R0,R1,R2,R3,r12,LR} ;str current R0,R1,R2,R3

;make	output as A1B1:A0B0
;R3=0.5M
LSR		R3,R3,#1	;get M/2
BL		MULTIPLY_T2	;get A0B0 at LSW
ADD		R0,R0,R3,LSL #2
ADD		R1,R1,R3,LSL #2
ADD		R2,R2,R3,LSL #3	; (*4*1) muti 2 as output is twice size of input
BL		MULTIPLY_T2	;get A1B1 at MSW

;caculate	(A0-A1)&(B1-B0) /CAN BE OPTMISED (use base 2^11)
;X		CAN BE OPTMISED: add & mut less mome opt
;X		set R0,R1,R2
;X		R3,R12	USE AS TEMP REG FOR R0,R1
;X		sub 2M , add 2M on exist, there is no stack operation in between

;		R12:0000 0000 0000 0000 00CC CCCC CC00 0AON
;		A=0 => IS B 		A=1 => IS A (ONLY FOR SUB4)
;		N=0 => POSTIVE 	N=1 => NEGATIVE
;		C=> COUNTER
;		O =>dont care, overflow of N

CMP		R3,#4 ; to ADD2 if 0.5M=2, ADD4 if 0.5M=4, ADD8 if 0.5M>4
;BHI		MULTIPLY_T2_Z1_SUB8 ; FOR OPTIMISE
;BEQ		MULTIPLY_T2_Z1_SUB4
BGE		MULTIPLY_T2_Z1_SUB4

MULTIPLY_T2_Z1_SUB2
MULTIPLY_T2_Z1_SUB2_B		ADD		R1,R1,#8 ;+2
LDMDB	R1!,{R4,R5,R6,R7}
CMP		R7, R5
CMPEQ	R6,R4
;B0=B1
;TO		SPEICAL BRANCH, SKIP MULTIPLY_T2_Z1_MUL (0 ANYWAY)
;B1<B0	negative
BCC		MULTIPLY_T2_Z1_SUB2_B_NEG
;B1>B0	postive
MOV		R12,#0X0
SUBS		R6,R6,R4
ADDMI	R6,R6,#1000
SBC		R7,R7,R5

MULTIPLY_T2_Z1_SUB2_A		ADD		R0,R0,#8 ;+2
LDMDB	R0!,{R8,R9,R10,R11}
CMP		R9, R11
CMPEQ	R8, R10
;A0=A1
;TO		SPEICAL BRANCH, SKIP MULTIPLY_T2_Z1_MUL (0 ANYWAY)
;A0<A1	negative
BCC		MULTIPLY_T2_Z1_SUB2_A_NEG
;A0>A1	postive
SUBS		R8,R8,R10
ADDMI	R8,R8,#1000
SBC		R9,R9,R11

;STORE
MULTIPLY_T2_Z1_SUB2_STR		STMDB	R13,{R6,R7,R8,R9}
SUB		R0,R13,#8 	;2*4
SUB		R1,R13,#16 ;2*4*2
SUB		R13,R13,#32 ;2*4*2+4*4 ;space for (A0-A1)*(B1-B0)
MOV		R2,R13

MULTIPLY_T2_Z1_MUL			BL		MULTIPLY_T2 ; SPECIAL BRANCH TO MULTIPLY_T1_ADD

TST		R12,#0X1 ;MASK FOR N
BNE		MULTIPLY_T2_Z1_ADD_NEG_WAPPER ; FOR OPTIMISE

MULTIPLY_T2_Z1_ADD_POS_WAPPER	ADD		R0,R13,R3,LSL #4 ;(1M+2*0.5M)*4=16*0.5M
LDR		R0,[R0,#8] ; R0 is R2 in parents branch,
ADD		R12,R0,R3,LSL #3
;		R0=pointer of parent R2 A0B0, R12=pointer of A2B2, R2=pointer of current R2 (A1+A0)*(B1+B0)
;		place result to back to R2
;		no rounding

MULTIPLY_T2_Z1_ADD_POS		LDMIA	R12!,{R8,R9,R10,R11}
LDMIA	R0!, {R4,R5,R6,R7}


ADD		R4,R4,R8
ADD		R5,R5,R9
ADD		R6,R6,R10
ADD		R7,R7,R11

LDMIA	R2,{R8,R9,R10,R11}
ADD		R4,R4,R8
ADD		R5,R5,R9
ADD		R6,R6,R10
ADD		R7,R7,R11

STMIA	R2!,{R4,R5,R6,R7}
CMP		R1,R2
BNE		MULTIPLY_T2_Z1_ADD_POS

MULTIPLY_T2_Z1_FINAL_W		SUB		R2,R2,R3,LSL #3
SUB		R0,R0,R3,LSL #2
MOV		R7,#0
;		R0=pointer for A1B1, R2=pointer for not rounded Z1, R12 not used

MULTIPLY_T2_Z1_FINAL		LDMIA	R2!,{R8,R9,R10,R11}
ADD		R8,R8,R7 ;from previous carry
LDMIA	R0,{R4,R5,R6,R7}

ADD		R9,R5,R9
ADD		R10,R6,R10
ADD		R11,R7,R11
ADDS		R8,R4,R8 ;set flag, if negative

;rounding,	may be negative

;ROUNDING	R8 (rounding part in MULTIPLY_T1, CHANGE R11 TO R4)
BMI		MULTIPLY_T2_Z1_FINAL_R8_N
MULTIPLY_T2_Z1_FINAL_R8		MOV		R4,R8,LSR #10 	;R4 => int part from est
ADD		R4,R4,R8,LSR #16	;add overflow to carry
ADD		R4,R4,R8,LSR #17	;*00000000010000011000
SUB		R8,R8,R4,LSL #10
ADD		R8,R8,R4,LSL #4
ADD		R8,R8,R4,LSL #3
CMP		R8,#1000	; check rounding error
SUBHS	R8,R8,#1000
ADDHS	R4,R4,#1
CMP		R8,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R8_L	SUBHS	R8,R8,#1000
ADDHS	R4,R4,#1
CMP		R8,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T2_Z1_FINAL_R8_L
ADDS		R9,R9,R4

;ROUNDING	R9 (rounding part in MULTIPLY_T1, CHANGE R11 TO R4)
BMI		MULTIPLY_T2_Z1_FINAL_R9_N
MULTIPLY_T2_Z1_FINAL_R9		MOV		R4,R9,LSR #10 	;R4 => int part from est
ADD		R4,R4,R9,LSR #16	;add overflow to carry
ADD		R4,R4,R9,LSR #17	;*00000000010000011000
SUB		R9,R9,R4,LSL #10
ADD		R9,R9,R4,LSL #4
ADD		R9,R9,R4,LSL #3
CMP		R9,#1000	; check rounding error
SUBHS	R9,R9,#1000
ADDHS	R4,R4,#1
CMP		R9,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R9_L	SUBHS	R9,R9,#1000
ADDHS	R4,R4,#1
CMP		R9,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T2_Z1_FINAL_R9_L
ADDS		R10,R10,R4

;ROUNDING	R10
BMI		MULTIPLY_T2_Z1_FINAL_R10_N
MULTIPLY_T2_Z1_FINAL_R10		MOV		R4,R10,LSR #10 	;R4 => int part from est
ADD		R4,R4,R10,LSR #16	;add overflow to carry
ADD		R4,R4,R10,LSR #17	;*00000000010000011000
SUB		R10,R10,R4,LSL #10
ADD		R10,R10,R4,LSL #4
ADD		R10,R10,R4,LSL #3
CMP		R10,#1000	; check rounding error
SUBHS	R10,R10,#1000
ADDHS	R4,R4,#1
CMP		R10,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R10_L	SUBHS	R10,R10,#1000
ADDHS	R4,R4,#1
CMP		R10,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T2_Z1_FINAL_R10_L
ADDS		R11,R11,R4

;ROUNDING	R11
BMI		MULTIPLY_T2_Z1_FINAL_R11_N
MULTIPLY_T2_Z1_FINAL_R11		MOV		R7,R11,LSR #10 	;R4 => int part from est
ADD		R7,R7,R11,LSR #16	;add overflow to carry
ADD		R7,R7,R11,LSR #17	;*00000000010000011000
SUB		R11,R11,R7,LSL #10
ADD		R11,R11,R7,LSL #4
ADD		R11,R11,R7,LSL #3
CMP		R11,#1000	; check rounding error
SUBHS	R11,R11,#1000
ADDHS	R7,R7,#1
CMP		R11,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T2_Z1_FINAL_R11_L	SUBHS	R11,R11,#1000
ADDHS	R7,R7,#1
CMP		R11,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T2_Z1_FINAL_R11_L


MULTIPLY_T2_Z1_FINAL_R		CMP		R1,R2
STMIA	R0!,{R8,R9,R10,R11}
BNE		MULTIPLY_T2_Z1_FINAL
;exit	loop if is last one

LSL		R5,R3,#4 ;temp R5, as "ADD R13,R13,R3, LSL #4" is not vaild ; can be optmised
ADD		R13,R13,R5
CMP		R7,#0
LDMFDeq	R13!,{R0,R1,R2,R3,r12,PC}

MULTIPLY_T2_Z1_FINAL_OVERFLOW	LDR		R4,[R0] ;get next MS TRIPLET OF CURRENT OUTPUT (start pointer for A2B2)
ADD		R4,R4,R7
SUBS		R5,R4, #1000 ; ANOTHER TEMP REG R5

;no		further overflow
STRlt	R4,[R0]
LDMFDlt	R13!,{R0,R1,R2,R3,r12,PC}

;further	overflow
MOV		R7,#1
STR		R5,[R0],#4
B		MULTIPLY_T2_Z1_FINAL_OVERFLOW

end		; END of MULTIPLY, this line should not executed

;		============ BELOW ARE FUNCTIONS
MULTIPLY_T2_Z1_SUB2_B_NEG	MOV		R12,#0X1
SUBS		R6,R4,R6
ADDMI	R6,R6,#1000
SBC		R7,R5,R7
B		MULTIPLY_T2_Z1_SUB2_A

MULTIPLY_T2_Z1_SUB2_A_NEG	add		R12,R12,#0X1
SUBS		R8,R10,R8
ADDMI	R8,R8,#1000
SBC		R9,R11,R9
B		MULTIPLY_T2_Z1_SUB2_STR


MULTIPLY_T2_Z1_ADD_NEG_WAPPER	ADD		R0,R13,R3,LSL #4 ;(1M+2*0.5M)*4=16*0.5M
LDR		R0,[R0,#8] ; R0 is R2 in parents branch,
ADD		R12,R0,R3,LSL #3
MOV		R7,#0
;		R0=pointer of parent R2 A0B0, R12=pointer of A2B2, R2=pointer of current R2 (A1-A0)*(B1-B0)
;		place result to R0+R3 (LSL #2)

MULTIPLY_T2_Z1_ADD_NEG		LDMIA	R12!,{R8,R9,R10,R11}
LDMIA	R0!, {R4,R5,R6,R7}


ADD		R4,R4,R8
ADD		R5,R5,R9
ADD		R6,R6,R10
ADD		R7,R7,R11

LDMIA	R2,{R8,R9,R10,R11}
SUB		R4,R4,R8
SUB		R5,R5,R9
SUB		R6,R6,R10
SUB		R7,R7,R11

STMIA	R2!, {R4,R5,R6,R7}
CMP		R1,R2
BNE		MULTIPLY_T2_Z1_ADD_NEG
B		MULTIPLY_T2_Z1_FINAL_W

;need	opt, use shift & est, see example:789741123456*852963410520, cause too much loop
MULTIPLY_T2_Z1_FINAL_R8_N	RSB		R8,R8,#0
MOV		R4,R8,LSR #10 	;R4 => BORROW
ADD		R4,R4,R8,LSR #16
ADD		R4,R4,R8,LSR #17
SUB		R8,R8,R4,LSL #10
ADD		R8,R8,R4,LSL #4
ADDS		R8,R8,R4,LSL #3
ADDGT	R4,R4,#1
SUBSGT	R8,R8,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R8_N_L	ADDGT	R4,R4,#1
SUBSGT	R8,R8,#1000			;CHECK
BGT		MULTIPLY_T2_Z1_FINAL_R8_N_L

RSB		R8,R8,#0
SUBS		R9,R9,R4
BGE		MULTIPLY_T2_Z1_FINAL_R9

MULTIPLY_T2_Z1_FINAL_R9_N	RSB		R9,R9,#0
MOV		R4,R9,LSR #10 	;R4 => BORROW
ADD		R4,R4,R9,LSR #16
ADD		R4,R4,R9,LSR #17
SUB		R9,R9,R4,LSL #10
ADD		R9,R9,R4,LSL #4
ADDS		R9,R9,R4,LSL #3
ADDGT	R4,R4,#1
SUBSGT	R9,R9,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R9_N_L	ADDGT	R4,R4,#1
SUBSGT	R9,R9,#1000			;CHECK
BGT		MULTIPLY_T2_Z1_FINAL_R9_N_L

RSB		R9,R9,#0
SUBS		R10,R10,R4
BGE		MULTIPLY_T2_Z1_FINAL_R10

MULTIPLY_T2_Z1_FINAL_R10_N	RSB		R10,R10,#0
MOV		R4,R10,LSR #10 	;R4 => BORROW
ADD		R4,R4,R10,LSR #16
ADD		R4,R4,R10,LSR #17
SUB		R10,R10,R4,LSL #10
ADD		R10,R10,R4,LSL #4
ADDS		R10,R10,R4,LSL #3
ADDGT	R4,R4,#1
SUBSGT	R10,R10,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R10_N_L	ADDGT	R4,R4,#1
SUBSGT	R10,R10,#1000			;CHECK
BGT		MULTIPLY_T2_Z1_FINAL_R10_N_L

RSB		R10,R10,#0
SUBS		R11,R11,R4
BGE		MULTIPLY_T2_Z1_FINAL_R11

MULTIPLY_T2_Z1_FINAL_R11_N	RSB		R11,R11,#0
MOV		R7,R11,LSR #10 	;R7 => BORROW
ADD		R7,R7,R11,LSR #16
ADD		R7,R7,R11,LSR #17
SUB		R11,R11,R7,LSL #10
ADD		R11,R11,R7,LSL #4
ADDS		R11,R11,R7,LSL #3
ADDGT	R7,R7,#1
SUBSGT	R11,R11,#1000			;CHECK
MULTIPLY_T2_Z1_FINAL_R11_N_L	ADDGT	R7,R7,#1
SUBSGT	R11,R11,#1000			;CHECK
BGT		MULTIPLY_T2_Z1_FINAL_R11_N_L

RSB		R7,R7,#0
RSB		R11,R11,#0
B		MULTIPLY_T2_Z1_FINAL_R


;MULTIPLY_T2_Z1_SUB8
MULTIPLY_T2_Z1_SUB4			;R2 	=> pointer for of B1 & A1
;R0,R1	=> pointer for of B0 & A0
;R12[13..4]	=> for countdown, already shifted by 2 0.5M=R12[13..6]
;can		be OPT (STR 1 REG, use it for pointer of A2B2)
;


MULTIPLY_T2_Z1_SUB4_A_W		ADD		R2,R0,R3,LSL #2
MOV		R12,#0X4 	;set A=1,N=0
ADD		R12,R12,R3,LSL #6	;set A=1,N=0,C=0.5M, as 0.5M in range of 0 - 32
SUB		R13,R13,R3,LSL #2	;make space for |A0-A1|

MULTIPLY_T2_Z1_SUB4_A		LDMDB	R0!,{R4,R5,R6,R7}
LDMDB	R2!,{R8,R9,R10,R11}

CMP		R7,R11
CMPEQ	R6,R10
CMPEQ	R5,R9
CMPEQ	R4,R8
SUB		R12,R12,#0X100 ;counter-4

;B1<B0	negative
ADDCC	R12,R12,#0X1
BCC		MULTIPLY_T2_Z1_SUB4_1SUB0_W
;B1>B0	postive
BHI		MULTIPLY_T2_Z1_SUB4_0SUB1_W

;B0=B1	check if is last one
TST		R12,#0X3FC0 ;get counter & test
BNE		MULTIPLY_T2_Z1_SUB4_A
;if		is last, still equal => (A0-A1)(B1-B0)=0 => OPT
;		temp soulstion
B		MULTIPLY_T2_Z1_SUB4_0SUB1_W

MULTIPLY_T2_Z1_SUB4_B_W		ADD		R2,R1,R3,LSL #2
AND		R12,R12,#0X1 	;only copy N, A=0, , reset counter,
ADD		R12,R12,R3,LSL #6		;A=0, C=0.5M, N=previous
SUB		R13,R13,R3,LSL #3 ;make space for |B0-B1|, was at MSW of |A0-A1|

MULTIPLY_T2_Z1_SUB4_B		LDMDB	R1!,{R4,R5,R6,R7}
LDMDB	R2!,{R8,R9,R10,R11}

CMP		R11,R7
CMPEQ	R10,R6
CMPEQ	R9,R5
CMPEQ	R8,R4
SUB		R12,R12,#0X100 	;counter-4

;B1<B0	negative
ADDCC	R12,R12,#0X1
BCC		MULTIPLY_T2_Z1_SUB4_0SUB1_W
;B1>B0	postive
BHI		MULTIPLY_T2_Z1_SUB4_1SUB0_W

;B0=B1	check if is last one
TST		R12,#0X3FC0			;get counter & test
BNE		MULTIPLY_T2_Z1_SUB4_B
;if		is last, still equal => (A0-A1)(B1-B0)=0 => OPT
;		temp soulstion
B		MULTIPLY_T2_Z1_SUB4_0SUB1_W


;in		MULTIPLY_T2_Z1_SUB4_0SUB1 & _1SUB0,
;R12		=> R/W counter & R A
;R2		=> pointer for A1 & B1 (start LSW)
;R0		=> pointer for A0 & B0 (start LSW), can overwrite R0, as cacl A before B
;R13		=> pointer for output (start LSW)
MULTIPLY_T2_Z1_SUB4_0SUB1_W	TST		R12,#0X4 			;get A flag
SUBne	R0,R0,R12,LSR #4	;A=1 for A, reset pointer
SUBeq	R0,R1,R12,LSR #4	;A=0 for B, reset pointer
ADD		R2,R0,R3,LSL #2
AND		r12,R12,#0x5			;reset counter
ADD		R12,R12,R3, LSL #6	;set counter
mov		r7,r11				;FORCE SET CARRY FLAG

MULTIPLY_T2_Z1_SUB4_0SUB1	cmp		r7,r11
LDMIA	R0!,{R4,R5,R6,R7}
LDMIA	R2!,{R8,R9,R10,R11}

SBCS		R4,R4,R8
ADDMI	R4,R4,#1000
SBCS		R5,R5,R9
ADDMI	R5,R5,#1000
SBCS		R6,R6,R10
ADDMI	R6,R6,#1000
SBCS		R8,R7,R11 ;preservie R7, for cmp r7,r11
ADDMI	R8,R8,#1000
STMIA	R13!,{R4,R5,R6,R8}

SUB		R12,R12,#0X100
TST		R12,#0X3FC0
BNE		MULTIPLY_T2_Z1_SUB4_0SUB1

TST		R12,#0X4
BNE		MULTIPLY_T2_Z1_SUB4_B_W ;A=1, form A, cal B next
;		A=0, form B, do MULTIPLY_T2_Z1_MUL next
MOV		R0,R13 ;pointer at LSW of |A1-A0|
SUB		R1,R13,R3,LSL #2 ;move pointer to LSW of |B0-B1|
SUB		R2,R1,R3,LSL #3 ;move pointer to LSW of Z1
MOV		R13,R2
B		MULTIPLY_T2_Z1_MUL

MULTIPLY_T2_Z1_SUB4_1SUB0_W	TST		R12,#0X4 			;get A flag
SUBne	R0,R0,R12,LSR #4	;A=1 for A, reset pointer
SUBeq	R0,R1,R12,LSR #4	;A=0 for B, reset pointer
ADD		R2,R0,R3,LSL #2
AND		r12,R12,#0x5			;reset counter
ADD		R12,R12,R3, LSL #6	;set counter
mov		r7,r11			;FORCE SET CARRY FLAG

MULTIPLY_T2_Z1_SUB4_1SUB0	cmp		r11,r7
LDMIA	R0!,{R4,R5,R6,R7}
LDMIA	R2!,{R8,R9,R10,R11}

SBCS		R4,R8,R4
ADDMI	R4,R4,#1000
SBCS		R5,R9,R5
ADDMI	R5,R5,#1000
SBCS		R6,R10,R6
ADDMI	R6,R6,#1000
SBCS		R8,R11,R7
ADDMI	R8,R8,#1000
STMIA	R13!,{R4,R5,R6,R8}

SUB		R12,R12,#0X100
TST		R12,#0X3FC0
BNE		MULTIPLY_T2_Z1_SUB4_1SUB0

TST		R12,#0X4
BNE		MULTIPLY_T2_Z1_SUB4_B_W ;A=1 form A, cal B next
;		A=0 form A, do MULTIPLY_T2_Z1_MUL next
MOV		R0,R13 ;pointer at LSW of |A1-A0|
SUB		R1,R13,R3,LSL #2 ;move pointer to LSW of |B0-B1|
SUB		R2,R1,R3,LSL #3 ;move pointer to LSW of Z1
MOV		R13,R2
B		MULTIPLY_T2_Z1_MUL


MULTIPLY_T1 	;	  R5|R4
;		X R7|R6
;result:	R11|R10|R9|R8
;R11:	TEMP FOR SHIFT & ROUNDING
LDR		R4,[R0]
LDR		R5,[R0,#4]
LDR		R6,[R1]
LDR		R7,[R1,#4]

;FIRST	R8=R4*R6
MOV		R8,#0

LSLS		R11,R4,#23 ;mov 1 for caucaltion & 22 for set up
ADDCS	R8,R8,R6,LSL #9
ADDMI	R8,R8,R6,LSL #8
LSLS		R11,R11,#2
ADDCS	R8,R8,R6,LSL #7
ADDMI	R8,R8,R6,LSL #6
LSLS		R11,R11,#2
ADDCS	R8,R8,R6,LSL #5
ADDMI	R8,R8,R6,LSL #4
LSLS		R11,R11,#2
ADDCS	R8,R8,R6,LSL #3
ADDMI	R8,R8,R6,LSL #2
LSLS		R11,R11,#2
ADDCS	R8,R8,R6,LSL #1
ADDMI	R8,R8,R6,LSL #0

;LAST	R10=R5*R7
MOV		R10,#0

LSLS		R11,R5,#23 ;mov 1 for caucaltion & 22 for set up
ADDCS	R10,R10,R7,LSL #9
ADDMI	R10,R10,R7,LSL #8
LSLS		R11,R11,#2
ADDCS	R10,R10,R7,LSL #7
ADDMI	R10,R10,R7,LSL #6
LSLS		R11,R11,#2
ADDCS	R10,R10,R7,LSL #5
ADDMI	R10,R10,R7,LSL #4
LSLS		R11,R11,#2
ADDCS	R10,R10,R7,LSL #3
ADDMI	R10,R10,R7,LSL #2
LSLS		R11,R11,#2
ADDCS	R10,R10,R7,LSL #1
ADDMI	R10,R10,R7,LSL #0

;MIDDLE	R9=(R5+R4)(R7+R6)-FIRST-LAST
MOV		R9,#0
ADD		R5,R5,R4
ADD		R7,R6,R7

LSLS		R11,R5,#22 ;mov 1 for caucaltion & 22 for set up
ADDCS	R9,R9,R7,LSL #10
LSLS		R11,R11,#1
ADDCS	R9,R9,R7,LSL #9
ADDMI	R9,R9,R7,LSL #8
LSLS		R11,R11,#2
ADDCS	R9,R9,R7,LSL #7
ADDMI	R9,R9,R7,LSL #6
LSLS		R11,R11,#2
ADDCS	R9,R9,R7,LSL #5
ADDMI	R9,R9,R7,LSL #4
LSLS		R11,R11,#2
ADDCS	R9,R9,R7,LSL #3
ADDMI	R9,R9,R7,LSL #2
LSLS		R11,R11,#2
ADDCS	R9,R9,R7,LSL #1
ADDMI	R9,R9,R7,LSL #0

SUB		R9,R9,R8
SUB		R9,R9,R10
MOV		R11,#0

;EXIST	LOOP IF IS FROM (A0-A1)(B1-B0)
CMP		R13, R2
STMIAEQ	R2,{R11,R10,R9,R8} ;OPT: dont store to memory, use directlly
MOVEQ	PC,LR

;ROUNDING	R8
MOV		R11,R8,LSR #10 	;R11 => int part from est
ADD		R11,R11,R8,LSR #16	;add overflow to carry
ADD		R11,R11,R8,LSR #17	;*00000000010000011000
SUB		R8,R8,R11,LSL #10
ADD		R8,R8,R11,LSL #4
ADD		R8,R8,R11,LSL #3
CMP		R8,#1000	; check rounding error
SUBHS	R8,R8,#1000
ADDHS	R11,R11,#1
CMP		R8,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T1_L1				SUBHS	R8,R8,#1000
ADDHS	R11,R11,#1
CMP		R8,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T1_L1
ADD		R9,R9,R11

;ROUNDING	R9
MOV		R11,R9,LSR #10 	;R11 => int part from est
ADD		R11,R11,R9,LSR #16	;add overflow to carry
ADD		R11,R11,R9,LSR #17	;*00000000010000011000
SUB		R9,R9,R11,LSL #10
ADD		R9,R9,R11,LSL #4
ADD		R9,R9,R11,LSL #3
CMP		R9,#1000	; check rounding error
SUBHS	R9,R9,#1000
ADDHS	R11,R11,#1
CMP		R9,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T1_L2				SUBHS	R9,R9,#1000
ADDHS	R11,R11,#1
CMP		R9,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T1_L2
ADD		R10,R10,R11

;ROUNDING	R10 & R11
MOV		R11,R10,LSR #10 	;R11 => int part from est
ADD		R11,R11,R10,LSR #16	;add overflow to carry
ADD		R11,R11,R10,LSR #17	;*00000000010000011000
SUB		R10,R10,R11,LSL #10
ADD		R10,R10,R11,LSL #4
ADD		R10,R10,R11,LSL #3
CMP		R10,#1000	; check rounding error
SUBHS	R10,R10,#1000
ADDHS	R11,R11,#1
CMP		R10,#1000	; check rounding error caused by rounding error from decimal
MULTIPLY_T1_L3				SUBHS	R10,R10,#1000
ADDHS	R11,R11,#1
CMP		R10,#1000	; check rounding error caused by rounding error from decimal
BHS		MULTIPLY_T1_L3

STMIA	R2,{R11,R10,R9,R8}
MOV		PC,LR



RECIPROCAL				MOV		PC, LR

SQUAREROOT				MOV		PC,LR

TEST END OF FILE
