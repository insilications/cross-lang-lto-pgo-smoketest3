
#include "clib.h"

uint32_t c_always_inlined() {
    return 1234;
}

uint32_t c_never_inlined() {
    return 12345;
}

// uint32_t __attribute__((always_inline)) c_always_inlined() {
//     return 1234;
// }
//
// uint32_t __attribute__((always_inline)) c_never_inlined() {
//     return 12345;
// }
