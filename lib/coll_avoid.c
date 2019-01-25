#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_usart.h"
#include "stm32f0xx_ll_i2c.h"

#include "fsm.h"

#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"

static VL53L0X_Dev_t MyDevice;

void fsm_coll_avoid_init(void *args)
{
        (void) args;
        uint8_t VhvSettings;
        uint8_t PhaseCal;
        uint32_t refSpadCount;
        uint8_t isApertureSpads;

        VL53L0X_hw_config();

        MyDevice.I2cDevAddr = 0x52;
        VL53L0X_DataInit(&MyDevice);
        VL53L0X_StaticInit(&MyDevice); // Device Initialization
        VL53L0X_PerformRefCalibration(&MyDevice,
                 &VhvSettings, &PhaseCal); // Device Initialization
        VL53L0X_PerformRefSpadManagement(&MyDevice,
                &refSpadCount, &isApertureSpads); // Device Initialization
        VL53L0X_SetDeviceMode(&MyDevice,
                              VL53L0X_DEVICEMODE_CONTINUOUS_RANGING);
        VL53L0X_StartMeasurement(&MyDevice);
        VL53L0X_SetDeviceAddress(&MyDevice, 0x20);
        MyDevice.I2cDevAddr = 0x20;

        fsm_add_shadow_state(FSM_COLL_AVOID_MAIN);
        fsm_set_state(FSM_TERM_MAIN);
        return;
}

void fsm_coll_avoid_main(void *args)
{
        (void) args;
        VL53L0X_RangingMeasurementData_t RangingMeasurementData;

        VL53L0X_GetRangingMeasurementData(&MyDevice, &RangingMeasurementData);
        //xprintf("data: %d sm\n", RangingMeasurementData.RangeMilliMeter/10);
        VL53L0X_ClearInterruptMask(&MyDevice, VL53L0X_REG_SYSTEM_INTERRUPT_GPIO_NEW_SAMPLE_READY);
        return;
}
