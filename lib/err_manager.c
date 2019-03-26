#include "err_manager.h"
#include "fsm.h"
#include "display.h"
#include "xprintf.h"
#include "stm32f0xx_ll_tim.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"
#include "stm32f0xx_ll_bus.h"
#include <stdlib.h>
#include "terminal.h"

/*
 * Private variable for err_manager control
 */
static err_ctrl_t err_ctrl;

/*
 * Private function for displaying errors
 */
static void err_man_show_err(void)
{
    int i = 0;

    disp_set_cursor(0, 0);
    xprintf("     |1|2|3|4|5|6");
    disp_set_cursor(0, 1);
    xprintf("dyn  |%d|%d|%d|%d|%d|%d", get_err_flag(err_ctrl.dyn_err_flags, 0),
                                       get_err_flag(err_ctrl.dyn_err_flags, 1),
                                       get_err_flag(err_ctrl.dyn_err_flags, 2),
                                       get_err_flag(err_ctrl.dyn_err_flags, 3),
                                       get_err_flag(err_ctrl.dyn_err_flags, 4),
                                       get_err_flag(err_ctrl.dyn_err_flags, 5));
    disp_set_cursor(0, 2);
    xprintf("col  |%d|%d|%d|%d|%d|%d", get_err_flag(err_ctrl.col_av_err_flags, 0),
                                       get_err_flag(err_ctrl.col_av_err_flags, 1),
                                       get_err_flag(err_ctrl.col_av_err_flags, 2),
                                       get_err_flag(err_ctrl.col_av_err_flags, 3),
                                       get_err_flag(err_ctrl.col_av_err_flags, 4),
                                       get_err_flag(err_ctrl.col_av_err_flags, 5));
    disp_set_cursor(0, 3);
    xprintf("-----------------");
    if (err_ctrl.dyn_err_flags) {
        for (i = 0 ;i < NUMBER_OF_DYNAMIXELS ;i++) {
            if (get_err_flag(err_ctrl.dyn_err_flags, i)){
                disp_set_cursor(0, 4);
                xprintf("dyn %d  error: %d",
                        i, err_ctrl.dyn_err_status[i]);
            }
        }
    }
    if (err_ctrl.col_av_err_flags) {
        for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++) {
            if (get_err_flag(err_ctrl.col_av_err_flags, i)){
                disp_set_cursor(0, 5);
                xprintf("col %d  error: %d",
                        i, err_ctrl.col_av_err_status[i]);
            }
        }
    }
    if (err_ctrl.disp_update == 1) {
        disp_update();
        err_ctrl.disp_update = 0;
    }
    return;
}

/*
 * Public functions for updating dynamixel errors
 */
void err_man_update_dyn_status(uint8_t id, uint8_t status)
{
    add_err_flag(err_ctrl.dyn_err_flags, id, status);
    err_ctrl.dyn_err_status[id] = status;
    return;
}

/*
 * Public functions for updating collision avoidance errors
 */
void err_man_update_col_av_status(uint8_t id, uint8_t status)
{
    add_err_flag(err_ctrl.col_av_err_flags, id, status);
    err_ctrl.col_av_err_status[id] = status;
    return;
}

/*
 * Public function for storing distance
 */
void err_man_set_dist(uint8_t id, uint8_t dist)
{
    err_ctrl.col_av_dist[id] = dist;
    return;
}

/*
 * Configure timer to counter mode
 */
static void tim_init(void)
{
    /*
     * Setup timer
     */
    LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_TIM2);
    LL_TIM_SetPrescaler(TIM2, 47999);
    LL_TIM_SetAutoReload(TIM2, 99);
    LL_TIM_SetCounterMode(TIM2, LL_TIM_COUNTERMODE_UP);
    LL_TIM_EnableIT_UPDATE(TIM2);
    LL_TIM_EnableCounter(TIM2);
    /*
     * Setup NVIC
     */
    NVIC_EnableIRQ(TIM2_IRQn);
    NVIC_SetPriority(TIM2_IRQn, 0);
    return;
}
/*
 * FSM functions implementation
 */

/*
 * Display initialization
 */
void fsm_err_man_init(void *args)
{
    (void) args;
    int i = 0;

    err_ctrl.dyn_err_flags = 0x00;
    err_ctrl.col_av_err_flags = 0x00;
    for (i = 0; i < NUMBER_OF_DYNAMIXELS; i++)
        err_ctrl.dyn_err_status[i] = 0x00;
    for (i = 0; i < NUMBER_OF_PROX_SENSORS; i++)
        err_ctrl.col_av_err_status[i] = 0x00;
    disp_init();
    tim_init();
    err_man_show_err();
    fsm_set_state(FSM_TERM_INIT);
}

/*
 * Displaying current errors function
 */
void fsm_err_man_show_err(void *args)
{
    (void) args;

    err_man_show_err();
    if (err_ctrl.disp_update == 1)
        fsm_set_data(FSM_TERM_MAIN, NULL);
    fsm_set_state(FSM_TERM_MAIN);
}

/*
 * Set flag for display update
 */
void TIM2_IRQHandler(void)
{
    err_ctrl.disp_update = 1;
    comm_send_msg(err_ctrl.col_av_dist, NUMBER_OF_PROX_SENSORS);
    LL_TIM_ClearFlag_UPDATE(TIM2);
}
