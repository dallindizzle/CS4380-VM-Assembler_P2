SIZE .INT 7
cnt .INT 0
tenth .INT 0
c .BYT 0
  .BYT 0
  .BYT 0
  .BYT 0
  .BYT 0
  .BYT 0
  .BYT 0
data .INT 0
flag .INT 0
opdv .INT 0
ZERO .INT 0
ONE .INT 1
NEWLINE .BYT 10
AT .BYT @
PLUS .BYT +
MINUS .BYT -

ZEROC .BYT 48
ONEC .BYT 49
TWOC .BYT 50
THREEC .BYT 51
FOURC .BYT 52
FIVEC .BYT 53
SIXC .BYT 54
SEVENC .BYT 55
EIGHTC .BYT 56
NINEC .BYT 57
i .BYT i
s .BYT s
n .BYT n
o .BYT o
t .BYT t
a .BYT a 
u .BYT u
m .BYT m
b .BYT b
e .BYT e 
p .BYT p
d .BYT d
r .BYT r
B .BYT B
g .BYT g
N .BYT N
O .BYT O
SPACE .BYT 32

MOV FP SP # Here we start making an activation record for reset(1, 0, 0, 0)
ADI SP -8
ADI R0 1
STR R0 SP
ADI SP -4
ADI R0 -1
STR R0 SP
ADI SP -4
STR R0 SP
ADI SP -4 
STR R0 SP
ADI SP -4
MOV R1 PC
ADI R1 36
STR R1 FP
JMP reset

MOV FP SP   # Here we are
ADI SP -4   # making an
MOV R0 PC   # activation 
ADI R0 36   # record for
STR R0 FP   # getdata()
JMP getdata

MainWhile   LDB R0 c # (while (c[0] != -))
            LDB R1 AT
            CMP R0 R1
            BRZ R0 MainEndWhile
                LDB R0 c    # (if (c[0] == '+'))
                LDB R1 PLUS
                LDB R2 MINUS
                CMP R0 R1
                BRZ R0 IsMinusOrPlus
                LDB R0 c
                CMP R0 R2
                BNZ R0 ELSE
                IsMinusOrPlus   MOV FP SP
                                ADI SP -4   # making an
                                MOV R0 PC   # activation 
                                ADI R0 36   # record for
                                STR R0 FP   # getdata()
                                JMP getdata
                                JMP SecondWhile

            ELSE    LDA R0 c    # Here we make 
                    ADI R0 1    # c[1]
                    LDB R1 c    # = 
                    STB R1 R0   # c[0]
                    LDA R0 c    # Here we make 
                    LDB R1 PLUS # c[0] = 
                    STB R1 R0   # '+'
                    LDR R0 cnt 
                    ADI R0 1
                    STR R0 cnt
            SecondWhile LDR R0 data
                        BRZ R0 EndSecondWhile
                        LDA R0 c    # if (c[cnt-1] == '\n)
                        LDR R1 cnt
                        ADI R1 -1
                        ADD R0 R1
                        LDB R2 R0
                        LDB R1 NEWLINE
                        CMP R2 R1
                        BNZ R2 SecondElse
                            LDR R0 ZERO
                            STR R0 data
                            LDR R0 ONE
                            STR R0 tenth
                            LDR R0 cnt
                            ADI R0 -2
                            STR R0 cnt
                            ThirdWhile  LDR R0 flag
                                        BNZ R0 EndThirdWhile
                                        LDR R0 cnt
                                        BRZ R0 EndThirdWhile
                                            MOV FP SP   # Here we are
                                            ADI SP -4   # making an activation recrod for opd(c[0], tenth, c[cnt])
                                            LDB R0 c
                                            STB R0 SP
                                            ADI SP -4
                                            LDR R0 tenth
                                            STR R0 SP
                                            ADI SP -4
                                            LDA R0 c
                                            LDR R1 cnt
                                            ADD R0 R1
                                            LDB R2 R0 
                                            STR R2 SP
                                            ADI SP -4

                                            MOV R0 PC
                                            ADI R0 36
                                            STR R0 FP
                                            JMP opd

                                            LDR R0 cnt  # (cnt--)
                                            ADI R0 -1
                                            STR R0 cnt

                                            LDR R0 tenth    # (tenth *= 10)
                                            LDR R1 ZERO
                                            ADI R1 10
                                            MUL R0 R1
                                            STR R0 tenth
                                            JMP ThirdWhile


                            EndThirdWhile   LDR R0 flag # (if (!flag))
                                            BNZ R0 SecondElse
                                            LDB R3 O
                                            TRP 3
                                            LDB R3 p
                                            TRP 3
                                            LDB R3 e
                                            TRP 3
                                            LDB R3 r
                                            TRP 3
                                            LDB R3 a
                                            TRP 3
                                            LDB R3 n
                                            TRP 3
                                            LDB R3 d
                                            TRP 3
                                            LDB R3 SPACE
                                            TRP 3
                                            LDB R3 i
                                            TRP 3
                                            LDB R3 s
                                            TRP 3
                                            LDB R3 SPACE
                                            TRP 3
                                            LDR R3 opdv
                                            TRP 1
                                            LDB R3 NEWLINE
                                            TRP 3
                                            JMP SecondWhile

                        SecondElse  MOV FP SP   # Here we are
                                    ADI SP -4   # making an
                                    MOV R0 PC   # activation 
                                    ADI R0 36   # record for
                                    STR R0 FP   # getdata()
                                    JMP getdata
                                    JMP SecondWhile

            EndSecondWhile  MOV FP SP # Here we start making an activation record for reset(1, 0, 0, 0)
                            ADI SP -8
                            ADI R0 1
                            STR R0 SP
                            ADI SP -4
                            ADI R0 -1
                            STR R0 SP
                            ADI SP -4
                            STR R0 SP
                            ADI SP -4 
                            STR R0 SP
                            ADI SP -4
                            MOV R1 PC
                            ADI R1 36
                            STR R1 FP
                            JMP reset

                            MOV FP SP   # Here we are
                            ADI SP -4   # making an
                            MOV R0 PC   # activation 
                            ADI R0 36   # record for
                            STR R0 FP   # getdata()
                            JMP getdata
                            JMP MainWhile

