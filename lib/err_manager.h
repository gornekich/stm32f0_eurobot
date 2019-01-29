#ifndef _ERR_MANAGER_H_
#define _ERR_MANAGER_H_

#include <stdint.h>
#include "dev_map.h"

#define add_err_flag(flag, n) \
        flag |= (0x01 << ((id) - 1))

#define get_err_flag(flag, n) \
        (((flag) >> ((n) - 1)) & 0x01)

typedef struct {
        uint8_t dyn_err_flags;
        uint8_t col_av_err_flags;
        uint8_t dyn_err_status[NUMBER_OF_DYNAMIXELS];
        uint8_t col_av_err_status[NUMBER_OF_PROX_SENSORS];
} err_ctrl_t;

void err_man_update_dyn_status(uint8_t id, uint8_t status);
void err_man_update_col_av_status(uint8_t id, uint8_t status);

#endif //_ERR_MANAGER_H_
