#include "dynamixel.h"
#include "gpio_map.h"
#include "peripheral.h"
#include "err_manager.h"

#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_bus.h"

/*
 * Private functions
 */

/*
 * Send command
 */
static void dyn_send_cmd(uint8_t *buff, int len)
{
    int i = 0;

    LL_USART_DisableDirectionRx(DYNAMIXEL_USART);
    LL_USART_EnableDirectionTx(DYNAMIXEL_USART);
    LL_USART_ClearFlag_TC(DYNAMIXEL_USART);
    while (len--) {
            while (!LL_USART_IsActiveFlag_TXE(DYNAMIXEL_USART));
            LL_USART_TransmitData8(DYNAMIXEL_USART, buff[i++]);
    }
    while (!LL_USART_IsActiveFlag_TC(DYNAMIXEL_USART));
    LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
    LL_USART_EnableDirectionRx(DYNAMIXEL_USART);
    return;
}

static void dyn_delay(uint32_t i)
{
    while(i--);
    return;
}

static void dyn_set_angle(uint8_t id, uint16_t angle)
{
    /*
     * Make new packet
     */
    static const uint8_t DYN_SET_ANGLE_CMD_LEN = 9;
    uint8_t highByte = (uint8_t)((angle >> 8) & 0xff);
    uint8_t lowByte = (uint8_t)(angle & 0xff);
    uint8_t crc = id + 0x05 + 0x03 + 0x1e + lowByte + highByte;
    uint8_t tx[] = {0xff, 0xff, id, 0x05, 0x03, 0x1e, lowByte,
                           highByte, ~crc};
    if (angle > DYN_MAX_ANGLE)
        return;
    LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_9);
    dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
    return;
}

static void dyn_set_init_pos(uint8_t *angles)
{
    static const uint8_t DYN_SET_ANGLE_CMD_LEN = 9;
    int i = 0;
    int j = 0;
    for (i = 0, j = 0; i < NUMBER_OF_DYNAMIXELS; i++, j = j + 2)
    {
        uint8_t highByte = angles[j];
        uint8_t lowByte = angles[j + 1];
        uint8_t crc = (i + 1) + 0x05 + 0x03 + 0x1e + lowByte + highByte;
        uint8_t tx[] = {0xff, 0xff, i + 1, 0x05, 0x03, 0x1e, lowByte,
                               highByte, ~crc};
        LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_9);
        dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
        dyn_delay(48000000/1000);
    }
    // uint16_t default_pos[] = {0x01, 0x5a, 0x02, 0x0d, 0x01, 0xcc, 0x01, 0xeb};
    // for (i = 0, j = 0; i < NUMBER_OF_DYNAMIXELS; i++, j = j + 2)
    // {
    //     uint8_t highByte = default_pos[j];
    //     uint8_t lowByte = default_pos[j+1];
    //     uint8_t crc = (i + 1) + 0x05 + 0x03 + 0x1e + lowByte + highByte;
    //     uint8_t tx[] = {0xff, 0xff, i + 1, 0x05, 0x03, 0x1e, lowByte,
    //                            highByte, ~crc};
    //     dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
    //     dyn_delay(48000000/1000);
    // }
    return;
}

static void dyn_set_speed(uint8_t *speeds)
{
    static const uint8_t DYN_SET_ANGLE_CMD_LEN = 9;
    int i = 0;
    int j = 0;
    for (i = 0, j = 0; i < NUMBER_OF_DYNAMIXELS; i++, j = j + 2)
    {
        uint8_t highByte = speeds[j];
        uint8_t lowByte = speeds[j + 1];
        uint8_t crc = (i + 1) + 0x05 + 0x03 + 0x20 + lowByte + highByte;
        uint8_t tx[] = {0xff, 0xff, i + 1, 0x05, 0x03, 0x20, lowByte,
                               highByte, ~crc};
        dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
        dyn_delay(48000000/1000);
    }
    // uint16_t default_pos[] = {0x01, 0x5a, 0x02, 0x0d, 0x01, 0xcc, 0x01, 0xeb};
    // for (i = 0, j = 0; i < NUMBER_OF_DYNAMIXELS; i++, j = j + 2)
    // {
    //     uint8_t highByte = default_pos[j];
    //     uint8_t lowByte = default_pos[j+1];
    //     uint8_t crc = (i + 1) + 0x05 + 0x03 + 0x1e + lowByte + highByte;
    //     uint8_t tx[] = {0xff, 0xff, i + 1, 0x05, 0x03, 0x1e, lowByte,
    //                            highByte, ~crc};
    //     dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
    //     dyn_delay(48000000/1000);
    // }
    return;
}

