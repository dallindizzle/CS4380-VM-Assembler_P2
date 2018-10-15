U .BYT u
M .BYT m
I .BYT i
S .BYT S
s .BYT s
SPACE .BYT 32
NEWLINE .BYT 10
E .BYT e
V .BYT v
N .BYT n
O .BYT o
D .BYT d
TWO .INT 2
SIZE .INT 10
ARR .INT 10
    .INT 2
    .INT 3
    .INT 4
    .INT 15
    .INT -6
    .INT 7
    .INT 8
    .INT 9
    .INT 10
inc .INT 0
sum .INT 0
temp .INT 0
result .INT 0
LDA R5 ARR  # Load R5 with the address of the first element of ARR
WHILE   LDR R0 inc
        LDR R1 SIZE
        CMP R0 R1
        BRZ R0 ENDWHILE
        LDR R0 R5   # Load R0 with the value at the address of R5
        LDR R1 sum
        ADD R1 R0
        MOV R3 R0 
        TRP 1
        LDB R3 SPACE
        TRP 3
        LDB R3 I
        TRP 3
        LDB R3 s
        TRP 3
        LDB R3 SPACE
        TRP 3
        MOV R6 R0   # Move the current value to a register to test if it's even or odd
        LDR R7 TWO
        DIV R6 R7
        MUL R6 R7
        CMP R6 R0   # Check if number is even
        BRZ R6 EVEN
                LDB R3 O
                TRP 3
                LDB R3 D
                TRP 3
                LDB R3 D
                TRP 3
                LDB R3 NEWLINE
                TRP 3
                JMP DONE
        EVEN    LDB R3 E
                TRP 3
                LDB R3 V
                TRP 3
                LDB R3 E
                TRP 3
                LDB R3 N
                TRP 3
                LDB R3 NEWLINE
                TRP 3        
        DONE ADI R5 4    # Increment R5 by 4 to get address of next element
        STR R1 sum
        LDR R0 inc
        ADI R0 1
        STR R0 inc
        JMP WHILE
ENDWHILE    LDB R3 S
TRP 3
LDB R3 U
TRP 3
LDB R3 M
TRP 3
LDB R3 SPACE
TRP 3
LDB R3 I
TRP 3
LDB R3 s
TRP 3
LDB R3 SPACE
TRP 3   
LDR R3 sum
TRP 1 
TRP 0