#ifndef __COLL_AVOID__
#define __COLL_AVOID__

#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"

typedef struct {
        VL53L0X_Dev_t MyDevice;
        uint8_t vhv_settings;
        uint8_t phase_cal;
        uint32_t ref_spad_count;
        uint8_t is_aperture_spads;
} col_avoid_ctrl_t;

#define GET_DEV(av_ctrl) av_ctrl->MyDevice
#define foreach_ca_ctrl(gen_struct, iter) \
        col_avoid_ctrl_t *iter = NULL; \
        for (int i = 0; i < NUMBER_OF_PROX_SENSORS; i++) { \
            iter=&gen_struct[i];

#define foreach_ca_ctrl_end(iter) \
        } \
        (void) iter;

#define CA_DEF_ADDR 0x52

#endif