MainEndWhile    TRP 0

reset   STR R0 SP
        ADI SP -4
        MOV R0 FP
        ADI R0 -28
        resetFOR    LDR R1 R0
                    LDR R2 SIZE
                    CMP R1 R2
                    BRZ R1 resetEnd
                    LDR R1 R0
                    LDA R3 c
                    ADD R3 R1
                    LDB R4 ZERO
                    STB R4 R3 
                    ADI R1 1
                    STR R1 R0
                    JMP resetFOR
        
        resetEnd MOV R0 FP
        ADI R0 -8
        LDR R1 R0 
        STR R1 data
        ADI R0 -4
        LDR R1 R0
        STR R1 opdv
        ADI R0 -4
        LDR R1 R0
        STR R1 cnt
        ADI R0 -4
        LDR R1 R0 
        STR R1 flag

        MOV SP FP
        LDR R0 FP
        JMR R0

getdata LDR R0 cnt # getdata function
		LDR R1 SIZE
        CMP R0 R1
		BRZ R0 getdataElse
		LDR R0 cnt
		TRP 4
		LDA R4 c
		ADD R4 R0
		STB R3 R4
		ADI R0 1
		STR R0 cnt

		MOV SP FP
		LDR R5 SP
		JMR R5

		getdataElse LDB R3 N
		TRP 3
        LDB R3 u
        TRP 3
        LDB R3 m
        TRP 3
        LDB R3 b
        TRP 3
        LDB R3 e
        TRP 3
        LDB R3 r
        TRP 3
        LDB R3 SPACE
        TRP 3
        LDB R3 t
        TRP 3
        LDB R3 o
        TRP 3
        TRP 3
        LDB R3 SPACE
        TRP 3
        LDB R3 B
        TRP 3
        LDB R3 i
        TRP 3
        LDB R3 g
        TRP 3
        LDB R3 NEWLINE
        TRP 3
        MOV R3 FP # Create activation record for flush function
        MOV FP SP
        ADI SP -4
        STR R3 SP
        MOV R1 PC
        ADI R1 36
        STR R1 FP

        JMP flush

		MOV SP FP
		LDR R5 SP

		JMR R5

