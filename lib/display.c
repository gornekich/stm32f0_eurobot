#include <stdint.h>

#include "display.h"
#include "fsm.h"
#include "peripheral.h"
#include "gpio_map.h"
#include "xprintf.h"

#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_rcc.h"

/*
 * Private buffer for display
 */
static uint8_t disp_buff[DISP_WIDTH * DISP_HEIGHT / 8];
/*
 * Private variable for display cursor control
 */
static disp_ctrl_t disp_ctrl;

/*
 * Private functions
 */

/*
 * Display hardware initialization
 */
static void disp_hw_config(void)
{
        /*
         * GPIO initialization
         * Reset and DC pin configuration
         */
        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOC);
        LL_GPIO_SetPinMode(DISP_RESET_PORT, DISP_RESET_PIN,
                           LL_GPIO_MODE_OUTPUT);
        LL_GPIO_SetPinMode(DISP_DC_PORT, DISP_DC_PIN, LL_GPIO_MODE_OUTPUT);
        /*
         * SPI pin configuration
         */
        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOA);
        LL_GPIO_SetPinMode(DISP_SCK_PORT, DISP_SCK_PIN, LL_GPIO_MODE_ALTERNATE);
        LL_GPIO_SetAFPin_0_7(DISP_SCK_PORT, DISP_SCK_PIN, LL_GPIO_AF_0);
        LL_GPIO_SetPinSpeed(DISP_SCK_PORT, DISP_SCK_PIN,
                            LL_GPIO_SPEED_FREQ_HIGH);

        LL_GPIO_SetPinMode(DISP_MOSI_PORT, DISP_MOSI_PIN,
                           LL_GPIO_MODE_ALTERNATE);
        LL_GPIO_SetAFPin_0_7(DISP_MOSI_PORT, DISP_MOSI_PIN, LL_GPIO_AF_0);
        LL_GPIO_SetPinSpeed(DISP_MOSI_PORT, DISP_MOSI_PIN,
                            LL_GPIO_SPEED_FREQ_HIGH);
        /*
         * SPI initialization
         */
        LL_APB1_GRP2_EnableClock(LL_APB1_GRP2_PERIPH_SPI1);
        LL_SPI_SetMode(DISP_SPI, DISP_SPI_MODE);
        LL_SPI_SetBaudRatePrescaler(DISP_SPI, DISP_SPI_BAUDRATE_PRESCALER);
        LL_SPI_SetTransferDirection(DISP_SPI, LL_SPI_FULL_DUPLEX);
        LL_SPI_SetTransferBitOrder(DISP_SPI, DISP_SPI_BIT_ORDER);
        LL_SPI_SetDataWidth(DISP_SPI, DISP_SPI_DATA_WIDTH);
        LL_SPI_EnableNSSPulseMgt(DISP_SPI);
        LL_SPI_Enable(DISP_SPI);
        return;
}

/*
 * Reset display
 */
static void disp_reset(void)
{
        int i = 48000000 / 10000;
        
        LL_GPIO_ResetOutputPin(DISP_RESET_PORT, DISP_RESET_PIN);
        while (--i);
        LL_GPIO_SetOutputPin(DISP_RESET_PORT, DISP_RESET_PIN);
        i = 48000000 / 10000; // wait display to boot
        while(--i);
        return;
}

/*
 * Send command to display
 */
static inline void disp_send_cmd(uint8_t byte)
{
        LL_GPIO_ResetOutputPin(DISP_DC_PORT, DISP_DC_PIN);
        LL_SPI_TransmitData8(DISP_SPI, byte);
        while (!LL_SPI_IsActiveFlag_TXE(SPI1));
        return;

}

/*
 * Send data to display
 */
static inline void disp_send_data(uint8_t *data, uint8_t len)
{
        uint8_t i = 0;

        if (len < 1)
                return;
        LL_GPIO_SetOutputPin(DISP_DC_PORT, DISP_DC_PIN);
        while (len--) {
                LL_SPI_TransmitData8(DISP_SPI, data[i++]);
                while (!LL_SPI_IsActiveFlag_TXE(SPI1));
        }
        return;
}

/*
 * Public functions
 */

