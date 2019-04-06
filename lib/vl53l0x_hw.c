#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"

#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_i2c.h"
#include "stm32f0xx_ll_exti.h"
#include "peripheral.h"
#include "gpio_map.h"
#include "dev_map.h"

/*
 * Configuration structures for control pins
 */
static const out_t xshut_config[] = COL_AV_XSHUT_CONFIG;

void VL53L0X_hw_config(const out_t **xshut_pin) {
    uint16_t i;
    /*
     * Clock on the I2C port and configure it
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOB);
    LL_GPIO_SetPinMode(COL_AV_I2C_PORT, COL_AV_I2C_SCL,
                       LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetPinOutputType(COL_AV_I2C_PORT, COL_AV_I2C_SCL,
                             LL_GPIO_OUTPUT_OPENDRAIN);
    LL_GPIO_SetAFPin_0_7(COL_AV_I2C_PORT, COL_AV_I2C_SCL, LL_GPIO_AF_1);
    LL_GPIO_SetPinSpeed(COL_AV_I2C_PORT, COL_AV_I2C_SCL,
                        LL_GPIO_SPEED_FREQ_HIGH);

    LL_GPIO_SetPinMode(COL_AV_I2C_PORT, COL_AV_I2C_SDA,
                       LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetPinOutputType(COL_AV_I2C_PORT, COL_AV_I2C_SDA,
                             LL_GPIO_OUTPUT_OPENDRAIN);
    LL_GPIO_SetAFPin_0_7(COL_AV_I2C_PORT, COL_AV_I2C_SDA, LL_GPIO_AF_1);
    LL_GPIO_SetPinSpeed(COL_AV_I2C_PORT, COL_AV_I2C_SDA,
                        LL_GPIO_SPEED_FREQ_HIGH);
    /*
     * Configure XSHUT pins (to set up I2C addresses for sensors
     * in advance)
     * NOTE: take care of clocking on corresponding ports!
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOC);
    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        LL_GPIO_SetPinMode(xshut_config[i].port, xshut_config[i].pin,
                           LL_GPIO_MODE_OUTPUT);
        LL_GPIO_SetPinOutputType(xshut_config[i].port, xshut_config[i].pin,
                                 LL_GPIO_OUTPUT_PUSHPULL);
        LL_GPIO_ResetOutputPin(xshut_config[i].port, xshut_config[i].pin);
    }
    *xshut_pin = xshut_config;

    /*
     * Clock on the I2C peripheral and set it up
     */
    LL_RCC_SetI2CClockSource(LL_RCC_I2C1_CLKSOURCE_SYSCLK);
    LL_I2C_Disable(COL_AV_I2C);
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_I2C1);
    LL_I2C_DisableAnalogFilter(COL_AV_I2C);
    LL_I2C_SetDigitalFilter(COL_AV_I2C, 1);
    LL_I2C_SetTiming(COL_AV_I2C, COL_AV_I2C_TIMING);
    LL_I2C_DisableClockStretching(COL_AV_I2C);
    LL_I2C_SetMasterAddressingMode(COL_AV_I2C, COL_AV_I2C_ADDR_MODE);
    LL_I2C_SetMode(COL_AV_I2C, COL_AV_I2C_MODE);
    LL_I2C_Enable(COL_AV_I2C);

    return;
}

