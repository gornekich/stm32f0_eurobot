#include "coll_avoid.h"

#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_usart.h"
#include "stm32f0xx_ll_i2c.h"
#include "stm32f0xx_ll_tim.h"

#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"
#include "gpio_map.h"
#include "peripheral.h"
#include "xprintf.h"
#include "terminal.h"
#include "err_manager.h"
#include "display.h"
#include <string.h>

#define MIN(a,b) (((a)<(b))?(a):(b))

static col_av_data_t col_av_data = {0};
static col_avoid_ctrl_t col_avoid_ctrl[NUMBER_OF_PROX_SENSORS] = {0};
static const out_t *xshut_pin;
static uint8_t high_priority_sns[] = IMPORTANT_SNS;

/*
 * Configure timer to counter mode
 */
static void tim_init(void)
{
    /*
     * Setup timer
     */
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_TIM2);
    LL_TIM_SetPrescaler(TIM2, 47999);
    LL_TIM_SetAutoReload(TIM2, 9);
    LL_TIM_SetCounterMode(TIM2, LL_TIM_COUNTERMODE_UP);
    LL_TIM_EnableIT_UPDATE(TIM2);
    LL_TIM_EnableCounter(TIM2);
    /*
     * Setup NVIC
     */
    NVIC_EnableIRQ(TIM2_IRQn);
    NVIC_SetPriority(TIM2_IRQn, 69);
    return;
}

/*
 * Public function
 */
void init_sensors(void)
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
        /*VL53L0X_PerformRefSpadManagement(&GET_DEV(ca_ctrl),
            &ca_ctrl->ref_spad_count,
            &ca_ctrl->is_aperture_spads);
        */
        VL53L0X_SetDeviceMode(&GET_DEV(ca_ctrl),
            VL53L0X_DEVICEMODE_CONTINUOUS_RANGING);
        /*
         * Now change default address of sensor and
         * distance between two neighbouring sensors is
         * CA_ADDR_DIST
         */
        VL53L0X_SetDeviceAddress(&GET_DEV(ca_ctrl), i * CA_ADDR_DIST +
                                 CA_ADDR_OFS);
        GET_DEV(ca_ctrl).I2cDevAddr = i * CA_ADDR_DIST + CA_ADDR_OFS;
        /*
         * Start measurement
         */
        VL53L0X_StartMeasurement(&GET_DEV(ca_ctrl));
    FOREACH_CA_CTRL_END(ca_ctrl)
    return;
}

VL53L0X_Error reset_sensor(uint8_t id)
{
    __disable_irq();
    VL53L0X_Error status;
    /*
     * Reset I2C
     */
    VL53L0X_hw_reset();
    /*
     * Reload XSHUT pin of sensor
     */
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    LL_GPIO_SetOutputPin(xshut_pin[id].port, xshut_pin[id].pin);
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    /*
     * Assign default address and do init procedure
     */
    GET_DEV_ID(id).I2cDevAddr = CA_DEF_ADDR;
    status = VL53L0X_DataInit(&GET_DEV_ID(id));
    if (status != VL53L0X_ERROR_NONE)
        goto err_out;
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    status = VL53L0X_StaticInit(&GET_DEV_ID(id));
    if (status != VL53L0X_ERROR_NONE)
        goto err_out;
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    status = VL53L0X_PerformRefCalibration(&GET_DEV_ID(id),
        &col_avoid_ctrl[id].vhv_settings,
        &col_avoid_ctrl[id].phase_cal);
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    if (status != VL53L0X_ERROR_NONE)
        goto err_out;
    /*
    VL53L0X_PerformRefSpadManagement(&GET_DEV_ID(id),
        &col_avoid_ctrl[id].ref_spad_count,
        &col_avoid_ctrl[id].is_aperture_spads);
    */
    status = VL53L0X_SetDeviceMode(&GET_DEV_ID(id),
        VL53L0X_DEVICEMODE_CONTINUOUS_RANGING);
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    if (status != VL53L0X_ERROR_NONE)
        goto err_out;
    /*
     * Now change default address of sensor and
     * distance between two neighbouring sensors is
     * CA_ADDR_DIST
     */
    status = VL53L0X_SetDeviceAddress(&GET_DEV_ID(id), id * CA_ADDR_DIST +
                                      CA_ADDR_OFS);
    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    if (status != VL53L0X_ERROR_NONE)
        goto err_out;
    GET_DEV_ID(id).I2cDevAddr = id * CA_ADDR_DIST + CA_ADDR_OFS;
    /*
     * Start measurement
     */
    status = VL53L0X_StartMeasurement(&GET_DEV_ID(id));
    if (status != VL53L0X_ERROR_NONE)
        goto err_out;

    VL53L0X_PollingDelay(&GET_DEV_ID(id));
    __enable_irq();
    return status;
err_out:
    LL_GPIO_ResetOutputPin(xshut_pin[id].port,
                           xshut_pin[id].pin);
    __enable_irq();
    return status;
}

