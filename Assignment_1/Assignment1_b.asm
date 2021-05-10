ORG 00H
CALL load
CALL palindrome_check
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
MOV @R0, #12
INC R0
MOV @R0, #10
INC R0
MOV @R0, #4
INC R0
MOV @R0, #7
INC R0
MOV @R0, #2
INC R0
MOV @R0, #5
INC R0
MOV @R0, #1
INC R0
MOV @R0, #6
INC R0
MOV @R0, #3
RET

palindrome_check: ;Subrutine for palindrome check
MOV R0, #30H      ;Front pointer to the array
MOV R1, #3FH	  ;End pointer to the array
MOV R2, #8		  ;Loop counter
loop:
MOV A, @R0        ;Take the data pointed by front pointer
MOV P1, A		  ;Store it in P1
MOV A, @R1		  ;Take the data pointed by end pointer
CJNE A, P1, not_palindrome ;Compare both data if they are same then move to next iteration 
						   ;else seq is not a palindrome so we jump to not_palindrome part
INC R0            ;Since data are equal so increment front pointer and decrement end pointer
DEC R1
DJNZ R2, loop     ;Check for end of loop 
CALL palindrome	  ;If loop is finished then seq is a palindrome so call it	
RET

not_palindrome:   ;Subrutine to do the task if seq is not a palindrome
MOV R0, #40H      ;Store 0F at location 40H as given in Q
MOV @R0, #0FH
JMP finish

palindrome:       ;Subrutine to do the task if seq is a palindrome
MOV R0, #40H      ;Store 01 at location 40H as given in Q
MOV @R0, #01H
RET 

finish:
JMP $
