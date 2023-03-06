#ifndef MAX7219_H
#define MAX7219_H

#include <xc.h>
#include <stdint.h>

#define MAX7219_ORIENTATION_VERTICAL   0
#define MAX7219_ORIENTATION_HORIZONTAL 1

#define MAX7219_NO_OP       0x00
#define MAX7219_DIGIT_0     0x01
#define MAX7219_DIGIT_1     0x02
#define MAX7219_DIGIT_2     0x03
#define MAX7219_DIGIT_3     0x04
#define MAX7219_DIGIT_4     0x05
#define MAX7219_DIGIT_5     0x06
#define MAX7219_DIGIT_6     0x07
#define MAX7219_DIGIT_7     0x08
#define MAX7219_DECODE_MODE 0x09
#define MAX7219_INTENSITY   0x0A
#define MAX7219_SCAN_LIMIT  0x0B
#define MAX7219_SHUTDOWN    0x0C
#define MAX7219_DISPLAY_TEST 0x0F

#define MAX7219_DISPLAY_ON  1
#define MAX7219_DISPLAY_OFF 0

#define MAX7219_INTENSITY_MIN   0
#define MAX7219_INTENSITY_MAX   15

void max7219_init(void);
void max7219_write(uint8_t reg, uint8_t data);
void max7219_set_intensity(uint8_t intensity);
void max7219_set_scan_limit(uint8_t limit);
void max7219_set_display(uint8_t on);
void max7219_set_orientation(uint8_t orientation);
void max7219_clear(void);
void max7219_shift(const char *text);

#endif





/* Microchip Technology Inc. and its subsidiaries.  You may use this software 
 * and any derivatives exclusively with Microchip products. 
 * 
 * THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS".  NO WARRANTIES, WHETHER 
 * EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED 
 * WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A 
 * PARTICULAR PURPOSE, OR ITS INTERACTION WITH MICROCHIP PRODUCTS, COMBINATION 
 * WITH ANY OTHER PRODUCTS, OR USE IN ANY APPLICATION. 
 *
 * IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE, 
 * INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND 
 * WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS 
 * BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE.  TO THE 
 * FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS 
 * IN ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF 
 * ANY, THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
 *
 * MICROCHIP PROVIDES THIS SOFTWARE CONDITIONALLY UPON YOUR ACCEPTANCE OF THESE 
 * TERMS. 
 */

/* 
 * File:   
 * Author: 
 * Comments:
 * Revision history: 
 */

// This is a guard condition so that contents of this file are not included
// more than once.  
#ifndef XC_HEADER_TEMPLATE_H
#define	XC_HEADER_TEMPLATE_H

#include <xc.h> // include processor files - each processor file is guarded.  

// TODO Insert appropriate #include <>

// TODO Insert C++ class definitions if appropriate

// TODO Insert declarations

// Comment a function and leverage automatic documentation with slash star star
/**
    <p><b>Function prototype:</b></p>
  
    <p><b>Summary:</b></p>

    <p><b>Description:</b></p>

    <p><b>Precondition:</b></p>

    <p><b>Parameters:</b></p>

    <p><b>Returns:</b></p>

    <p><b>Example:</b></p>
    <code>
 
    </code>

    <p><b>Remarks:</b></p>
 */
// TODO Insert declarations or function prototypes (right here) to leverage 
// live documentation

#ifdef	__cplusplus
extern "C" {
#endif /* __cplusplus */

    // TODO If C++ is being used, regular C code needs function names to have C 
    // linkage so the functions can be used by the c code. 

#ifdef	__cplusplus
}
#endif /* __cplusplus */

#endif	/* XC_HEADER_TEMPLATE_H */

