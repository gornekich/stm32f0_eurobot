#ifndef __TERMINAL_H__
#define __TERMINAL_H__

#include <stdint.h>

#define TERM_CH_LENGTH          255
#define TERM_CMD_LENGTH         10

typedef struct {
        uint8_t channel[TERM_CH_LENGTH];
        uint8_t params[TERM_CH_LENGTH];
        uint8_t flags;
} term_ctrl_t;

/*
 * Public function for stm32f4 communication
 */
void term_init(void);
void comm_send_msg(uint8_t *buff, int len);

#endif
