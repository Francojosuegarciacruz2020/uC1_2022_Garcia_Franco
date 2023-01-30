;1.Autor: Franco Josue Garcia Cruz
;2.Tarjeta: Curiosity Nano PIC18F57Q84
;3.Programa: MPLAB X IDE
;4.Lenguaje: AMS - C
;5.Fecha: 29/01/2023
;6.Version de emsamblador: Pic-as (V 2.40)
;7.Frecuencia del oscilador: 4Mhz 
;8.Este codigo se encarga de iniciar el encendido de leds en el Puerto C. La secuencia se detiene 
;cuando se presione otro pulsador externo conectado en el pin RB4 o hasta que el número de
;repeticiones sea 5. El retardo entre el encendido y apagado de los leds será de 250 ms.
;Otro pulsador externo conectado al RF2 reinicia toda la secuencia y apaga los leds.
;Mientras no se active ninguna interrupción, se realiza un toggle del led de la placa cada 500 ms.     
; -----------------------------------------------------------------------------------------------------------   
PROCESSOR 18F57Q84
#include "Bit_Config.inc"   /*config statements should precede project file includes.*/
#include <xc.inc>
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT ISRVectLowPriority,class=CODE,reloc=2
ISRVectLowPriority:
    BTFSS   PIR1,0,0	; ¿Se ha producido la INT0?
    GOTO    Exit0
Leds_on:
    BCF	    PIR1,0,0	; limpiamos el flag de INT0
    GOTO    Reload_1
Exit0:
    RETFIE

PSECT ISRVectHighPriority,class=CODE,reloc=2
ISRVectHighPriority:
    BTFSS   PIR10,0,0	; ¿Se ha producido la INT2?
    GOTO    Exit
Leds:
    BCF	    PIR10,0,0	; limpiamos el flag de INT2 y éste seria INT1
    GOTO    exit
Exit:
    RETFIE

PSECT udata_acs
Contador_1:  DS 1	;reserva 1 Byte en access ram	    
Contador_2:  DS 1	;reserva 1 Byte en access ram
Contador_3:  DS 1	;reserva 1 Byte en access ram
Offset:	     DS 1	;reserva 1 Byte en access ram
Offset_1:    DS 1	;reserva 1 Byte en access ram
Counter:     DS 1	;reserva 1 Byte en access ram
Counter_1:   DS 1	;reserva 1 Byte en access ram
    
PSECT CODE    
Main:
    CALL    Config_OSC,1
    CALL    Config_Port,1
    CALL    Config_PPS,1
    CALL    Config_INT0_INT1_INT2,1
    GOTO    Toggle_Led
       
Toggle_Led:
   BTG	   LATF,3,0	    ; Toggle Led
   CALL    Delay_500ms,1
   BTG	   LATF,3,0	    ; Toggle Led
   CALL    Delay_500ms,1
   GOTO	   Toggle_Led

Loop:
    BSF	    LATF,3,0				
    BANKSEL PCLATU
    MOVLW   low highword(Tabla_Corrimientos)
    MOVWF   PCLATU,1				; (W) --> F
    MOVLW   high(Tabla_Corrimientos)
    MOVWF   PCLATH,1				; (W) --> F
    RLNCF   Offset,0,0
    CALL    Tabla_Corrimientos
    MOVWF   LATC,0				; (W) --> F
    CALL    Delay_250ms,1
    DECFSZ  Counter,1,0				; Decrementa el Counter
    GOTO    Next_Seq
    
Verifica:
    DECFSZ  Counter_1,1,0			; Decrementa el Counter_1
    GOTO    Reload_2
    Goto    Led_OFF
    
Next_Seq:
    INCF    Offset,1,0				; Incrementa el Offset
    GOTO    Loop
    
Reload_1:
    MOVLW   0x05	
    MOVWF   Counter_1,0	; Carga del contador con el numero de offsets
    MOVLW   0x00	
    MOVWF   Offset,0	; Definir el valor del Offset inicial
    
