ORG 00h
CALL load
CALL prog

load:		 ;subrutine for loading the data					
MOV R0, #30H ;Initialize R0 with start address of array
MOV @R0, #1  ;Now start putting value in array sequentially
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
INC R0
MOV @R0, #1
INC R0
MOV @R0, #0
RET


prog:			;Set LED3,2,1 in off state
SETB P1.3
SETB P1.2
SETB P1.1
loop1:             
MOV R0, #30H    ;Set ACC and truth table pointer
MOV A, #0
start:          
MOV R2, A       
MOV A, @R0      ;Get truth table value
MOV C, ACC.0	;Store in C
MOV A, R2       
CALL display    ;Display the data
CALL delay      ;Wait before next iteration
INC A           ;Increment for next iteration
INC R0
JNB P2.0, interrupt ;Check for SW0
CJNE A, #10H, start ;Check for loop end i.e ACC=16
JMP loop1

interrupt:          
MOV A, #0       ;Turn on all LEDs
MOV P1, A
CALL delay2     ;Wait
CPL A
MOV P1, A       ;Turn off all the LEDs
CALL delay2     ;Wait
JNB P2.0, interrupt ;Check for next step
JMP prog

display:        ;Compliment the data and put in P1
CPL C
MOV P1.0, C
MOV C, ACC.0
CPL C
MOV P1.4, C
MOV C, ACC.1
CPL C
MOV P1.5, C
MOV C, ACC.2
CPL C
MOV P1.6, C
MOV C, ACC.3
CPL C
MOV P1.7, C
RET

delay:           ;Delay to be used in output display
MOV R1, #20
DJNZ R1, $
RET

delay2:          ;Delay to be used in LED blinking
MOV R1, #10
DJNZ R1, $
RET



