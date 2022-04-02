#include <stdint.h>

uint32_t c_always_inlined();
uint32_t c_never_inlined();
// uint32_t __attribute__((always_inline)) c_always_inlined();
// uint32_t __attribute__((always_inline)) c_never_inlined();
