#include "coll_avoid.h"

#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_usart.h"
#include "stm32f0xx_ll_i2c.h"

#include "fsm.h"

#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"
#include "dev_map.h"
#include "gpio_map.h"
#include "display.h"
#include "xprintf.h"

static col_avoid_ctrl_t col_avoid_ctrl[NUMBER_OF_PROX_SENSORS];

void fsm_coll_avoid_init(void *args)
{
    (void) args;
    VL53L0X_Error status;
    const out_t *xshut_pin;

    VL53L0X_hw_config(&xshut_pin);
    /*
     * Iterate over all collision avoidance service structures
     * initial value = col_avoid_ctrl
     * current struct = ca_ctrl
     * implicit variable to be used for iterations is i
     */
    FOREACH_CA_CTRL(col_avoid_ctrl, ca_ctrl)
        /*
         * Turn on the sensor
         */
        LL_GPIO_SetOutputPin(xshut_pin[i].port, xshut_pin[i].pin);
        /*
         * Save params for interrupt pin
         */
        /* TODO Add delay here!!!!!!!!!!!1 */
        VL53L0X_PollingDelay(&GET_DEV(ca_ctrl));
        /*
         * Assign default address and do init procedure
         */
        GET_DEV(ca_ctrl).I2cDevAddr = CA_DEF_ADDR;
        status = VL53L0X_DataInit(&GET_DEV(ca_ctrl));
        if (status != VL53L0X_ERROR_NONE) {
            continue;
        }
        VL53L0X_StaticInit(&GET_DEV(ca_ctrl));
        VL53L0X_PerformRefCalibration(&GET_DEV(ca_ctrl),
            &ca_ctrl->vhv_settings,
            &ca_ctrl->phase_cal);
        VL53L0X_PerformRefSpadManagement(&GET_DEV(ca_ctrl),
            &ca_ctrl->ref_spad_count,
            &ca_ctrl->is_aperture_spads);
        VL53L0X_SetDeviceMode(&GET_DEV(ca_ctrl),
            VL53L0X_DEVICEMODE_CONTINUOUS_RANGING);
        /*
         * Now change default address of sensor and
         * distance between two neighbouring sensors is
         * CA_ADDR_DIST
         */
        VL53L0X_SetDeviceAddress(&GET_DEV(ca_ctrl), i * CA_ADDR_DIST);
        GET_DEV(ca_ctrl).I2cDevAddr = i * CA_ADDR_DIST;
        /*
         * Start measurement
         */
        VL53L0X_StartMeasurement(&GET_DEV(ca_ctrl));
    FOREACH_CA_CTRL_END(ca_ctrl)

    fsm_add_shadow_state(FSM_COLL_AVOID_MAIN);
    fsm_set_state(FSM_TERM_MAIN);
    return;
}

void fsm_coll_avoid_main(void *args)
{
    (void) args;

    VL53L0X_RangingMeasurementData_t RangingMeasurementData;

    VL53L0X_GetRangingMeasurementData(&GET_DEV_ID(0),
                                      &RangingMeasurementData);

    VL53L0X_ClearInterruptMask(&GET_DEV_ID(0),
        VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
    return;
}
