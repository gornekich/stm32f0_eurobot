#include "terminal.h"
#include "fsm.h"

/*
 * Init all periphs related to terminal communication, like
 * UART and all static structures related
 */
void fsm_term_init(void *args)
{
        (void) args;

        fsm_set_state(FSM_TERM_MAIN);
        return;
}

/*
 * Here all commands coming from stm32f4 should be processed
 * and then corresponding handler called
 * Example: if some command is requested then fsm_set_state to its
 * corresponding handler
 */

void fsm_term_main(void *args)
{
        (void) args;

        return;
}