void coll_avoid_init(void)
{
    col_av_data.status = 0x00;
    col_av_data.broken_num = 0;
    for (int i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        col_av_data.sns_status[i] = 0;
    }
    //memset(col_av_data, 0, NUMBER_OF_PROX_SENSORS);
    init_sensors();
    tim_init();
    return;
}

/*
 * Here we make one attempt to reload sensor, if
 * it was out of lack just skip a sensor not to make wait the
 * rest of the system. In other words, do non-blocking reset
 */
void reload_sensors(void)
{
    int i;

    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        if (!col_av_data.sns_status[i]) {
            continue;
        }
        if (reset_sensor(i) != VL53L0X_ERROR_NONE)
            continue;
        col_av_data.sns_status[i] = 0;
    }
    return;
}

uint8_t col_av_read_status(void)
{
    return col_av_data.status;
}

void col_av_set_status(uint8_t id)
{
    col_av_data.status |= 1 << id;
    return;
}
void col_av_clr_status(uint8_t id)
{
    col_av_data.status &= ~(1 << id);
    return;
}
uint8_t col_av_get_status(uint8_t id)
{
    return (col_av_data.status >> id) & 0x01;
}

void col_av_clr_full_status(void)
{
    col_av_data.status = 0;
    return;
}

void col_av_set_block(void)
{
    col_av_data.block = 1;
    return;
}
void col_av_clr_block(void)
{
    col_av_data.block = 0;
    return;
}
uint8_t col_av_get_block(void)
{
    return col_av_data.block;
}

uint8_t col_av_get_ack_block(void)
{
    return col_av_data.ack_block;
}

uint8_t col_av_blackout(void)
{
    uint8_t i;

    for (i = 0; i < sizeof(high_priority_sns); i++) {
        if (col_av_data.sns_status[high_priority_sns[i]])
            return 1;
    }
    return 0;
}

uint8_t col_av_any(void)
{
    uint8_t i;
    uint8_t cnt = 0;

    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        if (col_av_data.sns_status[i])
            cnt++;
    }
    return cnt;
}

static uint8_t get_dist(uint8_t id)
{
    static VL53L0X_RangingMeasurementData_t RangingMeasurementData;
    VL53L0X_Error err = VL53L0X_ERROR_NONE;
    uint8_t cm;
    /*
     * Try to read data from sensors
     * If there is an error then reload sensors at once
     */
    err = VL53L0X_GetRangingMeasurementData(&GET_DEV_ID(id),
                                            &RangingMeasurementData);
    if (err != VL53L0X_ERROR_NONE)
        goto err_out;
    err = VL53L0X_ClearInterruptMask(&GET_DEV_ID(id),
                       VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
    if (err != VL53L0X_ERROR_NONE) {
        goto err_out;
    }
    if (RangingMeasurementData.RangeStatus != 0) {
        col_av_data.laser_check[id] = (col_av_data.laser_check[id] + 1) %
                                      LASER_CHECK_TRSH;
        if (!col_av_data.laser_check[id]) {
            err = VL53L0X_StopMeasurement(&GET_DEV_ID(id));
            if (err)
                goto err_out;
            err = VL53L0X_StartMeasurement(&GET_DEV_ID(id));
            if (err)
                goto err_out;
        }
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
err_out:
    LL_GPIO_ResetOutputPin(xshut_pin[id].port,
                           xshut_pin[id].pin);
    return 255;
}

/*
 * Timer for sensor managing
 */
void TIM2_IRQHandler(void)
{
    static uint8_t current_id = 0;

    LL_TIM_ClearFlag_UPDATE(TIM2);
    /*
     * if reloader routine is in operation then ack its block req and
     * go away
     */
    if (col_av_data.block) {
        col_av_data.ack_block = 1;
        return;
    }
    /*
     * if reloader is off then reset ack flag
     */
    col_av_data.ack_block = 0;

    current_id = (current_id + 1) % NUMBER_OF_PROX_SENSORS;
    /*
     * If sensor is not responding skip it
     */
    if (col_av_data.sns_status[current_id])
        goto timer_out;
    /*
     * If sensor is considered to be operating then try to obtain distance
     * if it is out of lack add to the list of down sensors
     */
    col_av_data.dist[current_id] = get_dist(current_id);
    if (col_av_data.dist[current_id] == 255) {
        col_av_data.sns_status[current_id] = 1;
        col_av_data.broken_num++;
    }
timer_out:
    /*
     * if it is the last sensor then set status for reloader routine
     * and print info on the display
     */
    col_av_data.status = col_av_any();// >= SNS_TRIGGER_TRSH);
    if (col_av_data.status)
        er_man_add_err(col_av_data.sns_status, col_av_data.broken_num);

    if (current_id == (NUMBER_OF_PROX_SENSORS - 1)) {
        err_man_set_dist(col_av_data.dist, NUMBER_OF_PROX_SENSORS);
        comm_send_msg(col_av_data.dist, NUMBER_OF_PROX_SENSORS);
    }
}
