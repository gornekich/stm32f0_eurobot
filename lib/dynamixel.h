#ifndef __DYNAMIXEL_H__
#define __DYNAMIXEL_H__

#include <stdint.h>
#include "dev_map.h"

#define MAX_PACK_REQ_LENGTH     32
#define MAX_PACK_RESP_LENGTH    32

#define DYN_MAX_ANGLE           0x3fff

/*
 * Dynamixel set angle structure
 */
typedef struct {
    uint8_t id;
    uint16_t angle;
    uint16_t speed;
}__attribute__((packed)) dyn_ctrl_t;

void dynamixel_init();
void dyn_manager(void *args);

#endif
