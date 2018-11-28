#include "dynamixel.h"
#include "fsm.h"

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
        (void) args;

        /*
         * Check for errors here
         */
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

        fsm_add_shadow_state(FSM_DYNAMIXEL_ERROR_CATCH);
        /*
         * Initialization code
         */

        /*
         * Let's switch to init terminal
         */
        fsm_set_state(FSM_COLL_AVOID_INIT);
        return;
}
