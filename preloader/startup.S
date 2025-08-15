.section .text
.global init_stack

init_stack:
    mov sp, #0x8000
    bx lr