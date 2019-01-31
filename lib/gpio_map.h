#ifndef _GPIO_MAP_H
#define _GPIO_MAP_H

#include "stm32f051x8.h"
#include "stm32f0xx_ll_gpio.h"

/*
 * Communication with stm
 * UART1 pinout
 */
#define TERM_USART_TX_PORT                  GPIOA
#define TERM_USART_TX_PIN                   LL_GPIO_PIN_2
#define TERM_USART_RX_PORT                  GPIOA
#define TERM_USART_RX_PIN                   LL_GPIO_PIN_3
#define TERM_USART_PIN_AF                   LL_GPIO_AF_1

/*
 * Communication with dynamixel
 * UART2 onewire pinout
 */
#define DYNAMIXEL_USART_PORT                GPIOA
#define DYNAMIXEL_USART_PIN                 LL_GPIO_PIN_9
#define DYNAMIXEL_USART_PIN_AF              LL_GPIO_AF_1

/*
 * Display pins
 */
#define DISP_RESET_PORT                     GPIOC
#define DISP_RESET_PIN                      LL_GPIO_PIN_4
#define DISP_DC_PORT                        GPIOC
#define DISP_DC_PIN                         LL_GPIO_PIN_5
#define DISP_SCK_PORT                       GPIOA
#define DISP_SCK_PIN                        LL_GPIO_PIN_5
#define DISP_MOSI_PORT                      GPIOA
#define DISP_MOSI_PIN                       LL_GPIO_PIN_7

/*
 * Proximity sensors pins and I2C bus
 */
#define COL_AV_XSHUT_PORT                   GPIOC
#define COL_AV_XSHUT_PIN1                   LL_GPIO_PIN_0
#define COL_AV_XSHUT_PIN2                   LL_GPIO_PIN_1
#define COL_AV_XSHUT_PIN3                   LL_GPIO_PIN_2
#define COL_AV_XSHUT_PIN4                   LL_GPIO_PIN_3
#define COL_AV_XSHUT_PIN5                   LL_GPIO_PIN_6
#define COL_AV_XSHUT_PIN6                   LL_GPIO_PIN_7

#define COL_AV_INT_PORT                     GPIOB
#define COL_AV_INT_PIN1                     LL_GPIO_PIN_0
#define COL_AV_INT_PIN2                     LL_GPIO_PIN_1
#define COL_AV_INT_PIN3                     LL_GPIO_PIN_2
#define COL_AV_INT_PIN4                     LL_GPIO_PIN_3
#define COL_AV_INT_PIN5                     LL_GPIO_PIN_4
#define COL_AV_INT_PIN6                     LL_GPIO_PIN_5

#define COL_AV_I2C_PORT                     GPIOB
#define COL_AV_I2C_SCL                      LL_GPIO_PIN_6
#define COL_AV_I2C_SDA                      LL_GPIO_PIN_7

#endif //_GPIO_MAP_H
