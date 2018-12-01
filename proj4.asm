ARR .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0
    .INT 0

CNT .INT 0
ONE .INT 1
ZERO .INT 0
F .BYT F
i .BYT i
b .BYT b
o .BYT o
n .BYT n
a .BYT a
c .BYT c
f .BYT f
s .BYT s
SPACE .BYT 32
NEWLINE .BYT 10

mainWhile TRP 2
MOV R4 R3
LDR R5 ZERO
CMP R4 R5
BRZ R4 endMainWhile

MOV FP SP   # Here we are
ADI SP -8   # making
STR R3 SP   # an
ADI SP -8   # (There is a -8 here because the size of a record for fib is 12)
MOV R0 PC   # activation 
ADI R0 36   # record for
STR R0 FP   # fib(int n)
JMP fib

LDA R0 ARR  # Here we store X and Y in ARR[CNT] and ARR[CNT+1]
LDR R1 CNT
ADD R0 R1
STR R3 R0   # ARR[CNT] = X
ADI R0 4
LDR R4 SP
STR R4 R0
ADI R1 8
STR R1 CNT
MOV R4 R3
LDB R3 F
TRP 3
LDB R3 i
TRP 3
LDB R3 b
TRP 3
LDB R3 o
TRP 3
LDB R3 n
TRP 3
LDB R3 a
TRP 3
LDB R3 c
TRP 3
TRP 3
LDB R3 i
TRP 3
LDB R3 SPACE
TRP 3
LDB R3 o
TRP 3
LDB R3 f
TRP 3
LDB R3 SPACE
TRP 3
MOV R3 R4
TRP 1
LDB R3 SPACE
TRP 3
LDB R3 i
TRP 3
LDB R3 s
TRP 3
LDB R3 SPACE
TRP 3

LDR R3 SP
TRP 1
LDB R3 NEWLINE
TRP 3

JMP mainWhile

endMainWhile LDR R0 ZERO
LDR R1 CNT
printLoop   LDA R2 ARR # Loop to print ARR values
            ADD R2 R0
            LDR R3 R2
            TRP 1
            ADI R0 4
            LDB R3 SPACE
            TRP 3
            LDA R2 ARR
            ADI R1 -4
            ADD R2 R1
            LDR R3 R2
            TRP 1
            LDB R3 SPACE
            TRP 3

            MOV R4 R0
            MOV R5 R1
            CMP R4 R5
            BRZ R4 endPrintLoop

            JMP printLoop

endPrintLoop TRP 0

fib LDR R1 ONE
    MOV R2 FP
    ADI R2 -8
    LDR R0 R2
    CMP R0 R1

    BGT R0 fibElse # if (n <= 1)
        LDR R0 ONE

        MOV SP FP # SP = FP
        MOV R2 FP # FP 
        ADI R2 -4 # = 
        LDR FP R2 # PFP
        LDR R1 SP
        STR R0 SP
        JMR R1

    fibElse MOV R2 FP # load "n" into R0
            ADI R2 -8
            LDR R0 R2 # n - 1
            ADI R0 -1

            MOV R1 FP
            MOV FP SP
            ADI SP -4
            STR R1 SP
            ADI SP -4
            STR R0 SP
            ADI SP -8 # (There is a -8 here because the size of a record for fib is 12)
            MOV R1 PC
            ADI R1 36
            STR R1 FP

            JMP fib

            LDR R4 SP # Store fib(n-1) in R4, then into activation record
            MOV R2 FP
            ADI R2 -12
            STR R4 R2

            MOV R2 FP # load "n" into R0
            ADI R2 -8
            LDR R0 R2
            ADI R0 -2 # n - 2

            MOV R1 FP
            MOV FP SP
            ADI SP -4
            STR R1 SP
            ADI SP -4
            STR R0 SP
            ADI SP -8 # (There is a -8 here because the size of a record for fib is 12)
            MOV R1 PC
            ADI R1 36
            STR R1 FP
            JMP fib

            LDR R5 SP # Store fib(n-2) in R5

            MOV R2 FP
            ADI R2 -12
            LDR R4 R2

            ADD R4 R5 # Store fib(n-1) + fib(n-2) in R4

            MOV SP FP # SP = FP
            MOV R2 FP # FP 
            ADI R2 -4 # = 
            LDR FP R2 # PFP
            LDR R1 SP
            STR R4 SP
            JMR R1
