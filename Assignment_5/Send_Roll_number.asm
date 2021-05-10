CLR SM0			
SETB SM1    ;Set serial port in 8-bit UART	mode
SETB REN    ;enable serial port receiver

MOV A, PCON		
SETB ACC.7			
MOV PCON, A	;set SMOD in PCON to double baud rate

MOV TMOD, #20H	;Set timer1 in 8-bit auto reload mode
MOV TH1, #-3	
MOV TL1, #-3    ;Put -3 in timer registers	
SETB TR1		;Start timer
MOV R1, #30H    ;Set R1 

again:
JNB RI, $		;wait for byte to be received
CLR RI			
MOV A, SBUF			;move received byte to A
CJNE A, #0DH, skip	;compare it with 0DH - it it's not, skip next instruction
JMP finish		
	
skip:
MOV @R1, A		;move from A to location pointed to by R1
INC R1		
JMP again	
		
finish:
jmp $			
