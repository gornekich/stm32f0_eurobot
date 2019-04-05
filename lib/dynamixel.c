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

static void dyn_set_speed(uint8_t id, uint16_t speed)
{
        /*
         * Make new packet
         */
        static const uint8_t DYN_SET_ANGLE_CMD_LEN = 9;
        uint8_t highByte = (uint8_t)((speed >> 8) & 0xff);
        uint8_t lowByte = (uint8_t)(speed & 0xff);
        uint8_t crc = id + 0x05 + 0x03 + 0x20 + lowByte + highByte;
        uint8_t tx[] = {0xff, 0xff, id, 0x05, 0x03, 0x20, lowByte,
                               highByte, ~crc};

        dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
        dyn_delay(48000000/1000);
        return;
}

static void dyn_disable_torque(void)
{
        static const uint8_t DYN_DISABLE_TORQUE_CMD_LEN = 8;
        uint8_t crc = (0xfe + 0x04 + 0x03 + 0x18 + 0x00) % 0xff;
        uint8_t tx[] = {0xff, 0xff, 0xfe, 0x04, 0x03, 0x18, 0x00,
                                ~crc};
        dyn_send_cmd(tx, DYN_DISABLE_TORQUE_CMD_LEN);
        dyn_delay(48000000/1000);
        return;
}

/*
 * Public commands implementation
 */
void dynamixel_init(void *args)
{
        (void) args;
        //int i = 0;

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
        LL_USART_EnableDMAReq_RX(DYNAMIXEL_USART);
        LL_USART_EnableHalfDuplex(DYNAMIXEL_USART);
        LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
        LL_USART_EnableDirectionRx(DYNAMIXEL_USART);
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

void dyn_set_angle(void *args)
{
        /*
         * Make new packet
         */
        static const uint8_t DYN_SET_ANGLE_CMD_LEN = 9;
        dyn_set_angle_t *cmd_args = (dyn_set_angle_t *) args;
        uint8_t highByte = (uint8_t)((cmd_args->angle >> 8) & 0xff);
        uint8_t lowByte = (uint8_t)(cmd_args->angle & 0xff);
        uint8_t crc = cmd_args->id + 0x05 + 0x03 + 0x1e + lowByte + highByte;
        uint8_t tx[] = {0xff, 0xff, cmd_args->id, 0x05, 0x03, 0x1e, lowByte,
                               highByte, ~crc};

        if (cmd_args->id == 255 && cmd_args->angle == 0){
                dyn_disable_torque();
                LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_8);
                return;
        }

        if (cmd_args->angle > DYN_MAX_ANGLE)
                return;
        
        LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_9);
        if (cmd_args->speed != 0)
            dyn_set_speed(cmd_args->id, cmd_args->speed);
        dyn_send_cmd(tx, DYN_SET_ANGLE_CMD_LEN);
        return;
}