Reload_2:
    MOVLW   0x0A	
    MOVWF   Counter,0	; Carga del contador con el numero de offsets
    MOVLW   0x00	
    MOVWF   Offset,0	; Definir el valor del offset inicial
    GOTO    Loop  
    
Config_OSC:
    ;Configuracion del Oscilador interno a una frecuencia interna de 4Mhz
    BANKSEL OSCCON1
    MOVLW   0x60	; Seleccionamos el bloque del osc con un Div:1
    MOVWF   OSCCON1,1 
    MOVLW   0x02        ; Seleccionamos una Frecuencia de 4Mhz
    MOVWF   OSCFRQ,1
    RETURN
    
Led_OFF:
    NOP
    
Config_Port:	
    ;Config Led
    BANKSEL PORTF
    CLRF    PORTF,1		; Limpiar puerto F, PORT: Escribir
    BSF	    LATF,3,1		; LAT: Escribir, Escribir 1 en el pin 3
    BSF	    LATF,2,1		; LAT: Escribir, Escribir 1 en el pin 2
    CLRF    ANSELF,1		; ANSEL: Define como Digital	
    BCF	    TRISF,3,1		; TRIS: Salida
    BCF	    TRISF,2,1		; TRIS: Salida
    
    ;Config User Button: RA3
    BANKSEL PORTA
    CLRF    PORTA,1		; PortA <7:0> = 0, Limpiar todo el PORTA	
    CLRF    ANSELA,1		; PortA = Digital
    BSF	    TRISA,3,1		; RA3 como entrada
    BSF	    WPUA,3,1		; Activamos la resistencia Pull-up del pin RA3
    
    ;Config Button: RB4
    BANKSEL PORTB		
    CLRF    PORTB,1		; PORT: leer, Limpiar PORTB
    CLRF    ANSELB,1		; ANSEL: Digital
    BSF	    TRISB,4,1		; TRIS: Entrada
    BSF	    WPUB,4,1		; Activamos la resistencia Pull-up del pin RB4
    
    ;Config Button: RF2
    BANKSEL PORTF		
    CLRF    PORTF,1		; PORT: leer, Limpiar PORTF
    CLRF    ANSELF,1		; ANSEL: Digital
    BSF	    TRISF,2,1		; TRIS: Entrada
    BSF	    WPUB,2,1		; Activamos la resistencia Pull-up del pin RF2
    
    ;Config PORTC
    BANKSEL PORTC
    CLRF    PORTC,1		; PORT: leer,  Limpiar PORTC
    CLRF    LATC,1		; LAT: Escribir, Limpiar PORTC
    CLRF    ANSELC,1		; ANSEL: Digital
    CLRF    TRISC,1		; TRIS: Salida
    RETURN
    
Config_PPS:
    ;Config INT0: RA3
    BANKSEL INT0PPS
    MOVLW   0x03	; RA3 = 03
    MOVWF   INT0PPS,1	; INT0 --> RA3
    
    ;Config INT1: RB4
    BANKSEL INT1PPS
    MOVLW   0x0C	; RB4 = 0C
    MOVWF   INT1PPS,1	; INT1 --> RB4
    
    ;Config INT2:  RF2
    BANKSEL INT2PPS
    MOVLW   0x2A	; RF2 = 2A 
    MOVWF   INT2PPS,1	; INT2 --> RF2
    RETURN 
    
