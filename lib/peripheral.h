#ifndef _PERIPHERIAL_H
#define _PERIPHERIAL_H

#include "stm32f051x8.h"
#include "stm32f0xx_ll_usart.h"
#include "stm32f0xx_ll_dma.h"
#include "stm32f0xx_ll_spi.h"
#include "stm32f0xx_ll_tim.h"

/*
 * Communication with stm UART configuration
 */
#define TERM_USART                              USART2
#define TERM_USART_IRQN                         USART2_IRQn
#define TERM_USART_IRQN_PRIORITY                1
#define TERM_USART_PERIPH_PRESCALER             2
#define TERM_USART_BAUDRATE                     115200
#define TERM_USART_DATA_WIDTH                   LL_USART_DATAWIDTH_8B
#define TERM_USART_HAWDWARE_FLOAT_CNTRL         LL_USART_HWCONTROL_NONE
#define TERM_USART_OVERSAMPL                    LL_USART_OVERSAMPLING_16
#define TERM_USART_PARITY                       LL_USART_PARITY_NONE
#define TERM_USART_STOPBITS                     LL_USART_STOPBITS_1
#define TERM_USART_TRANSFER_DIRECTION           LL_USART_DIRECTION_TX_RX
/*
 * Communication with stm DMA configuration
 */
#define TERM_DMA                                DMA1
#define TERM_DMA_CHANNEL                        LL_DMA_CHANNEL_5
#define TERM_DMA_CHANNEL_IRQN                   DMA1_Channel4_5_IRQn
#define TERM_DMA_CHANNEL_IRQN_PRIORITY          2
#define TERM_DMA_DIRECTION                      LL_DMA_DIRECTION_PERIPH_TO_MEMORY
#define TERM_DMA_BUFFER_SIZE                    10
#define TERM_DMA_MEM_INC_MODE                   LL_DMA_MEMORY_INCREMENT
#define TERM_DMA_SRC_ADDR                       (uint32_t)&((TERM_USART)->RDR)

/*
 * Communication with dynamixels UART configuration
 */
#define DYNAMIXEL_USART                         USART1
#define DYNAMIXEL_USART_IRQN                    USART1_IRQn
#define DYNAMIXEL_USART_IRQN_PRIORITY           1
#define DYNAMIXEL_USART_PERIPH_PRESCALER        2
#define DYNAMIXEL_USART_BAUDRATE                1000000
#define DYNAMIXEL_USART_DATA_WIDTH              LL_USART_DATAWIDTH_8B
#define DYNAMIXEL_USART_HAWDWARE_FLOAT_CNTRL    LL_USART_HWCONTROL_NONE
#define DYNAMIXEL_USART_OVERSAMPL               LL_USART_OVERSAMPLING_16
#define DYNAMIXEL_USART_PARITY                  LL_USART_PARITY_NONE
#define DYNAMIXEL_USART_STOPBITS                LL_USART_STOPBITS_1
#define DYNAMIXEL_USART_TRANSFER_DIRECTION      LL_USART_DIRECTION_TX_RX

/*
 * Communication with dynamixels RX DMA configuration
 */
#define DYNAMIXEL_DMA_RX                        DMA1
#define DYNAMIXEL_DMA_RX_CHANNEL                LL_DMA_CHANNEL_3
#define DYNAMIXEL_DMA_RX_DIRECTION              LL_DMA_DIRECTION_PERIPH_TO_MEMORY
#define DYNAMIXEL_DMA_RX_BUFFER_SIZE            6
#define DYNAMIXEL_DMA_RX_MEM_INC_MODE           LL_DMA_MEMORY_INCREMENT
#define DYNAMIXEL_DMA_RX_DEST_ADDR              (uint32_t)&((DYNAMIXEL_USART)->RDR)
#define DYNAMIXEL_DMA_RX_PERIPH_INC_MODE        LL_DMA_PERIPH_NOINCREMENT
#define DYNAMIXEL_DMA_CHANNEL_IRQN              DMA1_Channel2_3_IRQn
#define DYNAMIXEL_DMA_CHANNEL_IRQN_PRIORITY     2

/*
 * Timer for dynamixel error catcher
 */
#define DYNAMIXEL_TIMER                         TIM3
#define DYNAMIXEL_TIMER_MODE                    LL_TIM_COUNTERMODE_UP
#define DYNAMIXEL_TIMER_PSC                     47999
#define DYNAMIXEL_TIMER_RELOAD                  10000
#define DYNAMIXEL_TIMER_IRQN                    TIM3_IRQn
#define DYNAMIXEL_TIMER_IRQN_PRIORITY           2

/*
 * Display control
 */
#define DISP_SPI                                SPI1
#define DISP_SPI_BAUDRATE_PRESCALER             LL_SPI_BAUDRATEPRESCALER_DIV2
#define DISP_SPI_MODE                           LL_SPI_MODE_MASTER
#define DISP_SPI_BIT_ORDER                      LL_SPI_MSB_FIRST
#define DISP_SPI_TRANSFER_DIR                   LL_SPI_FULL_DUPLEX
#define DISP_SPI_DATA_WIDTH                     LL_SPI_DATAWIDTH_8BIT

/*
 * Proximity sensors I2C bus
 * 100 KHz data communication, Fclk = 48 MHz
 * PRESC = 0xB, SCLL = 0x13, SCLH = 0xF, SDADEL = 0x2, SCLDEL = 0x4
 */
#define COL_AV_I2C                              I2C1
#define COL_AV_I2C_ADDR_MODE                    LL_I2C_ADDRESSING_MODE_7BIT
#define COL_AV_I2C_MODE                         LL_I2C_MODE_I2C
#define COL_AV_I2C_TIMING                       0xB0420F13

#endif //_PERIPHERIAL_H
