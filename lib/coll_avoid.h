#ifndef __COLL_AVOID__
#define __COLL_AVOID__

#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"
#include "dev_map.h"

typedef struct {
    uint8_t dist[NUMBER_OF_PROX_SENSORS];
    uint8_t sns_status[NUMBER_OF_PROX_SENSORS];
    uint8_t broken_num;
    uint8_t status;
    uint8_t block;
    uint8_t ack_block;
} col_av_data_t;

typedef struct {
    VL53L0X_Dev_t MyDevice;
    uint8_t vhv_settings;
    uint8_t phase_cal;
    uint32_t ref_spad_count;
    uint8_t is_aperture_spads;
} col_avoid_ctrl_t;

#define GET_DEV(av_ctrl) av_ctrl->MyDevice
#define GET_DEV_ID(id) col_avoid_ctrl[id].MyDevice

#define FOREACH_CA_CTRL(gen_struct, iter) \
    col_avoid_ctrl_t *iter = NULL; \
    for (int i = 0; i < NUMBER_OF_PROX_SENSORS; i++) { \
        iter=&gen_struct[i];

#define FOREACH_CA_CTRL_END(iter) \
     } \
     (void) iter;

#define WITH_CA_CTRL(gen_struct, ca_ctrl, id) \
    col_avoid_ctrl_t *ca_ctrl = &gen_struct[id]; {

#define END_WITH_CA_CTRL(ca_ctrl) \
    } \
    (void) ca_ctrl;

#define CA_DEF_ADDR 0x52
#define CA_ADDR_DIST 0x2
#define INTERRESET_TIME 1000
#define SNS_TRIGGER_TRSH 1

/*
 * Define the numbers of high priority sensors to avoid
 * waiting in reload procedure
 */
#define IMPORTANT_SNS {0,1,2}

/*
 * Public functions
 */
void init_sensors(void);
void reset_sensors(void);
VL53L0X_Error reset_sensor(uint8_t id);
void reload_sensors(void);
void coll_avoid_init(void);

uint8_t col_av_read_status(void);
void col_av_set_status(uint8_t id);
void col_av_clr_status(uint8_t id);
uint8_t col_av_get_status(uint8_t id);
void col_av_clr_full_status(void);

uint8_t col_av_get_block(void);
void col_av_clr_block(void);
void col_av_set_block(void);

uint8_t col_av_get_ack_block(void);

uint8_t col_av_blackout(void);

uint8_t col_av_any(void);
#endif
