ORG 0000H
CLR P0.7          ;Enable DAC output
UP : 
MOV DPTR, #saw_tooth   ;Initialize DPTR to datatable pointer
MOV R0,#24        ;Initialize counter
LABEL: 
MOVC A,@A+DPTR    ;Take value from table
MOV P1, A         ;Put in P1 for display in DAC
INC DPTR          ;Increase DPTR to display next value
DJNZ R0,LABEL     ;Check for end of table 
SJMP UP


;SINE :            ;Sampled Value for Sinusoidal waveform
;DB 127,159,190,216,236,249,254,249,236,216,190,159,127,94,63,37,17,4,0,4,17,37,63,94
;END

;tangential :      ;Sampled value for Tangential waveform
;DB 127,129,131,133,136,139,143,148,154,166,187,248,255,0,67,88,99,106,111,114,118,120,123,125
;END

;trapezoidal :     ;Sampled value for trapezoidal waveform
;DB 0,32,64,96,127,160,191,223,255,255,255,255,255,255,255,255,255,223,191,160,127,96,64,32
;END


saw_tooth :        ;Sampled value for saw_tooth waveform
DB 0,11,22,33,44,55,66,77,88,99,110,132,143,154,165,176,187,198,209,220,231,242,253
END
