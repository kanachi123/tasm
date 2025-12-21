; ===== MACROS =====
PIXEL MACRO
    MOV AH, 0Ch
    MOV BH, 0
    INT 10h
ENDM


; ===== STACK SEGMENT =====
SSEG SEGMENT STACK
    DW 128 DUP(?)
SSEG ENDS


; ===== CODE SEGMENT =====
CSEG SEGMENT
    ASSUME CS:CSEG, SS:SSEG


; ===== DRAW ONE SQUARE =====
DRAW_SQUARE PROC NEAR
    PUSH CX
    PUSH DX
    PUSH SI

    MOV SI, DI        ; верхняя сторона
L1:
    PIXEL
    INC CX
    DEC SI
    JNZ L1

    MOV SI, DI        ; правая сторона
L2:
    PIXEL
    INC DX
    DEC SI
    JNZ L2

    MOV SI, DI        ; нижняя сторона
L3:
    PIXEL
    DEC CX
    DEC SI
    JNZ L3

    MOV SI, DI        ; левая сторона
L4:
    PIXEL
    DEC DX
    DEC SI
    JNZ L4

    POP SI
    POP DX
    POP CX
    RET
DRAW_SQUARE ENDP


; ===== DRAW MULTIPLE SQUARES =====
MULTI PROC NEAR
    MOV DI, 50        ; размер квадрата
    MOV AL, 14        ; цвет (жёлтый)

    MOV CX, 100
    MOV DX, 100

    MOV SI, 2         ; первые квадраты
FIRST:
    CALL DRAW_SQUARE
    ADD CX, 25
    ADD DX, 25
    DEC SI
    JNZ FIRST

    MOV SI, 3         ; следующие квадраты
NEXT:
    CALL DRAW_SQUARE
    ADD CX, 25
    SUB DX, 25
    DEC SI
    JNZ NEXT

    RET
MULTI ENDP


; ===== PROGRAM START =====
START:
    MOV AX, 0012h     ; видеорежим 640x480x16
    INT 10h

    CALL MULTI

    MOV AH, 00h       ; ожидание клавиши
    INT 16h

    MOV AX, 0003h     ; текстовый режим
    INT 10h

    MOV AH, 4Ch
    INT 21h

CSEG ENDS
END START
