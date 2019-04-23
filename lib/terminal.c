#include "terminal.h"
#include "peripheral.h"
#include "gpio_map.h"
#include "dynamixel.h"

#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_bus.h"

#include <string.h>

/*
 * Private control structure
 */
static term_ctrl_t term_ctrl;

/*
 * Init all periphs related to terminal communication, like
 * UART and all static structures related
 */
void term_init(void)
{
    /*
     * Setting USART pins
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOA);
    LL_GPIO_SetPinMode(TERM_USART_TX_PORT, TERM_USART_TX_PIN,
                       LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetAFPin_0_7(TERM_USART_TX_PORT, TERM_USART_TX_PIN,
                          TERM_USART_PIN_AF);
    LL_GPIO_SetPinOutputType(TERM_USART_TX_PORT, TERM_USART_TX_PIN,
                              LL_GPIO_OUTPUT_PUSHPULL);
    LL_GPIO_SetPinPull(TERM_USART_TX_PORT, TERM_USART_TX_PIN,
                       LL_GPIO_PULL_DOWN);
    LL_GPIO_SetPinSpeed(TERM_USART_TX_PORT, TERM_USART_TX_PIN,
                        LL_GPIO_SPEED_FREQ_HIGH);

    LL_GPIO_SetPinMode(TERM_USART_RX_PORT, TERM_USART_RX_PIN,
                       LL_GPIO_MODE_ALTERNATE);
    LL_GPIO_SetAFPin_0_7(TERM_USART_RX_PORT, TERM_USART_RX_PIN,
                          TERM_USART_PIN_AF);
    LL_GPIO_SetPinPull(TERM_USART_RX_PORT, TERM_USART_RX_PIN,
                       LL_GPIO_PULL_NO);
    LL_GPIO_SetPinSpeed(TERM_USART_RX_PORT, TERM_USART_RX_PIN,
                        LL_GPIO_SPEED_FREQ_HIGH);
    /*
     * USART Set clock source
     */
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_USART2);
    /*
     * USART Setting
     */
    LL_USART_SetTransferDirection(TERM_USART,
                                  TERM_USART_TRANSFER_DIRECTION);
    LL_USART_SetParity(TERM_USART, TERM_USART_PARITY);
    LL_USART_SetDataWidth(TERM_USART, TERM_USART_DATA_WIDTH);
    LL_USART_SetStopBitsLength(TERM_USART, TERM_USART_STOPBITS);
    LL_USART_SetBaudRate(TERM_USART, SystemCoreClock,
                         TERM_USART_OVERSAMPL, TERM_USART_BAUDRATE);
    LL_USART_EnableDMAReq_RX(TERM_USART);
    /*
     * DMA configuration
     */
    LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_DMA1);
    LL_DMA_ConfigAddresses(TERM_DMA, TERM_DMA_CHANNEL,
                           TERM_DMA_SRC_ADDR, (uint32_t)(term_ctrl.channel),
                           TERM_DMA_DIRECTION);
    LL_DMA_SetDataLength(TERM_DMA, TERM_DMA_CHANNEL,
                         TERM_DMA_BUFFER_SIZE);
    LL_DMA_SetMemoryIncMode(TERM_DMA, TERM_DMA_CHANNEL,
                            TERM_DMA_MEM_INC_MODE);
    LL_DMA_SetMode(TERM_DMA, TERM_DMA_CHANNEL, LL_DMA_MODE_CIRCULAR);
    LL_DMA_EnableIT_TC(TERM_DMA, TERM_DMA_CHANNEL);
    /*
     * NVIC configuration
     */
    NVIC_SetPriority(TERM_DMA_CHANNEL_IRQN,
                     TERM_DMA_CHANNEL_IRQN_PRIORITY);
    NVIC_EnableIRQ(TERM_DMA_CHANNEL_IRQN);
    /*
     * USART and DMA turn on
     */
    LL_USART_Enable(TERM_USART);
    LL_DMA_EnableChannel(TERM_DMA, TERM_DMA_CHANNEL);
    return;
}

void comm_send_msg(uint8_t *buff, int len)
{
    int i = 0;

    LL_USART_ClearFlag_TC(TERM_USART);
    while (len--) {
        while (!LL_USART_IsActiveFlag_TXE(TERM_USART));
        LL_USART_TransmitData8(TERM_USART, buff[i++]);
    }
    while (!LL_USART_IsActiveFlag_TC(TERM_USART));
    return;
}

/*
 * DMA hardware interrupt handler
 */
void DMA1_Channel4_5_IRQHandler(void)
{
    NVIC_DisableIRQ(TIM2_IRQn);
    NVIC_DisableIRQ(TIM3_IRQn);
    if (LL_DMA_IsActiveFlag_TC5(TERM_DMA)) {
        LL_DMA_ClearFlag_TC5(TERM_DMA);
        memcpy(term_ctrl.params, term_ctrl.channel, TERM_CMD_LENGTH);
        dyn_manager((void *)term_ctrl.params);
    }
    NVIC_EnableIRQ(TIM2_IRQn);
    NVIC_EnableIRQ(TIM3_IRQn);    
}
