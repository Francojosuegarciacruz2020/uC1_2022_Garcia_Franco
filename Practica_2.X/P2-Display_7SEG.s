;Autor: Franco Josue Garcia Cruz
;Tarjeta: Curiosity Nano PIC18f57q84
;Programa: MPLAB X IDE
;Lenguaje: AMS - C
;Fecha: 14/01/2023
;Version de emsamblador: Pic-as (V 2.40)
;Este codigo se encarga de desarrollar un programa que me permita mostrar los valores del 0 al 9 cuando el boton de la placa no es presionado y si se tiene presionado se muestran los valores de A hasta F con un display Anodo comun conectados al puerto D.
;Frecuencia del oscilador: 4Mhz     
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
PROCESSOR 18F57Q84
#include "Bit_Config.inc"   /* config statements should precede project file includes.*/
#include "Retardos.inc"
#include <xc.inc>  
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
Main: 
   CALL	    Config_Osc,1
   CALL	    Config_Port,1
    
   BANKSEL  PORTA
   BTFSS    PORTA,3,0		    ; Salta si es 1    
   GOTO	    Conteo_Letras
   
Conteo_Numeros:
    MOVLW   01000000B		    ; Numero "0" en Binario
    MOVWF   LATD,1		    ; (w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Salta si es 1
    GOTO    Conteo_Letras
    
    MOVLW   01111001B		    ; Numero "1" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Salta si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00100100B		    ; Numero "2" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Salta si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00110000B		    ; Numero "3" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00011001B		    ; Numero "4" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00010010B		    ; Numero "5" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00000010B		    ; Numero "6" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00111000B		    ; Numero "7" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00000000B		    ; Numero "8" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    MOVLW   00011000B		    ; Numero "9" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSS   PORTA,3,0		    ; Saltar si es 1 
    GOTO    Conteo_Letras
    
    GOTO    Conteo_Numeros
    
Conteo_Letras:    
    MOVLW   00001000B		    ; Letra "A" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSC   PORTA,3,0		    ; Saltar si es 0
    GOTO    Conteo_Numeros
    
    MOVLW   000000011B		    ; Letra "B" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSC   PORTA,3,0		    ; Saltar si es 0
    GOTO    Conteo_Numeros
    
    MOVLW   01000110B		    ; Letra "C" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSC   PORTA,3,0		    ; Saltar si es 0
    GOTO    Conteo_Numeros
    
    MOVLW   0100001B		    ; Letra "D" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSC   PORTA,3,0		    ; Saltar si es 0
    GOTO    Conteo_Numeros
    
    MOVLW   00000110B		    ; Letra "E" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSC   PORTA,3,0		    ; Saltar si es 0
    GOTO    Conteo_Numeros
    
    MOVLW   00001110B		    ; Letra "F" en Binario
    MOVWF   LATD,1		    ;(w) --> F
    CALL    Delay_1000ms,1	    ; Ejecuta el conteo de 1000ms
    BTFSC   PORTA,3,0		    ; Salta si es 0
    GOTO    Conteo_Numeros
    
    GOTO    Conteo_Letras	    ; Repite el conteo de Letras
    
    
Config_Osc:
    ;Configuracion de un oscilador interno a una frecuencia de 4 MHz
    BANKSEL OSCCON1	
    MOVLW   0X60	;seleccionamos el bloque del osc interno con un div:1
    MOVWF   OSCCON1,1	
    MOVLW   0X02	;seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ,1	
    RETURN   

Config_Port:	    
    BANKSEL	TRISD
    CLRF	TRISD,0	    ; Port "D" --> Salida (0:7)
    
    ;Config Button
    BANKSEL	PORTA
    CLRF	PORTA,1	    ; PORTA = 0, leer
    CLRF	ANSELA,1    ; ANSEL digital
    BSF		TRISA,3,1   ; RA3 como entrada 
    BSF		WPUA,3,1    ; Activamos la resistencia Pull-up del pin RA3
    RETURN  
   
END resetVect