flush   LDR R0 ZERO
        STR R0 data
        TRP 4
        STB R3 c
        WHILE   LDB R1 NEWLINE
                LDB R2 c
                CMP R2 R1
                BRZ R2 flushEnd
                TRP 4
                STB R3 c
				JMP WHILE
        flushEnd    MOV SP FP
                    MOV R6 FP
                    ADI R6 -4
                    LDR FP R6
                    LDR R5 SP
                    JMR R5

opd LDR R0 ZERO
    STR R0 SP
    ADI SP -4

    MOV R0 FP # Here we load the value of j into R0
    ADI R0 -12
    LDB R1 R0

    LDB R2 ZEROC
    CMP R1 R2
                BNZ R1 opdElseIf
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    STR R1 R0
                    JMP opdEndIf
    opdElseIf   LDB R1 R0 
                LDB R2 ONEC
                CMP R1 R2
                BNZ R1 opdElseIf2
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 1
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf2  LDB R1 R0
                LDB R2 TWOC
                CMP R1 R2
                BNZ R1 opdElseIf3
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 2
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf3  LDB R1 R0
                LDB R2 THREEC
                CMP R1 R2
                BNZ R1 opdElseIf4
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 3
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf4  LDB R1 R0
                LDB R2 FOURC
                CMP R1 R2
                BNZ R1 opdElseIf5
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 4
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf5  LDB R1 R0
                LDB R2 FIVEC
                CMP R1 R2
                BNZ R1 opdElseIf6
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 5
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf6  LDB R1 R0
                LDB R2 SIXC
                CMP R1 R2
                BNZ R1 opdElseIf7
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 6
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf7  LDB R1 R0
                LDB R2 SEVENC
                CMP R1 R2
                BNZ R1 opdElseIf8
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 7
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf8  LDB R1 R0
                LDB R2 EIGHTC
                CMP R1 R2
                BNZ R1 opdElseIf9
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 8
                    STR R1 R0 
                    JMP opdEndIf
    opdElseIf9  LDB R1 R0
                LDB R2 NINEC
                CMP R1 R2
                BNZ R1 opdElse
                    MOV R0 FP
                    ADI R0 -16
                    LDR R1 ZERO
                    ADI R1 9
                    STR R1 R0 
                    JMP opdEndIf
    opdElse     LDB R3 R0
                TRP 3
                LDB R3 SPACE
                TRP 3
                LDB R3 i
                TRP 3
                LDB R3 s
                TRP 3
                LDB R3 SPACE
                TRP 3
                LDB R3 n
                TRP 3
                LDB R3 o
                TRP 3
                LDB R3 t
                TRP 3
                LDB R3 SPACE
                TRP 3
                LDB R3 a
                TRP 3
                LDB R3 SPACE
                TRP 3
                LDB R3 n
                TRP 3
                LDB R3 u
                TRP 3
                LDB R3 m
                TRP 3
                LDB R3 b
                TRP 3
                LDB R3 e
                TRP 3
                LDB R3 r
                TRP 3
                LDB R3 NEWLINE
                TRP 3
                LDR R1 ONE
                STR R1 flag

    opdEndIf    LDR R0 flag
                BNZ R0 opdElse2
                    MOV R0 FP
                    ADI R0 -4
                    LDB R1 R0
                    LDB R2 PLUS
                    CMP R1 R2
                    BNZ R1 opdElse3
                        MOV R0 FP
                        ADI R0 -16
                        LDR R1 R0
                        MOV R0 FP
                        ADI R0 -8
                        LDR R2 R0
                        MUL R1 R2
                        MOV R0 FP
                        ADI R0 -16
                        STR R1 R0
                        JMP opdEndIf2
                    opdElse3 MOV R0 FP
                        ADI R0 -16
                        LDR R1 R0
                        MOV R0 FP
                        ADI R0 -8
                        LDR R2 R0
                        LDR R3 ZERO
                        SUB R3 R2
                        MUL R1 R3
                        MOV R0 FP
                        ADI R0 -16
                        STR R1 R0
                opdEndIf2   LDR R0 opdv
                            MOV R1 FP
                            ADI R1 -16
                            LDR R2 R1
                            ADD R0 R2
                            STR R0 opdv

                opdElse2    MOV SP FP
                LDR R5 SP
                JMR R5
