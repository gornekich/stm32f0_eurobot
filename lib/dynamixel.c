#include "dynamixel.h"
#include "fsm.h"
#include "gpio_map.h"
#include "peripheral.h"

#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_usart.h"
#include "stm32f0xx_ll_dma.h"
/*
 * Private control structure
 */
static dyn_ctrl_t dyn_ctrl;

/*
 * Private functions
 */
static void dyn_send_cmd(uint8_t *buff, int len)
{
        int i = 0;

        LL_USART_EnableDirectionTx(DYNAMIXEL_USART);
        LL_USART_ClearFlag_TC(DYNAMIXEL_USART);
        while (len--) {
                while (!LL_USART_IsActiveFlag_TXE(DYNAMIXEL_USART));
                LL_USART_TransmitData8(DYNAMIXEL_USART, buff[i++]);
        }
        while (!LL_USART_IsActiveFlag_TC(DYNAMIXEL_USART));
        LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
        LL_USART_EnableDirectionRx(DYNAMIXEL_USART);
        dyn_ctrl.rx_complete = 0;
        return;
}

/*
 * This function should check UART RX buffer (i.e. check
 * dynamixel answers) and report about problem ASAP
 * Note: you may use fsm_set_state to switch to the next state
 * in context of shadow runtime. It would be better to create some
 * shared static structures to operate with motors and lock them once
 * error happened.
 */
void fsm_dynamixel_error_catch(void *args)
{
        (void) args;

        /*
         * Check for errors here
         */
        return;
}

/*
 * Here we need to initialize all hardware related to dynamixel, like
 * single-wire UART, DMA.
 * Note: do not make this subroutine too big, split config into several parts
 * to be called
 */
void fsm_dynamixel_init(void *args)
{
        (void) args;

        fsm_add_shadow_state(FSM_DYNAMIXEL_ERROR_CATCH);
        /*
         * Initialization code
         */

        /*
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
        LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
        LL_USART_EnableHalfDuplex(DYNAMIXEL_USART);
        LL_USART_EnableDMAReq_RX(DYNAMIXEL_USART);
        /*
         * DMA RX configuration
         */
        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_DMA1);
        LL_DMA_ConfigAddresses(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                               DYNAMIXEL_DMA_RX_DEST_ADDR,
                               (uint32_t) dyn_ctrl.channel_rx,
                               DYNAMIXEL_DMA_RX_DIRECTION);
        LL_DMA_SetDataLength(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                             DYNAMIXEL_DMA_RX_BUFFER_SIZE);
        LL_DMA_SetMemoryIncMode(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                                DYNAMIXEL_DMA_RX_MEM_INC_MODE);
        LL_DMA_EnableIT_TC(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL);
        /*
         * DMA TX configuration
         */
        // LL_DMA_ConfigAddresses(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL,
        //                        (uint32_t) dyn_ctrl.channel_tx,
        //                        DYNAMIXEL_DMA_RX_DEST_ADDR,
        //                        DYNAMIXEL_DMA_TX_DIRECTION);
        // LL_DMA_SetDataLength(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL,
        //                      DYNAMIXEL_DMA_TX_BUFFER_SIZE);
        // LL_DMA_SetPeriphSize(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL,
        //                      LL_DMA_PDATAALIGN_BYTE);
        // LL_DMA_SetMemoryIncMode(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL,
        //                         DYNAMIXEL_DMA_TX_MEM_INC_MODE);
        // LL_DMA_SetPeriphIncMode(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL,
        //                         DYNAMIXEL_DMA_RX_PERIPH_INC_MODE);
        // LL_DMA_EnableIT_TC(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL);
        /*
         * USART and DMA turn on
         */
        LL_USART_Enable(DYNAMIXEL_USART);
        LL_DMA_EnableChannel(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL);
        //LL_DMA_EnableChannel(DYNAMIXEL_DMA_TX, DYNAMIXEL_DMA_TX_CHANNEL);
        /* 
         * Enable global USART and DMA stream interrupts
         */
        NVIC_SetPriority(DYNAMIXEL_USART_IRQN, DYNAMIXEL_USART_IRQN_PRIORITY);
        NVIC_EnableIRQ(DYNAMIXEL_USART_IRQN);
        NVIC_SetPriority(DYNAMIXEL_DMA_CHANNEL_IRQN,
                         DYNAMIXEL_DMA_CHANNEL_IRQN_PRIORITY);
        NVIC_EnableIRQ(DYNAMIXEL_DMA_CHANNEL_IRQN);

        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOC);
        LL_GPIO_SetPinMode(GPIOC, LL_GPIO_PIN_9, LL_GPIO_MODE_OUTPUT);
        LL_GPIO_SetPinOutputType(GPIOC, LL_GPIO_PIN_9, LL_GPIO_OUTPUT_PUSHPULL);

        dyn_ctrl.rx_complete = 0;

        /*
         * Switch to init terminal
         */
        fsm_set_state(FSM_COLL_AVOID_INIT);
        return;
}

/*
 * Terminal comands implementation
 */
void fsm_set_angle(void *args)
{
        dyn_set_angle_t *cmd_args = (dyn_set_angle_t *) args;
        if (cmd_args->angle > 0x3fff)
                return;
        uint8_t highByte = (uint8_t)((cmd_args->angle >> 8) & 0xff);
        uint8_t lowByte = (uint8_t)(cmd_args->angle & 0xff);
        uint8_t crc = cmd_args->id + 0x05 + 0x03 + 0x1e + lowByte + highByte;
        uint8_t tx[] = {0xff, 0xff, cmd_args->id, 0x05, 0x03, 0x1e, lowByte,
                               highByte, ~crc};
        dyn_send_cmd(tx, 9);
        return;
}

void DMA1_Channel2_3_IRQHandler(void)
{
        if (LL_DMA_IsActiveFlag_TC3(DYNAMIXEL_DMA_RX)) {
                LL_DMA_ClearFlag_TC3(DYNAMIXEL_DMA_RX);
                LL_DMA_ClearFlag_HT3(DYNAMIXEL_DMA_RX);
                LL_DMA_EnableChannel(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL);
                dyn_ctrl.rx_complete = 1;
        }
}
