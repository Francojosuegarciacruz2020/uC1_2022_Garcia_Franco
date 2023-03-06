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

