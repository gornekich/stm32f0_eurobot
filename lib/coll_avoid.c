#include "coll_avoid.h"
#include "fsm.h"

/*
 * Init all hardware related to collision avoidance
 * and then switch to terminal init
 */
void fsm_coll_avoid_init(void *args)
{
        (void) args;

        fsm_add_shadow_state(FSM_COLL_AVOID_MAIN);
        fsm_set_state(FSM_TERM_INIT);
        return;
}

/*
 * Here all proximity sensors should be processed
 * Note: once collision happened we may stop all motors and
 *       set some flag in some shared structure (like in data
 *       field of terminal manager)
 */
void fsm_coll_avoid_main(void *args)
{
        (void) args;

        return;
}
