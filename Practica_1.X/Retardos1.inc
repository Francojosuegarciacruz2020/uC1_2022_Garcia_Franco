    PSECT udata_acs
Contador1: DS 1		;reserva 1 Byte en access ram
Contador2: DS 1		;reserva 1 Byte en access ram
Contador3: DS 1		;reserva 1 Byte en access ram     
PSECT code
; T = (6 + 4k)us	
Delay_10us:			 ; 2 Tcy --> Call
    MOVLW	1		 ; 1 Tcy
    MOVWF	Contador1,0	 ; 1 Tcy 
Delay_Loop10:
    NOP				 ; k*Tcy
    DECFSZ	Contador1,1,0    ; (k-1) + 3Tcy
    GOTO	Delay_Loop10	 ; (k-1)*2Tcy
    RETURN			 ; 2 Tcy
    
    
; T = (7 + 3k)us	
Delay_25us:			 ; 2 Tcy --> Call
    MOVLW	6		 ; 1 Tcy
    MOVWF	Contador2,0	 ; 1 Tcy 
    NOP				 ; 1 Tcy
Delay_Loop25:
    DECFSZ	Contador2,1,0	 ; (k-1) + 3Tcy
    GOTO	Delay_Loop25	 ; (k-1)*2Tcy
    RETURN			 ; 2 Tcy
    
    
;T = (6 + 4k)us
Delay_50us:			 ; 2 Tcy --> Call
    MOVLW	11	         ; 1 Tcy
    MOVWF	Contador1,0      ; 1 Tcy
Delay_Loop50:
    NOP                          ; k*Tcy
    DECFSZ	Contador1,1,0    ; (k-1)+3Tcy
    GOTO	Delay_Loop50	 ; (k-1)
    RETURN		         ; 2 Tcy
  
    
;T = (7 + 3k)us   
Delay_100us:			 ; 2 tcy --> Call  
    NOP				 ; 1 Tcy
    MOVLW	31	         ; 1 Tcy
    MOVWF	Contador1,0      ; 1 Tcy
Delay_Loop100:
    DECFSZ	Contador1,1,0    ; (k-1)+ 3Tcy
    GOTO	Delay_Loop100    ; (k-1)*Tcy
    RETURN		         ; 2 Tcy
 
    
;T = (8 + 4k)us
Delay_200us:			 ; 2 tcy --> Call
    NOP				 ; 1 Tcy
    NOP				 ; 1 Tcy
    MOVLW	48		 ; 1 Tcy
    MOVWF	Contador1,0	 ; 1 Tcy
Delay_Loop200:
    NOP			         ; k*Tcy
    DECFSZ	Contador1,1,0    ; (k-1)+ 3Tcy
    GOTO	Delay_Loop200    ; (k-1)*Tcy
    RETURN			 ; 2 Tcy
    
    
;T = (6 + 4k)us
Delay_250us:			 ; 2 tcy --> Call  
    MOVLW	61	         ; 1 Tcy
    MOVWF	Contador2,0      ; 1 Tcy
Delay_Loop250:
    NOP                          ; k*Tcy
    DECFSZ	Contador2,1,0    ; (k-1)+ 3Tcy
    GOTO	Delay_Loop250    ; (k-1)*Tcy
    RETURN  		         ; 2 Tcy

    
;T = (8 + 4k)us
Delay_500us:		         ; 2 tcy --> Call    
    MOVLW	123	         ; 1 Tcy
    MOVWF	Contador2,0      ; 1 Tcy
    NOP                          ; 1 Tcy
    NOP                          ; 1 Tcy    
Delay_Loop500: 
    NOP                          ; k*Tcy
    DECFSZ	Contador2,1,0    ; (k-1)+ 3Tcy
    GOTO	Delay_Loop500    ; (k-1)*Tcy
    RETURN		         ; 2 Tcy
    
  		 
Delay_1ms:		         ; 2 Tcy --> Call
    MOVLW	1		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms		 ; 1Tcy = 1us
