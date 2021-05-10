CLR P0.7	; enable the DAC WR line
loop:
	MOV P1, A	; move data in the accumulator to the ADC inputs (on P1)
	ADD A, #4	; increase accumulator by 4
	JMP loop	; jump back to loop
	