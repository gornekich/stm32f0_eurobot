#include "dynamixel.h"
#include "fsm.h"
#include "gpio_map.h"
#include "peripheral.h"
#include "err_manager.h"

#include "stm32f0xx_ll_rcc.h"
#include "stm32f0xx_ll_bus.h"

/*
 * Private control structure
 */
static dyn_ctrl_t dyn_ctrl;

/*
 * Private functions
 */
/*
 * Send command
 */
static void dyn_send_cmd(uint8_t *buff, int len)
{
        int i = 0;

        LL_USART_DisableDirectionRx(DYNAMIXEL_USART);
        LL_USART_EnableDirectionTx(DYNAMIXEL_USART);
        LL_USART_ClearFlag_TC(DYNAMIXEL_USART);
        while (len--) {
                while (!LL_USART_IsActiveFlag_TXE(DYNAMIXEL_USART));
                LL_USART_TransmitData8(DYNAMIXEL_USART, buff[i++]);
        }
        while (!LL_USART_IsActiveFlag_TC(DYNAMIXEL_USART));
        LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
        LL_USART_EnableDirectionRx(DYNAMIXEL_USART);
        dyn_clr_flag(dyn_ctrl, RX_COMPLETE);
        return;
}

/*
 * Send request for status packet from dynamixel by id
 */
static void dyn_ping(uint8_t id)
{
        uint8_t crc = id + 0x02 + 0x01;
        uint8_t tx[] = {0xff, 0xff, id, 0x02, 0x01, ~crc};

        dyn_send_cmd(tx, 6);
        return;
}

/*
 * This function should check UART RX buffer (i.e. check
 * dynamixel answers) and report about problem ASAP
 * Note: you may use fsm_set_state to switch to the next state
 * in context of shadow runtime. It would be better to create some
 * shared static structures to operate with motors and lock them once
 * error happened.
 */
void fsm_dynamixel_error_catch(void *args)
{
        /*
         * Check for errors here
         */
        (void) args;
        static uint8_t cur_id = 1;
        static dyn_status_pack_t *dyn_stat;

        if (is_dyn_flag_set(dyn_ctrl, RX_COMPLETE)) {
                /*
                 * Clear RX_COMPLETE flag
                 */
                dyn_clr_flag(dyn_ctrl, RX_COMPLETE);
                dyn_clr_flag(dyn_ctrl, CHECK_DYNAMIXEL);
                /*
                 * Process status packet and save status
                 */
                dyn_stat = (dyn_status_pack_t *) dyn_ctrl.channel_rx;
                dyn_ctrl.status[dyn_stat->id] = dyn_stat->err;
                if (dyn_stat->err) {
                        err_man_update_dyn_status(dyn_stat->id, dyn_stat->err);
                        fsm_set_state(FSM_ERR_MAN_SHOW_ERR);
                }
                /*
                 * Request status packet from next dynamixel if tx is not busy
                 */
                if (!is_dyn_flag_set(dyn_ctrl, TX_BUSY) &&
                    is_dyn_flag_set(dyn_ctrl, CHECK_DYNAMIXEL)) {
                        dyn_ping(cur_id++);
                        if (cur_id > NUMBER_OF_DYNAMIXELS)
                                cur_id = 1;
                }
        }
        return;
}

/*
 * Here we need to initialize all hardware related to dynamixel, like
 * single-wire UART, DMA.
 * Note: do not make this subroutine too big, split config into several parts
 * to be called
 */
