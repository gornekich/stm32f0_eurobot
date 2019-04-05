#include "err_manager.h"
#include "display.h"
#include "xprintf.h"
#include "stm32f0xx_ll_tim.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_bus.h"
#include <stdlib.h>
#include <string.h>
#include "peripheral.h"

/*
 * Private variable for err_manager control
 */
static err_ctrl_t err_ctrl;

static void tim_init(void)
{
    /*
     * Setup timer
     */
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_TIM2);
    LL_TIM_SetPrescaler(ERROR_MAN_TIM, ERROR_MAN_TIM_PSC);
    LL_TIM_SetAutoReload(ERROR_MAN_TIM, ERROR_MAN_TIM_RELOAD);
    LL_TIM_SetCounterMode(ERROR_MAN_TIM, ERROR_MAN_TIM_MODE);
    LL_TIM_EnableIT_UPDATE(ERROR_MAN_TIM);
    LL_TIM_EnableCounter(ERROR_MAN_TIM);
    /*
     * Setup NVIC
     */
    NVIC_EnableIRQ(ERROR_MAN_TIM_IRQN);
    NVIC_SetPriority(ERROR_MAN_TIM_IRQN, ERROR_MAN_TIM_IRQN_PRIORITY);
    return;
}

/*
 * Private function for displaying errors
 */
void err_man_show_err(void)
{
    int i = 0;

    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        disp_set_cursor((i % 2) * 7, i >> 1);
        if (err_ctrl.col_av_dist[i] == 255){
            xprintf("%d:-", i);
        }
        else {
            xprintf("%d:%d", i, err_ctrl.col_av_dist[i]);
        }
    }
    disp_update();
    return;
}

/*
 * Public function for storing distance
 */
void err_man_set_dist(uint8_t *dist, uint8_t len)
{
    for (int i = 0; i < len; ++i) {
        err_ctrl.col_av_dist[i] = dist[i];
    }
    //memcpy(err_ctrl.col_av_dist, dist, len);
    return;
}

/*
 * Display initialization
 */
void err_man_init(void)
{
    err_ctrl.col_av_err_flags = 0x00;
    disp_init();
    tim_init();
    err_man_show_err();
}

uint8_t er_man_disp_get(void)
{
    return err_ctrl.disp_update;
}

void er_man_disp_set(void)
{
    err_ctrl.disp_update = 1;
    return;
}

void er_man_disp_clr(void)
{
    err_ctrl.disp_update = 0;
    return;
}

/*
 * Set flag for display update
 */
void TIM3_IRQHandler(void)
{
    er_man_disp_set();
    LL_TIM_ClearFlag_UPDATE(ERROR_MAN_TIM);
}
