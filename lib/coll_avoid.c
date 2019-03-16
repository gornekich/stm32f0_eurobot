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
#include "terminal.h"

static col_avoid_ctrl_t col_avoid_ctrl[NUMBER_OF_PROX_SENSORS];

void fsm_coll_avoid_init(void *args)
{
        (void) args;
        VL53L0X_Error status;
        uint32_t xshut_pin[NUMBER_OF_PROX_SENSORS];

        VL53L0X_hw_config(xshut_pin);
        foreach_ca_ctrl(col_avoid_ctrl, ca_ctrl)
                LL_GPIO_SetOutputPin(COL_AV_XSHUT_PORT, xshut_pin[i]);
                disp_set_cursor(1, 4);
                xprintf("sensor: #%d", i);
                disp_update();
                GET_DEV(ca_ctrl).I2cDevAddr = CA_DEF_ADDR;
                status = VL53L0X_DataInit(&GET_DEV(ca_ctrl));
                if (status != VL53L0X_ERROR_NONE) {
                        disp_set_cursor(1, 5);
                        xprintf("error!: #%d", i);
                        disp_update();
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
                VL53L0X_SetDeviceAddress(&GET_DEV(ca_ctrl), i * 0x20);
                GET_DEV(ca_ctrl).I2cDevAddr = i * 0x20;
                VL53L0X_StartMeasurement(&GET_DEV(ca_ctrl));
        foreach_ca_ctrl_end(ca_ctrl)

        fsm_add_shadow_state(FSM_COLL_AVOID_MAIN);
        fsm_set_state(FSM_TERM_MAIN);
        return;
}

void fsm_coll_avoid_main(void *args)
{
        (void) args;
        static int counter = 0;
        static uint8_t prox_vals[3];

        counter = (counter + 1) % 20000;
        if (counter)
            return;
        VL53L0X_RangingMeasurementData_t RangingMeasurementData;

        VL53L0X_GetRangingMeasurementData(&GET_DEV_ID(0),
                                          &RangingMeasurementData);
        disp_set_cursor(1, 4);
        xprintf("d0: %d cm  ", RangingMeasurementData.RangeMilliMeter/10);
        if (RangingMeasurementData.RangeMilliMeter/10 > 255)
                prox_vals[0] = 255;
        else
                prox_vals[0] = RangingMeasurementData.RangeMilliMeter/10;

        VL53L0X_ClearInterruptMask(&GET_DEV_ID(0),
                          VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
        VL53L0X_GetRangingMeasurementData(&GET_DEV_ID(1),
                                          &RangingMeasurementData);
        disp_set_cursor(1, 5);
        xprintf("d1: %dcm", RangingMeasurementData.RangeMilliMeter/10);
        if (RangingMeasurementData.RangeMilliMeter/10 > 255)
                prox_vals[1] = 255;
        else
                prox_vals[1] = RangingMeasurementData.RangeMilliMeter/10;

        VL53L0X_ClearInterruptMask(&GET_DEV_ID(1),
                          VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);

        VL53L0X_GetRangingMeasurementData(&GET_DEV_ID(2),
                                          &RangingMeasurementData);
        disp_set_cursor(10, 5);
        xprintf("d2: %dcm ", RangingMeasurementData.RangeMilliMeter/10);
        if (RangingMeasurementData.RangeMilliMeter/10 > 255)
                prox_vals[2] = 255;
        else
                prox_vals[2] = RangingMeasurementData.RangeMilliMeter/10;

        VL53L0X_ClearInterruptMask(&GET_DEV_ID(2),
                          VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
        comm_send_msg(prox_vals, 3);
        disp_update();
        return;
}
