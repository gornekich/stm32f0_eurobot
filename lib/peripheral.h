#ifndef _PERIPHERIAL_H
#define _PERIPHERIAL_H

#include "stm32f051x8.h"

/*
 * Communication with stm UART configuration
 */
#define TERM_USART                      USART2
#define TERM_USART_IRQN                 USART2_IRQn
#define TERM_USART_IRQN_PRIORITY        1
#define TERM_USART_PERIPH_PRESCALER     2
#define TERM_USART_BAUDRATE             500000
#define TERM_USART_DATA_WIDTH           LL_USART_DATAWIDTH_8B
#define TERM_USART_HAWDWARE_FLOAT_CNTRL LL_USART_HWCONTROL_NONE
#define TERM_USART_OVERSAMPL            LL_USART_OVERSAMPLING_16
#define TERM_USART_PARITY               LL_USART_PARITY_NONE
#define TERM_USART_STOPBITS             LL_USART_STOPBITS_1
#define TERM_USART_TRANSFER_DIRECTION   LL_USART_DIRECTION_TX_RX

/*
 * Communication with stm DMA configuration
 */
#define TERM_DMA                        DMA1
#define TERM_DMA_CHANNEL                LL_DMA_CHANNEL_5
#define TERM_DMA_CHANNEL_IRQN           DMA1_Channel4_5_IRQn
#define TERM_DMA_CHANNEL_IRQN_PRIORITY  2
#define TERM_DMA_DIRECTION              LL_DMA_DIRECTION_PERIPH_TO_MEMORY
#define TERM_DMA_BUFFER_SIZE            10
#define TERM_DMA_MEM_INC_MODE           LL_DMA_MEMORY_INCREMENT
#define TERM_DMA_SRC_ADDR               (uint32_t)&((TERM_USART)->RDR)

#endif //_PERIPHERIAL_H
