CLR SM0			
SETB SM1	

MOV A, PCON		
SETB ACC.7	
MOV PCON, A		

MOV TMOD, #20H	
MOV TH1, #243	
MOV TL1, #243
SETB TR1	

MOV 30H, #'A'		
MOV 31H, #'n'	
MOV 32H, #'a'	
MOV 33H, #'n'
MOV 34H, #'d'
MOV 35H, #0	
MOV R0, #30H	

again:	
MOV A, @R0	
JZ finish	
MOV C, P	
MOV ACC.7, C		
MOV SBUF, A	
INC R0		
JNB TI, $		
CLR TI			
JMP again	
	
finish:
JMP $			