void fsm_dynamixel_init(void *args)
{
        (void) args;
        int i = 0;

        fsm_add_shadow_state(FSM_DYNAMIXEL_ERROR_CATCH);
        /*
         * Initialization code
         */
        /*
         * Setting USART pin
         */
        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOA);
        /*
         * USART1_TX_RX setting
         */
        LL_GPIO_SetPinMode(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                           LL_GPIO_MODE_ALTERNATE);
        LL_GPIO_SetAFPin_8_15(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                              DYNAMIXEL_USART_PIN_AF);
        LL_GPIO_SetPinSpeed(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                            LL_GPIO_SPEED_FREQ_HIGH);
        LL_GPIO_SetPinOutputType(DYNAMIXEL_USART_PORT, DYNAMIXEL_USART_PIN,
                                 LL_GPIO_OUTPUT_OPENDRAIN);
        /*
         * USART Setting
         */
        LL_APB1_GRP2_EnableClock(LL_APB1_GRP2_PERIPH_USART1);
        LL_USART_SetParity(DYNAMIXEL_USART, DYNAMIXEL_USART_PARITY);
        LL_USART_SetDataWidth(DYNAMIXEL_USART, DYNAMIXEL_USART_DATA_WIDTH);
        LL_USART_SetStopBitsLength(DYNAMIXEL_USART, DYNAMIXEL_USART_STOPBITS);
        LL_USART_SetBaudRate(DYNAMIXEL_USART, SystemCoreClock,
                             DYNAMIXEL_USART_OVERSAMPL,
                             DYNAMIXEL_USART_BAUDRATE);
        LL_USART_EnableDMAReq_RX(DYNAMIXEL_USART);
        LL_USART_EnableHalfDuplex(DYNAMIXEL_USART);
        LL_USART_DisableDirectionTx(DYNAMIXEL_USART);
        LL_USART_EnableDirectionRx(DYNAMIXEL_USART);
        /*
         * DMA RX configuration
         */
        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_DMA1);
        LL_DMA_ConfigAddresses(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                               DYNAMIXEL_DMA_RX_DEST_ADDR,
                               (uint32_t) dyn_ctrl.channel_rx,
                               DYNAMIXEL_DMA_RX_DIRECTION);
        LL_DMA_SetDataLength(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                            DYNAMIXEL_DMA_RX_BUFFER_SIZE);
        LL_DMA_SetMemoryIncMode(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                               DYNAMIXEL_DMA_RX_MEM_INC_MODE);
        LL_DMA_SetMode(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL,
                       LL_DMA_MODE_CIRCULAR);
        LL_DMA_EnableIT_TC(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL);
        /*
         * Timer setting for dynamixel error catcher
         */
        LL_APB1_GRP1_EnableClock(LL_APB1_GRP1_PERIPH_TIM3);
        LL_TIM_SetCounterMode(DYNAMIXEL_TIMER, DYNAMIXEL_TIMER_MODE);
        LL_TIM_SetAutoReload(DYNAMIXEL_TIMER, DYNAMIXEL_TIMER_RELOAD);
        LL_TIM_SetPrescaler(DYNAMIXEL_TIMER, DYNAMIXEL_TIMER_PSC);
        LL_TIM_EnableIT_UPDATE(DYNAMIXEL_TIMER);
        /*
         * Setup DMA interrupt
         */
        NVIC_SetPriority(DYNAMIXEL_DMA_CHANNEL_IRQN,
                         DYNAMIXEL_DMA_CHANNEL_IRQN_PRIORITY);
        NVIC_EnableIRQ(DYNAMIXEL_DMA_CHANNEL_IRQN);
        /*
         * Setup Timer interrupt
         */
        NVIC_SetPriority(DYNAMIXEL_TIMER_IRQN, DYNAMIXEL_TIMER_IRQN_PRIORITY);
        NVIC_EnableIRQ(DYNAMIXEL_TIMER_IRQN);
        /*
         * Turn on USART, DMA and Timer
         */
        LL_DMA_EnableChannel(DYNAMIXEL_DMA_RX, DYNAMIXEL_DMA_RX_CHANNEL);
        LL_USART_Enable(DYNAMIXEL_USART);
        LL_TIM_EnableCounter(DYNAMIXEL_TIMER);
        /*
         * Clear rx complete flag
         */
        dyn_set_flag(dyn_ctrl, RX_COMPLETE);
        dyn_clr_flag(dyn_ctrl, CHECK_DYNAMIXEL);
        dyn_clr_flag(dyn_ctrl, TX_BUSY);
        /*
         * Clear status flags
         */
        for (i = 0; i < NUMBER_OF_DYNAMIXELS; i++)
                dyn_ctrl.status[i] = 0;
        /*
         * Configure debug led
         */
        LL_AHB1_GRP1_EnableClock(LL_AHB1_GRP1_PERIPH_GPIOC);
        LL_GPIO_SetPinMode(GPIOC, LL_GPIO_PIN_9, LL_GPIO_MODE_OUTPUT);
        LL_GPIO_SetPinOutputType(GPIOC, LL_GPIO_PIN_9, LL_GPIO_OUTPUT_PUSHPULL);

        /*
         * Switch to init collision avoidance
         */
        fsm_set_state(FSM_COLL_AVOID_INIT);
        return;
}

/*
 * Terminal comands implementation
 */
void fsm_dyn_set_angle(void *args)
{
        /*
         * Make new packet
         */
        dyn_set_angle_t *cmd_args = (dyn_set_angle_t *) args;
        uint8_t highByte = (uint8_t)((cmd_args->angle >> 8) & 0xff);
        uint8_t lowByte = (uint8_t)(cmd_args->angle & 0xff);
        uint8_t crc = cmd_args->id + 0x05 + 0x03 + 0x1e + lowByte + highByte;
        uint8_t tx[] = {0xff, 0xff, cmd_args->id, 0x05, 0x03, 0x1e, lowByte,
                               highByte, ~crc};

        if (cmd_args->angle > DYN_MAX_ANGLE)
                goto set_angle_error;
        /*
         * Set tx busy flag
         */
        dyn_set_flag(dyn_ctrl, TX_BUSY);
        /*
         * If receive is not complete, wait until error catcher process status
         * packet, don't switch to another state
         */
        if (is_dyn_flag_set(dyn_ctrl, RX_COMPLETE))
                return;
        dyn_send_cmd(tx, 9);
        fsm_set_state(FSM_TERM_MAIN);
set_angle_error:
        fsm_set_state(FSM_TERM_MAIN);
        return;
}

/*
 * Hardware interrupt handlers
 */
void DMA1_Channel2_3_IRQHandler(void)
{
        if (LL_DMA_IsActiveFlag_TC3(DYNAMIXEL_DMA_RX)) {
                LL_DMA_ClearFlag_TC3(DYNAMIXEL_DMA_RX);
                dyn_set_flag(dyn_ctrl, RX_COMPLETE);
                dyn_clr_flag(dyn_ctrl, TX_BUSY);
        }
}

void TIM3_IRQHandler(void)
{
        if (LL_TIM_IsActiveFlag_UPDATE(DYNAMIXEL_TIMER)) {
                LL_TIM_ClearFlag_UPDATE(DYNAMIXEL_TIMER);
                dyn_set_flag(dyn_ctrl, CHECK_DYNAMIXEL);
        }
}