VL53L0X_Error VL53L0X_WriteMulti(VL53L0X_DEV Dev, uint8_t index,
                                 uint8_t *pdata, uint32_t count)
{
    uint8_t i;
    int32_t timeout = I2C_IO_TIMEOUT;

    /*
     * Init transmit and set all params
     */
    LL_I2C_HandleTransfer(COL_AV_I2C, Dev->I2cDevAddr, LL_I2C_ADDRSLAVE_7BIT,
                          count + 1, LL_I2C_MODE_AUTOEND,
                          LL_I2C_GENERATE_START_WRITE);
    /*
     * Wait till I2C is ready to transmit and send address of reg
     */
    while (!LL_I2C_IsActiveFlag_TXIS(COL_AV_I2C) && (timeout-- > 0));
    if (timeout <= 0)
        return VL53L0X_ERROR_TIME_OUT;
    LL_I2C_TransmitData8(COL_AV_I2C, index);
    /*
     * Send all data to slave waiting for TXIS on each step
     */
    for (i = 0; i < count; i++) {
        while (!LL_I2C_IsActiveFlag_TXIS(COL_AV_I2C) && (timeout-- > 0));
        if (timeout <= 0)
            return VL53L0X_ERROR_TIME_OUT;
        LL_I2C_TransmitData8(COL_AV_I2C, pdata[i]);
    }
    /*
     * Check for end of transmission
     */
    while (LL_I2C_IsActiveFlag_TC(COL_AV_I2C) && (timeout-- > 0));
    if (timeout <= 0)
        return VL53L0X_ERROR_TIME_OUT;

    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_ReadMulti(VL53L0X_DEV Dev, uint8_t index,
                                uint8_t *pdata, uint32_t count)
{
    uint8_t i;
    int32_t timeout = I2C_IO_TIMEOUT;

    /*
     * Init transmit of register address
     */
    if (VL53L0X_WriteMulti(Dev, index, NULL, 0) == VL53L0X_ERROR_TIME_OUT)
        return VL53L0X_ERROR_TIME_OUT;
    /*
     * Init reading of package size of count
     */
    LL_I2C_HandleTransfer(COL_AV_I2C, Dev->I2cDevAddr, LL_I2C_ADDRSLAVE_7BIT,
                          count, LL_I2C_MODE_AUTOEND,
                          LL_I2C_GENERATE_START_READ);
    /*
     * Receive all data from the slave
     */
    for (i = 0; i < count; i++) {
        while (!LL_I2C_IsActiveFlag_RXNE(COL_AV_I2C) && (timeout-- > 0));
        if (timeout <= 0)
            return VL53L0X_ERROR_TIME_OUT;
        pdata[i] = LL_I2C_ReceiveData8(COL_AV_I2C);
    }
    /*
     * Check if it is the end of receiving
     */
    while (LL_I2C_IsActiveFlag_TC(COL_AV_I2C) && (timeout-- > 0));
    if (timeout <= 0)
        return VL53L0X_ERROR_TIME_OUT;

    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_WrByte(VL53L0X_DEV Dev, uint8_t index,
                             uint8_t data)
{
    VL53L0X_WriteMulti(Dev, index, &data, 1);
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_WrWord(VL53L0X_DEV Dev, uint8_t index, uint16_t data)
{
    uint8_t data_b[2];

    data_b[0] = (uint8_t) (data >> 8);
    data_b[1] = (uint8_t) (data & 0x00FF);
    VL53L0X_WriteMulti(Dev, index, data_b, 2);
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_WrDWord(VL53L0X_DEV Dev, uint8_t index, uint32_t data)
{
    uint8_t data_b[4];

    data_b[0] = (uint8_t) (data >> 24);
    data_b[1] = (uint8_t) (data >> 16);
    data_b[2] = (uint8_t) (data >> 8);
    data_b[3] = (uint8_t) (data & 0x00FF);
    VL53L0X_WriteMulti(Dev, index, data_b, 4);
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_UpdateByte(VL53L0X_DEV Dev, uint8_t index,
                                 uint8_t AndData, uint8_t OrData)
{
    uint8_t data;

    VL53L0X_ReadMulti(Dev, index, &data, 1);
    data = (data & AndData) | OrData;
    VL53L0X_WriteMulti(Dev, index, &data, 1);
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_RdByte(VL53L0X_DEV Dev, uint8_t index, uint8_t *data)
{
    VL53L0X_ReadMulti(Dev, index, data, 1);
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_RdWord(VL53L0X_DEV Dev, uint8_t index, uint16_t *data)
{
    uint8_t data_b[2];

    VL53L0X_ReadMulti(Dev, index, data_b, 2);
    *data = ((uint16_t) data_b[0] << 8) + (uint16_t) data_b[1];
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_RdDWord(VL53L0X_DEV Dev, uint8_t index, uint32_t *data)
{
    uint8_t data_b[4];

    VL53L0X_ReadMulti(Dev, index, data_b, 4);
    *data = ((uint32_t) data_b[0] << 24) + ((uint32_t) data_b[1] << 16) +
            ((uint32_t) data_b[2] << 8) + (uint32_t) data_b[3];
    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_PollingDelay(VL53L0X_DEV Dev)
{
    (void) Dev;
    uint32_t count = 5000;

    while (count--);
    return VL53L0X_ERROR_NONE;
}
