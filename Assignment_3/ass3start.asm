ORG 0        
JMP setup      ;subroutine to set control registers
ORG 0BH
JMP timer0ISR  ;Subroutine to handle timer0 isr
ORG 1BH
JMP timer1ISR  ;Subroutine to handle timer1 isr

setup:
MOV DPL, #LOW(LEDcodes)			 
MOV DPH, #HIGH(LEDcodes)
MOV 30H, #0    ;Initialising clock and stopwatch
MOV 31H, #0
MOV 32H, #0
MOV 33H, #0
MOV 3FH, #0
MOV 40H, #0
MOV 41H, #0
MOV 42H, #0
MOV 43H, #0
MOV 4FH, #0
MOV TMOD, #11h ;seting timer0 and timer1 to 16-bit mode
MOV TH0, #11   ;Initialising timers
MOV TL0, #220
MOV TH1, #11
MOV TL1, #220
SETB TR0       ;Start timer0
SETB ET0       ;Enable timer0 interrupt
SETB EA
MOV R2, #1     ;Set run flag to 1
JMP display1   ;Display clock

display1:
JNB P2.0, modeitr ;Check for mode
MOV R1, #30h      ;Display value at 30-33h on SSD
MOV A, @R1
MOVC A, @A+DPTR
SETB P3.3
SETB P3.4
MOV P1, A
CALL delay
INC R1
MOV A, @R1
MOVC A, @A+DPTR
CLR P3.3
MOV P1, A
CALL delay
INC R1
MOV A, @R1
MOVC A, @A+DPTR
CLR P3.4
SETB P3.3
MOV P1, A
CALL delay
INC R1
MOV A, @R1
MOVC A, @A+DPTR
CLR P3.3
MOV P1, A
CALL delay
JMP display1

modeitr:
JNB P2.0, display2 ;Check for mode
CLR TR1					  ;Reset stopwatch and run flag
CLR ET1
MOV 40H, #0
MOV 41H, #0
MOV 42H, #0
MOV 43H, #0
MOV 4FH, #0
MOV R2, #1
JMP display1

display2:           
JNB P2.0, next0    ;Check for mode
JMP modeitr
next0:
JNB P2.1, startitr ;Check for start switch
next:
JNB P2.2, stopitr  ;Check for stop switch
next2:
MOV R1, #40h       ;Display value at 40-43h on SSD
MOV A, @R1
MOVC A, @A+DPTR
SETB P3.3
SETB P3.4
MOV P1, A
CALL delay
INC R1
MOV A, @R1
MOVC A, @A+DPTR
CLR P3.3
MOV P1, A
CALL delay
INC R1
MOV A, @R1
MOVC A, @A+DPTR
CLR P3.4
SETB P3.3
MOV P1, A
CALL delay
INC R1
MOV A, @R1
MOVC A, @A+DPTR
CLR P3.3
MOV P1, A
CALL delay
JMP display2

startitr:
CJNE R2, #1, next  ;Check is stopwatch is already running
MOV 40H, #0			  ;Reset stopwatch
MOV 41H, #0
MOV 42H, #0
MOV 43H, #0
MOV 4FH, #0
MOV TH1, #11
MOV TL1, #220
SETB ET1           ;Enable interrupt
SETB TR1           ;Start timer 0
MOV R2, #0         ;Reset run flag
JMP next

stopitr:           
CLR TR1            ;Stop timer1
CLR ET1            ;Disable Interrupt
MOV R2, #1         ;Set run flag
JMP next2

timer0ISR:
MOV TH0, #11      ;Timer0 interrupt to increment 
MOV TL0, #220		 ;clock every 1 sec
MOV R0, #3FH
MOV A, @R0
INC A
CJNE A, #1, skip
MOV @R0, #0
MOV R0, #33H
MOV A, @R0
INC A
CJNE A, #10, skip
MOV @R0, #0
DEC R0
MOV A, @R0
INC A
CJNE A, #6, skip
MOV @R0, #0
DEC R0
MOV A, @R0
INC A
CJNE A, #10, skip
MOV @R0, #0
DEC R0
MOV A, @R0
INC A
CJNE A, #6, skip
MOV @R0, #0
RETI

timer1ISR:        ;Timer0 interrupt to increment
MOV TH1, #11      ;stopwatch every 1 sec
MOV TL1, #220
MOV R0, #4FH
MOV A, @R0
INC A
CJNE A, #1, skip
MOV @R0, #0
MOV R0, #43H
MOV A, @R0
INC A
CJNE A, #10, skip
MOV @R0, #0
DEC R0
MOV A, @R0
INC A
CJNE A, #6, skip
MOV @R0, #0
DEC R0
MOV A, @R0
INC A
CJNE A, #10, skip
MOV @R0, #0
DEC R0
MOV A, @R0
INC A
CJNE A, #6, skip
MOV @R0, #0
RETI

skip:          
MOV @R0, A
RETI

LEDcodes:       ;Mapping of digit to its S.S.D pattern
	DB 11000000B, 11111001B, 10100100B, 10110000B, 10011001B, 10010010B, 10000010B, 11111000B, 10000000B, 10010000B

delay:          ;Delay Function
MOV R4, #255
DJNZ R4, $
RET






