#include "vl53l0x_api.h"
#include "vl53l0x_hw.h"

#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_i2c.h"

void VL53L0X_hw_config(void)
{
    /*
     * Clock on the I2C port
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOB);
    // I2C_SCL
    LL_GPIO_SetPinMode(GPIOB, LL_GPIO_PIN_6, LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetPinOutputType(GPIOB, LL_GPIO_PIN_6,
                             LL_GPIO_OUTPUT_OPENDRAIN);
    LL_GPIO_SetAFPin_0_7(GPIOB, LL_GPIO_PIN_6, LL_GPIO_AF_1);
    LL_GPIO_SetPinSpeed(GPIOB, LL_GPIO_PIN_6, LL_GPIO_SPEED_FREQ_HIGH);
    // I2C_SDA
    LL_GPIO_SetPinMode(GPIOB, LL_GPIO_PIN_7, LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetPinOutputType(GPIOB, LL_GPIO_PIN_6,
                             LL_GPIO_OUTPUT_OPENDRAIN);
    LL_GPIO_SetAFPin_0_7(GPIOB, LL_GPIO_PIN_7, LL_GPIO_AF_1);
    LL_GPIO_SetPinSpeed(GPIOB, LL_GPIO_PIN_7, LL_GPIO_SPEED_FREQ_HIGH);
    /*
     * Clock on the I2C peripheral
     */
    LL_RCC_SetI2CClockSource(LL_RCC_I2C1_CLKSOURCE_SYSCLK);
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_I2C1);
    LL_I2C_DisableAnalogFilter(I2C1);
    LL_I2C_SetDigitalFilter(I2C1, 1);
    // 100 KHz data communication, Fclk = 48 MHz
    // PRESC = 0xB, SCLL = 0x13, SCLH = 0xF, SDADEL = 0x2, SCLDEL = 0x4
    LL_I2C_SetTiming(I2C1, 0xB0420F13);
    LL_I2C_DisableClockStretching(I2C1);
    LL_I2C_SetMasterAddressingMode(I2C1, LL_I2C_ADDRESSING_MODE_7BIT);
    LL_I2C_SetMode(I2C1, LL_I2C_MODE_I2C);
    LL_I2C_Enable(I2C1);
    return;
}

VL53L0X_Error VL53L0X_WriteMulti(VL53L0X_DEV Dev, uint8_t index,
                                 uint8_t *pdata, uint32_t count)
{
    uint8_t i;

    //xprintf("WriteMulti in (byte: %d)\n", count);
    /*
     * Init transmit and set all params
     */
    LL_I2C_HandleTransfer(I2C1, Dev->I2cDevAddr, LL_I2C_ADDRSLAVE_7BIT,
                          count + 1, LL_I2C_MODE_AUTOEND,
                          LL_I2C_GENERATE_START_WRITE);
    /*
     * Wait till I2C is ready to transmit and send address of reg
     */
    while (!LL_I2C_IsActiveFlag_TXIS(I2C1));
    LL_I2C_TransmitData8(I2C1, index);
    /*
     * Send all data to slave waiting for TXIS on each step
     */
    for (i = 0; i < count; i++) {
        while (!LL_I2C_IsActiveFlag_TXIS(I2C1));
        LL_I2C_TransmitData8(I2C1, pdata[i]);
    }
    /*
     * Check for end of transmission
     */
    while (LL_I2C_IsActiveFlag_TC(I2C1));

    return VL53L0X_ERROR_NONE;
}

VL53L0X_Error VL53L0X_ReadMulti(VL53L0X_DEV Dev, uint8_t index,
                                uint8_t *pdata, uint32_t count)
{
    uint8_t i;

    /*
     * Init transmit of register address
     */
    LL_I2C_HandleTransfer(I2C1, Dev->I2cDevAddr, LL_I2C_ADDRSLAVE_7BIT,
                          1, LL_I2C_MODE_AUTOEND,
                          LL_I2C_GENERATE_START_WRITE);
    /*
     * Wait till I2C is ready to transmit and send reg address
     */
    while (!LL_I2C_IsActiveFlag_TXIS(I2C1));
    LL_I2C_TransmitData8(I2C1, index);
    /*
     * Check for end of transmission
     */
    while (LL_I2C_IsActiveFlag_TC(I2C1));
    /*
     * Init reading of package size of count
     */
    LL_I2C_HandleTransfer(I2C1, Dev->I2cDevAddr, LL_I2C_ADDRSLAVE_7BIT,
                          count, LL_I2C_MODE_AUTOEND,
                          LL_I2C_GENERATE_START_READ);
    /*
     * Receive all data from the slave
     */
    for (i = 0; i < count; i++) {
        while (!LL_I2C_IsActiveFlag_RXNE(I2C1));
        pdata[i] = LL_I2C_ReceiveData8(I2C1);
    }
    /*
     * Check for end of receiving
     */
    while (LL_I2C_IsActiveFlag_TC(I2C1));

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
    uint32_t count = 10000;

    while (count--);
    return VL53L0X_ERROR_NONE;
}
