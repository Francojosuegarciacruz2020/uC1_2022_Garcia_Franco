;Autor: Franco Josue Garcia Cruz
;Tarjeta: Curiosity Nano PIC18f57q84
;Programa: MPLAB X IDE
;Lenguaje: AMS - C
;Fecha: 14/01/2023
;Version de emsamblador: Pic-as (V 2.40)
;Este codigo se encarga de hacer un corrimiento de leds conectados al puerto C, los leds pares con un retardo de 500ms e impares con 250ms, donde el corrimiento inicia al pulsar el boton y si se presiona otra vez este corrimiento se detiene. Tambien el pin RE0 se enciende cuando son pares y RE1 impares. 
;Frecuencia del oscilador: 4Mhz     
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
PROCESSOR 18F57Q84
#include "Bit_Config1.inc"  // config statements should precede project file includes.
#include "Retardos1.inc"
#include <xc.inc>  

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
 
Main:
     CALL Config_OSC,1
     CALL Config_Port,1

Button:
    BANKSEL   LATA
    CLRF      LATC,b	    ; LATC = 0
    BCF       LATE,1,b	    ; LATE1 = 1
    BCF       LATE,0,b	    ; LATE0 = 0
    BTFSC     PORTA,3,b	    ; Salta si es 0
    goto      Button
    goto      Led_Par
     
Led_Par:
    CLRF  LATC,b	    ; Escribir en el puerto C = 0
    BCF   LATE,0,b	    ; E = 0 (1 Bit), Cuando sea 0 se apaga
    BSF   LATE,1,b	    ; E = 1, Cuando sea 1 se enciende 
    MOVLW 00000010B	    
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee 
    GOTO  Button_Pausa1
    
    BSF   LATE,1,b	    ; E = 1, Cuando sea 1 se enciende 
    BCF   LATE,0,b	    ; E = 0 (1 Bit), Cuando sea 0 se apaga
    MOVLW 00001000B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee
    GOTO  Button_Pausa1
    
    BSF   LATE,1,b	    ; E = 1, Cuando sea 1 se enciende 
    BCF   LATE,0,b	    ; E = 0 (1 Bit), Cuando sea 0 se apaga
    MOVLW 00100000B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee
    GOTO  Button_Pausa1
   
    BSF   LATE,1,b	    ; E = 1, Cuando sea 1 se enciende 
    BCF   LATE,0,b	    ; E = 0 (1 Bit), Cuando sea 0 se apaga
    MOVLW 10000000B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_500ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee
    GOTO  Button_Pausa1
    
Led_Impar:
    CLRF  LATC,b	    ; Escribir en el puerto C = 0
    BCF   LATE,1,b	    ; E = 1 (1 Bit), Cuando sea 1 se enciende
    BSF   LATE,0,b	    ; E = 0, Cuando sea 0 se apaga 
    MOVLW 00000001B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee ,s1
    GOTO  Button_Pausa2
    
    BCF   LATE,1,b	    ; E = 1 (1 Bit), Cuando sea 1 se enciende
    BSF   LATE,0,b	    ; E = 0, Cuando sea 0 se apaga 
    MOVLW 00000100B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee
    GOTO  Button_Pausa2
    
    BCF   LATE,1,b	    ; E = 1 (1 Bit), Cuando sea 1 se enciende
    BSF   LATE,0,b	    ; E = 0, Cuando sea 0 se apaga 
    MOVLW 00010000B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee
    GOTO  Button_Pausa2
    
    BCF   LATE,1,b	    ; E = 1 (1 Bit), Cuando sea 1 se enciende
    BSF   LATE,0,b	    ; E = 0, Cuando sea 0 se apaga
    MOVLW 01000000B
    MOVWF LATC,1	    ; (W) --> F
    CALL  Delay_250ms,1
    BTFSS PORTA,3,0	    ; PORTA: Lee
    GOTO  Button_Pausa2
    GOTO  Led_Par
    
Button_Pausa1:    ;Los Led pares
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0		; S0
    GOTO    Button_Pausa1
    GOTO    Led_Par
    
Button_Pausa2:    ;Leds Impares
    CALL    Delay_250ms,1
    BTFSC   PORTA,3,0		
    GOTO    Button_Pausa1
    GOTO    Led_Impar
    
Config_OSC:
        ;Configuracion del Oscilador interno a una frecuencia interna de 4Mhz 
         BANKSEL OSCCON1
	 MOVLW 0X60     ;Seleccionamos el bloque del osc con un Div:1
	 MOVWF OSCCON1,1
	 MOVLW 0X02     ;Seleccionamos una Frecuencia de 4Mhz
	 MOVWF OSCFRQ ,1
         RETURN

Config_Port:   ;PORT-LAT-ANSEL-TRIS  LED:RF3,  BUTTON:RA3
    BANKSEL  PORTF
    CLRF     TRISC,b	    ; TRISC = 0 Como salida
    CLRF     ANSELC,b	    ; ANSELC<7:0> = 0 - Port C digital
    BCF      TRISE,1,b	    ; TRISE<1> = 0  RE1 como SALIDA
    BCF      TRISE,0,b	    ; TRISE<0> = 0  RF0 como SALIDA
    BCF      ANSELE,1,b	    ; TRISE<1> = 1  RE1 como Digital
    BCF      ANSELE,0,b	    ; TRISE<0> = 0  RE0 como Digital
    
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,b	    ; PortA<7:0> = 0 
    CLRF    ANSELA,b	    ; PortA Digital
    BSF     TRISA,3,b	    ; RA3 como entrada
    BSF     WPUA,3,b	    ; Activamos la resistencia Pull-up del pin RA3
    RETURN   
    
END resetVect