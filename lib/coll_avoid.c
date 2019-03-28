#include "coll_avoid.h"

#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_usart.h"
#include "stm32f0xx_ll_i2c.h"
#include "stm32f0xx_ll_tim.h"

#include "fsm.h"

#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"
#include "dev_map.h"
#include "gpio_map.h"
#include "display.h"
#include "xprintf.h"
#include "terminal.h"
#include "err_manager.h"

#define MIN(a,b) (((a)<(b))?(a):(b))

static col_avoid_ctrl_t col_avoid_ctrl[NUMBER_OF_PROX_SENSORS];
static const out_t *xshut_pin;

void reset_sensors()
{
    VL53L0X_Error status;

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
    return;
}

void fsm_coll_avoid_init(void *args)
{
    (void) args;

    reset_sensors();
    fsm_add_shadow_state(FSM_COLL_AVOID_MAIN);
    fsm_set_state(FSM_ERR_MAN_SHOW_ERR);
    return;
}

static int16_t get_dist(int id)
{
    static VL53L0X_RangingMeasurementData_t RangingMeasurementData;
    static VL53L0X_Error err = VL53L0X_ERROR_NONE;
    uint16_t cm;
    /*
     * Try to read data from sensors
     * If there is an error then reload sensors at once
     */
    if (err != VL53L0X_ERROR_NONE)
        reset_sensors();
    err = VL53L0X_GetRangingMeasurementData(&GET_DEV_ID(id),
                                            &RangingMeasurementData);
    if (err != VL53L0X_ERROR_NONE) {
        reset_sensors();
        return -1;
    }
    err = VL53L0X_ClearInterruptMask(&GET_DEV_ID(id),
                       VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
    if (err != VL53L0X_ERROR_NONE) {
        reset_sensors();
        return -1;
    }
    /*
     * Read distance and round it, decrease the number of significant
     * bits and limit max distance to 50 cm
     */
    cm = RangingMeasurementData.RangeMilliMeter / 10;
    if (RangingMeasurementData.RangeMilliMeter % 10 >= 5)
        cm += 1;
    cm = cm >> 1;
    return MIN(cm * 2, 50);
}

void fsm_coll_avoid_main(void *args)
{
    (void) args;
    int dist = 0;
    int i;

    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        dist = get_dist(i);
        if (dist == -1) {
            err_man_update_col_av_status(i, 1);
        }
        else {
            err_man_update_col_av_status(i, 0);
            err_man_set_dist(i, dist);
        }
    }
    fsm_set_data(FSM_TERM_MAIN, (void *) UPDATE_DISPLAY);
    return;
}
