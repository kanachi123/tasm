DSEG SEGMENT
    MSG DB 'HELLO WORLD$'
    LEN DB 11
DSEG ENDS

CSEG SEGMENT
ASSUME CS:CSEG, DS:DSEG
START:
    MOV AX, DSEG
    MOV DS, AX

    MOV BL, LEN     
OUTER_LOOP:
    PUSH BX          
    MOV CX, BX       
    LEA SI, MSG      

INNER_LOOP:
    MOV AL, [SI]
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    INC SI
    LOOP INNER_LOOP  ; CX -= 1

    
    MOV DL, 0Dh
    MOV AH, 02h
    INT 21h
    
    MOV DL, 0Ah
    MOV AH, 02h
    INT 21h

    POP BX
    DEC BL
    JNZ OUTER_LOOP

    MOV BL, 2 
OUTER_LOOP_INC:
    PUSH BX
    MOV CX, BX
    LEA SI, MSG

INNER_LOOP_INC:
    MOV AL, [SI]
    MOV DL, AL
    MOV AH, 02h
    INT 21h
    INC SI
    LOOP INNER_LOOP_INC

    MOV DL, 0Dh
    MOV AH, 02h
    INT 21h
    MOV DL, 0Ah
    MOV AH, 02h
    INT 21h

    POP BX
    INC BL
    CMP BL, LEN
    JBE OUTER_LOOP_INC


    MOV AH, 4Ch
    INT 21h
CSEG ENDS
END START
