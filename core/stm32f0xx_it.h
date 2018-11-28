#ifndef __STM32F4xx_IT_H
#define __STM32F4xx_IT_H

#include "stm32f0xx.h"

void NMI_Handler(void);
void HardFault_Handler(void);
void SVC_Handler(void);
void PendSV_Handler(void);
void SysTick_Handler(void);

#endif 