;   Secuencia para configurar interrupcion:
;    1. Definir prioridades
;    2. Configurar interrupcion
;    3. Limpiar el flag
;    4. Habilitar la interrupcion
;    5. Habilitar las interrupciones globales
Config_INT0_INT1_INT2:
    ;Configuramos las prioridades
    BSF	INTCON0,5,0	; INTCON0 <IPEN> = 1 --> Se habilitan las prioridades
    BANKSEL IPR1
    BCF	IPR1,0,1	; IPR1 <INT0IP> = 0 --> INT0 de baja prioridad
    BSF	IPR6,0,1	; IPR6 <INT1IP> = 0 --> INT1 de baja prioridad
    BSF	IPR10,0,1	; IPR1 <INT2IP> = 1 --> INT2 de alta prioridad
    
    ;Config INT0
    BCF	INTCON0,0,0	; INTCON0 <INT0EDG> = 0 --> INT0 por flanco de bajada
    BCF	PIR1,0,0	; PIR1 <INT0IF> = 0 --> Se limpia el flag de interrupcion
    BSF	PIE1,0,0	; PIE1 <INT0IE> = 1 --> Se habilita la interrupcion ext0
    
    ;Config INT1
    BCF	INTCON0,1,0	; INTCON0 <INT1EDG> = 0 --> INT1 por flanco de bajada
    BCF	PIR6,0,0	; PIR6 <INT0IF> = 0 --> Se limpia el flag de interrupcion
    BSF	PIE6,0,0	; PIE6 <INT0IE> = 1 --> Se habilita la interrupcion ext1
    
    ;Config INT2
    BCF	INTCON0,2,0	; INTCON0 <INT1EDG> = 0 --> INT1 por flanco de bajada
    BCF	PIR10,0,0	; PIR6 <INT0IF> = 0 --> Se limpia el flag de interrupcion
    BSF	PIE10,0,0	; PIE6 <INT0IE> = 1 --> Se habilita la interrupcion ext1
    
    ;Habilitacion de interrupciones
    BSF	INTCON0,7,0	; INTCON0 <GIE/GIEH> = 1 --> Se habilitan las interrupciones de forma global y de alta prioridad
    BSF	INTCON0,6,0	; INTCON0 <GIEL> = 1 --> Se habilitan las interrupciones de baja prioridad
    RETURN

Tabla_Corrimientos:
    ADDWF   PCL,1,0
    RETLW   10000001B	; offset 0: RC0 y RC7 
    RETLW   01000010B	; offset 1: RC1 y RC6
    RETLW   00100100B	; offset 2: RC2 y RC5
    RETLW   00011000B	; offset 3: RC3 y RC4
    RETLW   00000000B	; offset 4: Se apagan los leds
    RETLW   00011000B	; offset 5: RC3 y RC4
    RETLW   00100100B	; offset 6: RC2 y RC5
    RETLW   01000010B	; offset 7: RC1 y RC6
    RETLW   10000001B	; offset 8: RC0 y RC7
    RETLW   00000000B	; offset 9: Se apagan los leds

Delay_250ms:			    ; 2Tcy -- Call
    MOVLW   250			    ; 1Tcy -- k2
    MOVWF   Contador_2,0	    ; 1Tcy
; T = (6 + 4k)us		    1Tcy = 1us
Ext_Loop:		    
    MOVLW   249			    ; 1Tcy -- k1
    MOVWF   Contador_1,0	    ; 1Tcy
Int_Loop:
    NOP				    ; k1*Tcy
    DECFSZ  Contador_1,1,0	    ; (k1-1)+ 3Tcy
    GOTO    Int_Loop		    ; (k1-1)*2Tcy
    DECFSZ  Contador_2,1,0
    GOTO    Ext_Loop
    RETURN			    ; 2Tcy        

;T= (6 + 4k1)(k2)(k3)		    --> 500ms		            
Delay_500ms:
    MOVLW   2			    ; 1Tcy--k3
    MOVWF   Contador_3,0		    ; 1Tcy
D_500ms:			    ; 2Tcy--call
    MOVLW   250			    ; 1Tcy--k2
    MOVWF   Contador_2,0	    ;1Tcy
    
Ext500ms_Loop:                  
    MOVLW   249			    ; 1Tcy--k1
    MOVWF   Contador_1,0            ; 1Tcy
Int500ms_Loop:
    NOP				    ; K1*Tcy
    DECFSZ  Contador_1,1,0	    ;(k1-1)+ 3Tcy           
    GOTO    Int500ms_Loop	    ; 2Tcy
    DECFSZ  Contador_2,1,0	    ; 2Tcy
    GOTO    Ext500ms_Loop	    ; 2Tcy 
    DECFSZ  Contador_3,1,0
    GOTO    D_500ms
    RETURN			    ; 2Tcy     
exit:     
End resetVect