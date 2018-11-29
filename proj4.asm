ONE .INT 1

TRP 2
MOV FP SP   # Here we are
ADI SP -8   # making
STR R3 SP   # an
ADI SP -8   # (There is a -8 here because the size of a record for fib is 12)
MOV R0 PC   # activation 
ADI R0 36   # record for
STR R0 FP   # fib(int n)
JMP fib

LDR R3 SP
TRP 1

TRP 0

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

            TRP 99

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