/*
 * Fill full display with color
 */
void disp_fill(disp_color color)
{
        uint32_t i = 0;

        for (i = 0; i < sizeof(disp_buff); i++)
                disp_buff[i] = color;
        return;
}

/*
 * Update display from internal RAM
 */
void disp_update(void)
{
        uint8_t i = 0;

        for (i = 0; i < 8; i++)
        {
                disp_send_cmd(0xB7 + i);
                disp_send_cmd(0x0f);
                disp_send_cmd(0x1f);
                disp_send_data(&disp_buff[DISP_WIDTH * i], DISP_WIDTH);
        }
        return;
}

/*
 * Draw pixel in (x, y) position with color
 */
void disp_draw_pix(uint8_t x, uint8_t y, disp_color color)
{
        if (x > DISP_WIDTH || y > DISP_HEIGHT)
                return;
        if (color == WHITE)
                disp_buff[x + (y / 8) * DISP_WIDTH] |= 1 << (y % 8);
        else
                disp_buff[x + (y / 8) * DISP_WIDTH] &= ~(1 << (y % 8));
        return;
}

/*
 * Display char
 */
int disp_write_char(char ch)
{
        uint32_t i, b, j;

        if (DISP_WIDTH <= (disp_ctrl.cur_x + FONT_WIDTH) ||
            DISP_HEIGHT <= (disp_ctrl.cur_y + FONT_HEIGHT))
                return -1;

        for (i = 0; i < FONT_HEIGHT; i++) {
                b = disp_font7x10[(ch - 32) * FONT_HEIGHT + i];
                for (j = 0; j < FONT_WIDTH; j++) {
                        if ((b << j) & 0x8000) {
                                disp_draw_pix(disp_ctrl.cur_x + j, 
                                              disp_ctrl.cur_y + i,
                                              (disp_color) WHITE);
                        } else {
                                disp_draw_pix(disp_ctrl.cur_x + j,
                                              disp_ctrl.cur_y + i,
                                              (disp_color)!WHITE);
                        }
                }
        }
        disp_ctrl.cur_x += FONT_WIDTH;
        return 0;
}

/*
 * Set cursor to (x, y) point
 */
void disp_set_cursor_pix(uint8_t x, uint8_t y)
{
        if (x > DISP_WIDTH || y > DISP_HEIGHT)
                return;
        disp_ctrl.cur_x = x;
        disp_ctrl.cur_y = y;
        return;
}

/*
 * Set cursor to (x, y) char position
 */
void disp_set_cursor(uint8_t x, uint8_t y)
{
        if (x > DISP_WIDTH / FONT_WIDTH || y > DISP_WIDTH / FONT_HEIGHT)
                return;
        disp_ctrl.cur_x = x * FONT_WIDTH;
        disp_ctrl.cur_y = y * FONT_HEIGHT;
}

/*
 * Display initialization
 */
void disp_init(void)
{
        /*
         * Hardware display pins initialization
         */
        disp_hw_config();
        disp_reset();
        /*
         * Setup display
         */
        disp_send_cmd(0xAE); // turn off display
        disp_send_cmd(0x20); // set memory addressing mode
        disp_send_cmd(0x10); // set page addressing mode
        disp_send_cmd(0x00); // set lower column
        disp_send_cmd(0x1f); // set higher column
        disp_send_cmd(0xB0); // set page start
        disp_send_cmd(0x40); // set display start line
        disp_send_cmd(0xD3); // set display offset
        disp_send_cmd(0x00); // display offset zero
        disp_send_cmd(0x8D); // set DC-DC
        disp_send_cmd(0x14); // DC-DC enable
        disp_send_cmd(0x81); // set contrast
        disp_send_cmd(0xff); // set maximum contrast
        disp_send_cmd(0xA4); // set output follows RAM content
        disp_send_cmd(0xA6); // set normal display
        disp_send_cmd(0xAF); // turn on display
        /*
         * Clear screen
         */
        disp_fill(BLACK);
        disp_update();
        disp_ctrl.cur_x = 0;
        disp_ctrl.cur_y = 0;
        /*
         * Putc function for xprintf
         */
        xdev_out(disp_write_char);
        return;
}
