#include "stm32f0xx_ll_bus.h"
#include "stm32f0xx_ll_gpio.h"
#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_system.h"

#include "terminal.h"
#include "err_manager.h"
#include "coll_avoid.h"
#include "dynamixel.h"

static int tick = 0;

/**
  * System Clock Configuration
  * The system Clock is configured as follow :
  *    System Clock source            = PLL (HSI/2)
  *    SYSCLK(Hz)                     = 48000000
  *    HCLK(Hz)                       = 48000000
  *    AHB Prescaler                  = 1
  *    APB1 Prescaler                 = 1
  *    HSI Frequency(Hz)              = 8000000
  *    PLLMUL                         = 12
  *    Flash Latency(WS)              = 1
  */
static void rcc_config(void)
{
    /* Set FLASH latency */
    LL_FLASH_SetLatency(LL_FLASH_LATENCY_1);

    /* Enable HSI and wait for activation*/
    LL_RCC_HSI_Enable();
    while (LL_RCC_HSI_IsReady() != 1);

    /* Main PLL configuration and activation */
    LL_RCC_PLL_ConfigDomain_SYS(LL_RCC_PLLSOURCE_HSI_DIV_2,
                                LL_RCC_PLL_MUL_12);

    LL_RCC_PLL_Enable();
    while (LL_RCC_PLL_IsReady() != 1);

    /* Sysclk activation on the main PLL */
    LL_RCC_SetAHBPrescaler(LL_RCC_SYSCLK_DIV_1);
    LL_RCC_SetSysClkSource(LL_RCC_SYS_CLKSOURCE_PLL);
    while (LL_RCC_GetSysClkSource() != LL_RCC_SYS_CLKSOURCE_STATUS_PLL);

    /* Set APB1 prescaler */
    LL_RCC_SetAPB1Prescaler(LL_RCC_APB1_DIV_1);

    /* Set systick to 1ms */
    SysTick_Config(48000000/1000);

    /* Update CMSIS variable (which can be updated also
     * through SystemCoreClockUpdate function) */
    SystemCoreClock = 48000000;
}

void SysTick_Handler(void) {
    tick = (tick + 1) % 10000;
}

int main(void)
{
    // uint8_t cur_id = 0;
    int cur_tick = 0;
    int new_tick = 0;
    int time = 0;
    int step = 0;

    rcc_config();
    term_init();
    dynamixel_init();
    coll_avoid_init();
    err_man_init();

    /*
     * On every INTERRESET_TIME iteration check if it is possible
     * to reload all sensors if there is an error
     * The introduction if INTERRESET_TIME is requied to decrease
     * the number of blocks of timer handler thus allowing non-faulty
     * sensors to work
     */
    while (1) {
        if (col_av_read_status()) {
            step = (step + 1) % INTERRESET_TIME;
            if (step)// && !col_av_blackout())
                continue;
            step = 0;
            col_av_set_block();
            while (!col_av_get_ack_block());
            cur_tick = tick;
            reload_sensors();
            new_tick = tick;
            time = new_tick >= cur_tick ? new_tick - cur_tick :
                                         10000 + new_tick - cur_tick;
            err_man_set_time(time);
            col_av_set_status(col_av_any());
            col_av_clr_block();
        }
        if (er_man_disp_get()) {
            err_man_show_err();
            er_man_disp_clr();
        }
    }
    return 0;
}