static void dyn_disable_torque(void)
{
    // TODO change on reset pin for new board
    // static const uint8_t DYN_DISABLE_TORQUE_CMD_LEN = 8;
    // uint8_t crc = 0xfe + 0x04 + 0x03 + 0x18 + 0x00;
    // uint8_t tx[] = {0xff, 0xff, 0xfe, 0x04, 0x03, 0x18, 0x00,
    //                         ~crc};
    // dyn_send_cmd(tx, DYN_DISABLE_TORQUE_CMD_LEN);
    // dyn_delay(48000000/1000);

    /*
     * Reset power supply with thransistor
     */
    LL_GPIO_ResetOutputPin(DYN_RESET_PORT, DYN_RESET_PIN);
    LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_8);

    return;
}

/*
 * Public commands implementation
 */
void dynamixel_init()
{
    /*
     * Initialization code
     * Setting USART pin
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOA);
    /*
     * USART1_TX_RX setting
     */
    LL_GPIO_SetPinMode(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                       LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetAFPin_8_15(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                          DYNAMIXEL_USART_PIN_AF);
    LL_GPIO_SetPinSpeed(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                        LL_GPIO_SPEED_FREQ_HIGH);
    LL_GPIO_SetPinOutputType(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                             LL_GPIO_OUTPUT_OPENDRAIN);
    /*
     * USART Setting
     */
    LL_APB1_GRP2_EnableClock(LL_APB1_GRP2_PERIPH_USART1);
    LL_USART_SetParity(DYNAMIXEL_USART, DYNAMIXEL_USART_PARITY);
    LL_USART_SetDataWidth(DYNAMIXEL_USART, DYNAMIXEL_USART_DATA_WIDTH);
    LL_USART_SetStopBitsLength(DYNAMIXEL_USART, DYNAMIXEL_USART_STOPBITS);
    LL_USART_SetBaudRate(DYNAMIXEL_USART, SystemCoreClock,
                         DYNAMIXEL_USART_OVERSAMPL,
                         DYNAMIXEL_USART_BAUDRATE);
    LL_USART_EnableHalfDuplex(DYNAMIXEL_USART);
    LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
    LL_USART_EnableDirectionRx(DYNAMIXEL_USART);
    LL_USART_Enable(DYNAMIXEL_USART);
    /*
     * Configure dynamixel reset pin
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOC);
    LL_GPIO_SetPinMode(DYN_RESET_PORT, DYN_RESET_PIN, LL_GPIO_MODE_OUTPUT);
    LL_GPIO_SetPinOutputType(DYN_RESET_PORT, DYN_RESET_PIN,
                             LL_GPIO_OUTPUT_PUSHPULL);
    LL_GPIO_SetOutputPin(DYN_RESET_PORT, DYN_RESET_PIN);
    /*
     * Configure debug led
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOC);
    LL_GPIO_SetPinMode(GPIOC, LL_GPIO_PIN_9, LL_GPIO_MODE_OUTPUT);
    LL_GPIO_SetPinMode(GPIOC, LL_GPIO_PIN_8, LL_GPIO_MODE_OUTPUT);
    LL_GPIO_SetPinOutputType(GPIOC, LL_GPIO_PIN_9, LL_GPIO_OUTPUT_PUSHPULL);
    LL_GPIO_SetPinOutputType(GPIOC, LL_GPIO_PIN_8, LL_GPIO_OUTPUT_PUSHPULL);
    return;
}

void dyn_manager(void *args)
{
    uint8_t *cmd_args = (uint8_t *) args;
    dyn_ctrl_t *dyn_ctrl = (dyn_ctrl_t *) &(cmd_args[1]);

    switch (cmd_args[0]) {
    case 0:
        dyn_set_angle(dyn_ctrl->id, dyn_ctrl->angle);
        break;
    case 1:
        dyn_set_speed(&cmd_args[1]);
        break;
    case 2:
        dyn_disable_torque();
        break;
    case 3:
        dyn_set_init_pos(&cmd_args[1]);
    default:
        break;
    }
    return;
}
