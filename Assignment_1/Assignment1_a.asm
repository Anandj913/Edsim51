ORG 00h
CALL load
CALL sort
JMP finish

load: ;subrutine for loading the data					
MOV R0, #30H ;Initialize R0 with start address of array
MOV @R0, #3  ;Now start putting value in array sequentially
INC R0
MOV @R0, #6
INC R0
MOV @R0, #1
INC R0
MOV @R0, #5
INC R0
MOV @R0, #2
INC R0
MOV @R0, #7
INC R0
MOV @R0, #4
INC R0
MOV @R0, #11
INC R0
MOV @R0, #8
INC R0
MOV @R0, #10
INC R0
MOV @R0, #12
INC R0
MOV @R0, #9
INC R0
MOV @R0, #16
INC R0
MOV @R0, #13
INC R0
MOV @R0, #15
INC R0
MOV @R0, #14
RET

sort:
MOV R1, #0FH ;Counter for outer loop
Outer_loop: ;subrutine for outer loop
MOV R0, #30H ;Initial data pointer to array
MOV A, R1
MOV R2, A ;Initial counter for inner loop
Inner_loop: ;subrutine for inner loop
MOV A, @R0 ;Take the value stored in address pointed by R0 and R0+1 to R3 and A respectively
MOV R3, A
INC R0
MOV A, @R0
SUBB A, R3 ; Subtract R3 value from A
JNC next_inner_loop_iteration ;If carry is not generated move to next innner loop iteration
MOV A, @R0 ;If carry is generated so swap data pointed by R0 and R0+1
XCH A, R3
MOV @R0, A
DEC R0
MOV A, R3
MOV @R0, A
INC R0
next_inner_loop_iteration: 
DJNZ R2, Inner_loop ;Decrement inner loop count and if it is not zero then move to next interation of inner loop
DJNZ R1, Outer_loop ;Decrease outer loop count and if it is not zero then move to next interation outer loop
RET

finish:
JMP $
