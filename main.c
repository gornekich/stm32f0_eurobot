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
        tick++;
        if (tick == 10000) {
                //LL_GPIO_TogglePin(GPIOC, LL_GPIO_PIN_8);
                tick = 0;
        }
}

int main(void)
{
    uint8_t col_av_status = 0;
    // uint8_t cur_id = 0;
    uint8_t err_man_status;
    int cur_tick = 0;
    int time = 0;

    rcc_config();
    term_init();
    dynamixel_init();
    coll_avoid_init();
    err_man_init();
    
    // cur_tick = tick;
    // reset_sensor(0);
    // time = tick > cur_tick ? tick - cur_tick : 10000 + tick - cur_tick;
    // err_show_time(time);
    while (1) {
        col_av_status = col_av_read_status();
        if (col_av_status) {
            col_av_set_block();
            cur_tick = tick;
            // reset_sensors();
            // reset_sensor(cur_id);
            reload_sensors();
            time = tick > cur_tick ? tick - cur_tick : 10000 + tick - cur_tick;
            err_man_set_time(time);
            // col_av_clr_status(cur_id);
            col_av_clr_full_status();
            col_av_clr_block();
            // cur_id = 0;
        }
        err_man_status = er_man_disp_get();
        if (err_man_status) {
            err_man_show_err();
            er_man_disp_clr();
        }
    }
    return 0;
}
