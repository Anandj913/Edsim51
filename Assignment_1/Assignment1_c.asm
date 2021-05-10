ORG 00H
CALL load         
CALL Convert_BCD   
JMP finish

load:          ;Load subrutine to load data at location 30
MOV R0, #30H
MOV @R0, #164
RET

Convert_BCD:
MOV R0, #30H  ; Pointer to point at memory location 
MOV A, @R0    ; Copy number to Accumulator
MOV B, #64H	  ; Store 100 in B to divide A by it
DIV AB        ; Divide A by 100 to get the hundredth place digit in A and rest in B
MOV 40h, A	  ; Store the hundredth place digit at location 40h
MOV A, B	  ; Store tenth digit and once digit in A
MOV B, #0Ah	  ; Store 10 in B to divide A by it
DIV AB        ; Divide A by 10 to get tenth place digit in A and rest in B
MOV R1, A     ; Store value of B in R2
MOV A, B
MOV R2, A
MOV A, R1
MOV B, #16    ; Store 16 in B to multiply it by A 
MUL AB        ; Multiply tenth place digit by 16 and store value in A
ADD A, R2     ; Add value of R2 to A
MOV 41h, A    ; Store this value to 41h
RET

finish:
JMP $
