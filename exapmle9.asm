CLR SM0			; |
	SETB SM1		; | put serial port in 8-bit UART mode

	SETB REN		; enable serial port receiver

	MOV A, PCON		; |
	SETB ACC.7		; |
	MOV PCON, A		; | set SMOD in PCON to double baud rate

	MOV TMOD, #20H		; put timer 1 in 8-bit auto-reload interval timing mode
	MOV TH1, #0FDH		; put -3 in timer 1 high byte (timer will overflow every 3 us)
	MOV TL1, #0FDH		; put same value in low byte so when timer is first started it will overflow after approx. 3 us
	SETB TR1		; start timer 1
	MOV R1, #30H		; put data start address in R1
again:
	JNB RI, $		; wait for byte to be received
	CLR RI			; clear the RI flag
	MOV A, SBUF		; move received byte to A
	CJNE A, #0DH, skip	; compare it with 0DH - it it's not, skip next instruction
	JMP finish		; if it is the terminating character, jump to the end of the program
skip:
	MOV @R1, A		; move from A to location pointed to by R1
	INC R1			; increment R1 to point at next location where data will be stored
	JMP again		; jump back to waiting for next byte
finish:
	JMP $			; do nothing