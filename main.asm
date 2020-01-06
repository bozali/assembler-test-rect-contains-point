SECTION .data

POSITION_X_MSG:         DB "Enter position x: ", 0
POSITION_Y_MSG:         DB "Enter position y: ", 0
WIDTH_MSG:              DB "Enter width: ", 0
HEIGHT_MSG:             DB "Enter height: ", 0

POINT_POSITION_X_MSG:   DB "Enter point position x: ", 0
POINT_POSITION_Y_MSG:   DB "Enter point position y: ", 0

FALSE_MSG:       DB "False", 0
TRUE_MSG:          DB "True", 0

FORMATIN:               DB "%d", 0

POSITION_X:             DD 0
POSITION_Y:             DD 0
WIDTH:                  DD 0
HEIGHT:                 DD 0

POINT_X:                DD 10
POINT_Y:                DD 10


SECTION .text

global _main

; Extern
extern _scanf
extern _printf


_contains_point:
        PUSH    EAX
        PUSH    EBX

        ; Check point.x < rect.x
        MOV     EAX, DWORD [POSITION_X]
        MOV     EBX, DWORD [POINT_X]

        CMP     EBX, EBX
        JL      not_in

        ; Check point.y < rect.y
        MOV     EAX, DWORD [POSITION_Y]
        MOV     EBX, DWORD [POINT_Y]

        CMP     EBX, EAX
        JL      not_in

        ; Check point.x > rect.x + rect.width
        MOV     EAX, DWORD [POSITION_X]
        ADD     EAX, DWORD [WIDTH]
        MOV     EBX, DWORD [POINT_X]

        CMP     EBX, EAX
        JG      not_in

        ; Check point.y > rect.y + rect.height
        MOV     EAX, DWORD [POSITION_Y]
        ADD     EAX, DWORD [HEIGHT]
        MOV     EBX, DWORD [POINT_Y]

        CMP     EBX, EAX
        JG      no_cont

        ; Message and jump to done
        PUSH    TRUE_MSG
        CALL    _printf
        ADD     ESP, 4
        JMP     done
        
        not_in:
        PUSH    FALSE_MSG
        CALL    _printf
        ADD     ESP, 4
        JMP     done

        done:
        POP     EBX
        POP     EAX
        RET
        

_main:
        PUSH    EBX
        PUSH    ECX

        ; RECTANGLE POSITION X
        PUSH    POSITION_X_MSG
        CALL    _printf
        ADD     ESP, 4

        PUSH    POSITION_X
        PUSH    FORMATIN
        CALL    _scanf
        ADD     ESP, 8

        ; RECTANGLE POSITION Y
        PUSH    POSITION_Y_MSG
        CALL    _printf
        ADD     ESP, 4

        PUSH    POSITION_Y
        PUSH    FORMATIN
        CALL    _scanf
        ADD     ESP, 8

        ; RECTANGLE WIDTH
        PUSH    WIDTH_MSG
        CALL    _printf
        ADD     ESP, 4

        PUSH    WIDTH
        PUSH    FORMATIN
        CALL    _scanf
        ADD     ESP, 8

        ; RECTANGLE HEIGHT
        PUSH    HEIGHT_MSG
        CALL    _printf
        ADD     ESP, 4

        PUSH    HEIGHT
        PUSH    FORMATIN
        CALL    _scanf
        ADD     ESP, 8

        PUSH    POSITION_X
        PUSH    POSITION_Y
        PUSH    WIDTH
        PUSH    HEIGHT
        PUSH    POINT_X
        PUSH    POINT_Y
        CALL    _contains_point
        ADD     ESP, 24

        POP     ECX
        POP     EBX
        MOV     EAX, 0
        RET
