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
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_TIM3);
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

void err_man_show_err(void)
{
    int i = 0;

    disp_fill(BLACK);
    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        disp_set_cursor((i % 2) * 7, i >> 1);
        if (err_ctrl.col_av_dist[i] == 255){
            xprintf("%d:-", i);
        }
        else {
            xprintf("%d:%d", i, err_ctrl.col_av_dist[i]);
        }
    }
    disp_set_cursor(0, 3);
    xprintf("#sns br %d: ", err_ctrl.broken_num);
    for (int i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
        if (err_ctrl.col_av_status[i] == 1)
            xprintf("%d ", i);
    }
    disp_set_cursor(0, 4);
    xprintf("total reloads: %d", err_ctrl.col_av_err_num);
    disp_set_cursor(0, 5);
    xprintf("reload time:%d", err_ctrl.reset_time);
    disp_update();
    return;
}

void err_man_set_time(int time)
{
    err_ctrl.reset_time = time;
}

/*
 * Public function for storing distance
 */
void err_man_set_dist(uint8_t *dist, uint8_t len)
{
    memcpy(err_ctrl.col_av_dist, dist, len);
    return;
}

/*
 * Display initialization
 */
void err_man_init(void)
{
    err_ctrl.col_av_err_num = 0;
    err_ctrl.disp_update = 0;
    err_ctrl.reset_time = 0;
    err_ctrl.reset_id = 0;
    disp_init();
    tim_init();
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

void er_man_add_err(uint8_t *status, uint8_t broken)
{
    memcpy(err_ctrl.col_av_status, status, NUMBER_OF_PROX_SENSORS);
    err_ctrl.broken_num = broken;
    if (broken)
        err_ctrl.col_av_err_num++;
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
