ARR     .INT 11
        .INT 34
        .INT 43
        .INT -39
        .INT 54
NEWLINE .BYT 10
I .INT 0
SIZE .INT 5
LDA R4 ARR
WHILE   LDR R0 I
        LDR R1 SIZE
        CMP R0 R1
        BRZ R0 ENDWHILE
        LDR R3 R4
        TRP 1
        LDB R3 NEWLINE # Print 
        TRP 3          # blank 
        ADI R4 4
        LDR R0 I
        ADI R0 1
        STR R0 I
        JMP WHILE
ENDWHILE TRP 0      
TRP 0