Ext_Loop1ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop1ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop1ms	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0    
    GOTO        Ext_Loop1ms      
    RETURN		         ; 2 Tcy
    
		 
Delay_5ms:		         ; 2 Tcy --> Call
    MOVLW	5		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop5ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop5ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop5ms	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0    
    GOTO        Ext_Loop5ms      
    RETURN		         ; 2 Tcy
    
    	 
Delay_10ms:		         ; 2 Tcy --> Call
    MOVLW	10		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop10ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop10ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop10ms	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0    
    GOTO        Ext_Loop10ms     
    RETURN		         ; 2 Tcy

 	 
Delay_25ms:		         ; 2 Tcy --> Call
    MOVLW	25		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop25ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop25ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop25ms	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0    
    GOTO        Ext_Loop25ms     
    RETURN		         ; 2 Tcy
    
    		 
Delay_50ms:		         ; 2 Tcy --> Call
    MOVLW	50		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop50ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop50ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop50ms	 
    DECFSZ      Contador2,1,0  
    GOTO        Ext_Loop50ms     
    RETURN		         ; 2 Tcy
    
		 
Delay_100ms:		         ; 2 Tcy --> Call
    MOVLW	100		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop100ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop100ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop100ms	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0    
    GOTO        Ext_Loop100ms    
    RETURN		         ; 2 Tcy
    
		 
Delay_200ms:		         ; 2 Tcy --> Call
    MOVLW	200		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop200ms:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop200ms:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop200ms	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0  
    GOTO        Ext_Loop200ms    
    RETURN		         ; 2 Tcy
    
	 
Delay_250ms_:		         ; 2 Tcy --> Call
    MOVLW	250		 ; 1 Tcy --> k2
    MOVWF	Contador2,0	 ; 1 Tcy
; T = (6 + 4k)ms
Ext_Loop250:		    
    MOVLW	249		 ; 1 TCY
    MOVWF	Contador1,0	 ; 1 Tcy
Int_Loop250:
    NOP			         ; k1*Tcy
    DECFSZ	Contador1,1,0    ; (k1-1)+ 3Tcy
    GOTO	Int_Loop250	 ; (k1-1)*2Tcy
    DECFSZ      Contador2,1,0    
    GOTO        Ext_Loop250       
    RETURN		         ; 2 Tcy
 
;____________________________________________
    
;T= (6 + 4k1)(k2)(k3)		    --> Corrimientos pares           
Delay_500ms:
    MOVLW   2			    ;1Tcy--k3
    MOVWF   Contador3,0		    ;1Tcy
D_500ms:			    ;2Tcy--call
    MOVLW   250			    ;1Tcy--k2
    MOVWF   Contador2,0		    ;1Tcy
    
Ext500ms_Loop:                  
    MOVLW   249			    ;1Tcy--k1
    MOVWF   Contador1,0		    ;1Tcy
Int500ms_Loop:
    NOP				    ;K1*Tcy
    DECFSZ  Contador1,1,0	    ;(k1-1)+ 3Tcy           
    GOTO    Int500ms_Loop	    ;2Tcy
    DECFSZ  Contador2,1,0	    ;2Tcy
    GOTO    Ext500ms_Loop	    ;2Tcy 
    DECFSZ  Contador3,1,0
    GOTO    D_500ms
    RETURN			    ;2Tcy   

;T= (6 + 4k1)k2		    --> Corrimientos impares
Delay_250ms:			    ;2Tcy --> call
    MOVLW   250			    ;1Tcy --> k2
    MOVWF   Contador2,0		    ;1Tcy
    
Ext250ms_Loop:                  
    MOVLW   249			    ;1Tcy --> k1
    MOVWF   Contador1,0		    ;1Tcy
Int250ms_Loop:
    NOP				    ;K1*Tcy
    DECFSZ  Contador1,1,0	    ;(k1-1)+ 3Tcy           
    GOTO    Int250ms_Loop	    ;2Tcy
    DECFSZ  Contador2,1,0	    ;2Tcy
    GOTO    Ext250ms_Loop	    ;2Tcy   
    RETURN			    ;2Tcy     