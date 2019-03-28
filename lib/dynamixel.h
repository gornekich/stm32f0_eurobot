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
}__attribute__((packed)) dyn_set_angle_t;

/*
 * Dynamixel status packet structure
 */
typedef struct {
        uint8_t header1;
        uint8_t header2;
        uint8_t id;
        uint8_t len;
        uint8_t err;
        uint8_t crc;
}__attribute__((packed)) dyn_status_pack_t;

/*
 * Flags for dynamixel
 */
#define RX_COMPLETE_POS         (0U)
#define TX_BUSY_POS             (1U)
#define CHECK_DYNAMIXEL_POS     (2U)

#define RX_COMPLETE             (0x01 << RX_COMPLETE_POS)
#define TX_BUSY                 (0x01 << TX_BUSY_POS)
#define CHECK_DYNAMIXEL         (0x01 << CHECK_DYNAMIXEL_POS)

#define is_dyn_flag_set(dyn_ctrl, bit) \
        (dyn_ctrl.flags & bit)

#define dyn_set_flag(dyn_ctrl, bit)  \
        dyn_ctrl.flags |= bit

#define dyn_clr_flag(dyn_ctrl, bit) \
        dyn_ctrl.flags &= (~bit)

/*
 * Dynamixel control structure
 */
typedef struct {
        uint8_t channel_rx[MAX_PACK_REQ_LENGTH];
        uint8_t channel_tx[MAX_PACK_REQ_LENGTH];
        uint8_t status[NUMBER_OF_DYNAMIXELS];
        uint8_t flags;
} dyn_ctrl_t;

#endif
