#ifndef _ERR_MANAGER_H_
#define _ERR_MANAGER_H_

#include <stdint.h>
#include "dev_map.h"

#define add_err_flag(flag, n, status) \
        flag = ((status << n) | (flag & ~(0x1 << n)))

#define get_err_flag(flag, n) \
        (((flag) >> (n)) & 0x01)

typedef struct {
        uint8_t col_av_err_flags;
        uint8_t col_av_dist[NUMBER_OF_PROX_SENSORS];
        uint8_t disp_update;
} err_ctrl_t;

void err_man_init(void);
void err_man_set_dist(uint8_t *dist, uint8_t len);
void err_man_show_err(void);
uint8_t er_man_disp_get(void);
void er_man_disp_set(void);
void er_man_disp_clr(void);

#endif //_ERR_MANAGER_H_
