#ifndef _DISPLAY_H_
#define _DISPLAY_H_

#define DISP_HEIGHT             64
#define DISP_WIDTH              128

#define FONT_WIDTH              7
#define FONT_HEIGHT             10

#define RESET_DELAY             4800

extern const uint16_t disp_font7x10[];

typedef enum {
    BLACK = 0x00,
    WHITE = 0x01
} disp_color;

typedef struct {
    uint8_t cur_x;
    uint8_t cur_y;
} disp_ctrl_t;

void disp_fill(disp_color color);
void disp_update(void);
void disp_draw_pix(uint8_t x, uint8_t y, disp_color color);
int disp_write_char(char ch);
void disp_set_cursor_pix(uint8_t x, uint8_t y);
void disp_set_cursor(uint8_t x, uint8_t y);
void disp_init(void);

#endif
