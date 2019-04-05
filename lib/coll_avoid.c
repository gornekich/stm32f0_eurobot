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
#include "xprintf.h"
#include "terminal.h"
#include "err_manager.h"
#include "display.h"

#define MIN(a,b) (((a)<(b))?(a):(b))

static col_av_data_t col_av_data;
static col_avoid_ctrl_t col_avoid_ctrl[NUMBER_OF_PROX_SENSORS];
static const out_t *xshut_pin;

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
    LL_TIM_SetAutoReload(TIM2, 99);
    LL_TIM_SetCounterMode(TIM2, LL_TIM_COUNTERMODE_UP);
    LL_TIM_EnableIT_UPDATE(TIM2);
    LL_TIM_EnableCounter(TIM2);
    /*
     * Setup NVIC
     */
    NVIC_EnableIRQ(TIM2_IRQn);
    NVIC_SetPriority(TIM2_IRQn, 4);
    return;
}

/*
 * Public function
 */
void reset_sensors(void)
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

void reset_sensor(uint8_t id)
{
        VL53L0X_Error status;

        /*
         * Turn on the sensor
         */
        LL_GPIO_SetOutputPin(xshut_pin[id].port, xshut_pin[id].pin);
        /*
         * Save params for interrupt pin
         */
        VL53L0X_PollingDelay(&GET_DEV_ID(id));
        /*
         * Assign default address and do init procedure
         */
        GET_DEV_ID(id).I2cDevAddr = CA_DEF_ADDR;
        status = VL53L0X_DataInit(&GET_DEV_ID(id));
        if (status != VL53L0X_ERROR_NONE) {
            return;
        }
        VL53L0X_StaticInit(&GET_DEV_ID(id));
        VL53L0X_PerformRefCalibration(&GET_DEV_ID(id),
            &col_avoid_ctrl[id].vhv_settings,
            &col_avoid_ctrl[id].phase_cal);
        VL53L0X_PerformRefSpadManagement(&GET_DEV_ID(id),
            &col_avoid_ctrl[id].ref_spad_count,
            &col_avoid_ctrl[id].is_aperture_spads);
        VL53L0X_SetDeviceMode(&GET_DEV_ID(id),
            VL53L0X_DEVICEMODE_CONTINUOUS_RANGING);
        /*
         * Now change default address of sensor and
         * distance between two neighbouring sensors is
         * CA_ADDR_DIST
         */
        VL53L0X_SetDeviceAddress(&GET_DEV_ID(id), id * CA_ADDR_DIST);
        GET_DEV_ID(id).I2cDevAddr = id * CA_ADDR_DIST;
        /*
         * Start measurement
         */
        VL53L0X_StartMeasurement(&GET_DEV_ID(id));
        return;
}

void coll_avoid_init(void)
{
    col_av_data.status = 0x00;
    tim_init();
    reset_sensors();
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
    if (err != VL53L0X_ERROR_NONE) {
        return 255;
    }
    err = VL53L0X_ClearInterruptMask(&GET_DEV_ID(id),
                       VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
    if (err != VL53L0X_ERROR_NONE) {
        return 255;
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

/*
 * Set flag for display update
 */
void TIM2_IRQHandler(void)
{
    static uint8_t current_id = 0;

    if (!col_av_data.block) {
        col_av_data.dist[current_id] = get_dist(current_id);
        if (col_av_data.dist[current_id] == 255)
            col_av_set_status(current_id);
        if (current_id == (NUMBER_OF_PROX_SENSORS - 1)) {
            err_man_set_dist(col_av_data.dist, NUMBER_OF_PROX_SENSORS);
            //err_man_show_err();
            //disp_fill(BLACK);
            // disp_set_cursor(1, 1);
            // xprintf("%d:%d", current_id, col_av_data.dist[current_id]);
            // disp_update();
            // comm_send_msg(col_av_data.dist, NUMBER_OF_PROX_SENSORS);
        }
        current_id = (current_id + 1) % NUMBER_OF_PROX_SENSORS;
    }
    LL_TIM_ClearFlag_UPDATE(TIM2);
}
