#ifndef __DYNAMIXEL_H__
#define __DYNAMIXEL_H__

#include <stdint.h>

#define MAX_PACK_REQ_LENGTH     32
#define MAX_PACK_RESP_LENGTH    32

/*
 * Dynamixel set angle structure
 */
typedef struct {
        uint8_t id;
        uint16_t angle;
}__attribute__((packed)) dyn_set_angle_t;

/*
 * Dynamixel control struxture
 */
typedef struct {
        uint8_t channel_rx[MAX_PACK_RESP_LENGTH];
        uint8_t channel_tx[MAX_PACK_REQ_LENGTH];
        uint8_t rx_complete;
} dyn_ctrl_t;

void fsm_dynamixel_init(void *args);

#endif
