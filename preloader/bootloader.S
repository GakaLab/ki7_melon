.section .text.boot
.global _start

_start:
    b main

main:
    mov r0, #0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    b .