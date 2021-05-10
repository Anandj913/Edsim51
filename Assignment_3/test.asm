ORG 0000h             
AJMP MAIN 
              
ORG 0003h              
AJMP ISTREX0

ORG 000Bh             
AJMP CLOCK

ORG 0100h              
MAIN:                   
MOV 36h, #00h              
MOV 37h, #10h               
MOV 38h, #20h            
MOV 39h, #30h              
MOV 46h, #00h              
MOV 47h, #10h               
MOV 48h, #20h               
MOV 49h, #30h              
MOV R0, #36h              
MOV R1, #46h          

MOV R7, #00               ; Set Register 7 to 00 for clock delay
MOV R6, #00               ; Set Register 6 to 00 for stopwatch delay

MOV R5, #00               ; Set external interrupt counter to register 5

MOV TMOD, #11h          
MOV TH0, #0ECh         
MOV TL0, #85h

SETB TR0               
SETB ET0              
SETB EX0              
SETB IT0               
SETB EA               

WAIT:
NOP
SJMP WAIT               

CLOCK:
CLR EA                  
MOV TH0, #0ECh           ; Sets 5000 cycles = 5 milliseconds
MOV TL0, #7Ch           ; FFFF – (5000 – 5)
SETB EA               ; enable interrupt

INC R7               
CJNE R7, #2, DISPLAY0   ; After 200 loops the clock will update (5ms * 200 = 1s)
MOV R7, #00            

INC 39h           
MOV R2, 39h
CJNE R2, #3Ah, DISPLAY0      ; display second update
MOV 39h, #30h             ; reset second value
INC 38h               ; increase ten second value
MOV R2, 38h
CJNE R2, #26h, DISPLAY0       ; display ten second update
MOV 38h, #20h           ; reset ten second value
INC 37h               ; increase minute value
MOV R2, 37h
CJNE R2, #1Ah, DISPLAY0       ; display minute update
MOV 37h, #10h           ; reset minute value
INC 36h               ; increase ten minute value
MOV R2, 36h
CJNE R2, #06h, DISPLAY0       ; display ten minute update
MOV 36h, #00h               ; move number 0 on digit 0 to memory location 36
MOV 37h, #10h               ; move number 0 on digit 1 to memory location 37
MOV 38h, #20h               ; move number 0 on digit 2 to memory location 38
MOV 39h, #30h               ; move number 0 on digit 3 to memory location 39
AJMP DISPLAY0

DISPLAY0:                   ; DISPLAY FOR CLOCK AND CHECK FOR STOPWATCH INTERRUPT
CJNE R5, #00, FREEZE       
MOV P1, @R0
INC R0
CJNE R0, #3Ah, RETURN
MOV R0, #36h
AJMP RETURN

FREEZE:

CJNE R5, #02, DISPLAY1        ; freeze if external interrupt not on step 2

STOPWATCH:

; CLOCK DELAY

INC R6               ; Increase the value of delay counter

CJNE R6, #2, DISPLAY1        ; After 2 loops the clock will update (5 ms * 2 = 10ms)

MOV R6, #00            ; Resets the delay for the next loop

; STOPWATCH UPDATE

INC 49h               ; increase 1/100 second value

MOV R2, 49h

CJNE R2, #3Ah, DISPLAY1

MOV 49h, #30h

INC 48h               ; increase 1/10 second value

MOV R2, 48h

CJNE R2, #2Ah, DISPLAY1

MOV 48h, #20h

INC 47h               ; increase second value

MOV R2, 47h

CJNE R2, #1Ah, DISPLAY1

MOV 47h, #10h

INC 46h               ; increase ten second value

MOV R2, 46h

CJNE R2, #06h, DISPLAY1

; RESET STOPWATCH AFTER 1 MINUTE

MOV 46h, #00h               ; move number 0 on digit 0 to memory location 46

MOV 47h, #10h               ; move number 0 on digit 0 to memory location 47

MOV 48h, #20h               ; move number 0 on digit 0 to memory location 48

MOV 49h, #30h               ; move number 0 on digit 0 to memory location 49

 

AJMP DISPLAY1

DISPLAY1:                   ; DISPLAY STOPWATCH

MOV P1, @R1

INC R1

CJNE R1, #4Ah, RETURN

MOV R1, #46h

AJMP RETURN

RETURN:

RETI                ; return to WAIT

ISTREX0:

; EXTERNAL INTERRUPT COUNTER

INC R5               ; increase interrupt counter

CJNE R5, #04, FINISH

MOV R5, #00               ; resets counter when counter = 4

; RESET STOPWATCH

MOV 46h, #00h               ; move number 0 on digit 0 to memory location 46

MOV 47h, #10h               ; move number 0 on digit 0 to memory location 47

MOV 48h, #20h               ; move number 0 on digit 0 to memory location 48

MOV 49h, #30h               ; move number 0 on digit 0 to memory location 49

FINISH:                   ; RETURN TO CLOCK

RETI

END                   ; end directive