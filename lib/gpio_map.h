#ifndef _GPIO_MAP_H
#define _GPIO_MAP_H

#include "stm32f051x8.h"
#include "stm32f0xx_ll_gpio.h"

/*
 * Communication with stm UART1 pinout
 */
#define TERM_USART_TX_PORT                  GPIOA
#define TERM_USART_TX_PIN                   LL_GPIO_PIN_2
#define TERM_USART_RX_PORT                  GPIOA
#define TERM_USART_RX_PIN                   LL_GPIO_PIN_3
#define TERM_USART_PIN_AF                   LL_GPIO_AF_1

/*
 * Communication with dynamixel 
 */

#endif //_GPIO_MAP_H
