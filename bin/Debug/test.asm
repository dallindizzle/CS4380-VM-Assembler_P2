DAGS  .BYT D
      .BYT A
      .BYT G
      .BYT S
GADS .INT -99
rel .BYT r
SIZE .INT 4
inc .INT 0
L .BYT <
G .BYT >
E .BYT =
SPACE .BYT 32
NEWLINE .BYT 10
HYPHEN .BYT 45
LDR R0 DAGS
STR R0 GADS     # Store integer value of DAGS at GADS
LDA R0 GADS     # Swap 'D' and 'G' at GADS
LDB R1 GADS
ADI R0 2
LDB R2 R0
STB R1 R0
LDA R0 GADS
STB R2 R0       # End of swap
LDA R0 DAGS
LDA R1 GADS
WHILE2  LDR R2 inc
        LDR R3 SIZE
        CMP R2 R3
        BRZ R2 ENDWHILE2
        LDR R2 inc     
        ADI R2 1
        STR R2 inc      # End to check loop 
        LDB R4 R0       # Load registers with values of addresses of DAGS and GADS
        LDB R5 R1
        CMP R4 R5
        BRZ R4 EQUAL     # Here is where we do all the if else stuff
                BLT R4 LESS
                        LDB R7 G
                        JMP ENDIF
                LESS    LDB R7 L
                        JMP ENDIF
        EQUAL   LDB R7 E
                JMP ENDIF
        ENDIF   LDB R3 R0 
                TRP 3
                LDB R3 SPACE
                TRP 3
                MOV R3 R7
                TRP 3
                LDB R3 SPACE
                TRP 3
                LDB R3 R1
                TRP 3
                LDB R3 HYPHEN
                TRP 3
                TRP 3
                ADI R0 1
                ADI R1 1
                JMP WHILE2
ENDWHILE2       LDB R3 NEWLINE
TRP 3       
LDR R0 DAGS        # Now start subtracting int values of DAGS and GADS
LDR R1 GADS
MOV R3 R0
TRP 1
LDB R3 SPACE
TRP 3
LDB R3 HYPHEN
TRP 3
LDB R3 SPACE
TRP 3
MOV R3 R1
TRP 1
LDB R3 SPACE
TRP 3
LDB R3 E
TRP 3
LDB R3 SPACE
TRP 3
SUB R0 R1
MOV R3 R0
TRP 1
TRP 0