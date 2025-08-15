.section .text.boot
.global _start

@ ─────────────────────────────────────────────
@ Entry point: branch to main logic
@ ─────────────────────────────────────────────
_start:
    b main

@ ─────────────────────────────────────────────
@ Main boot logic
@ ─────────────────────────────────────────────
main:
@ Zero general-purpose registers
    mov r0, #0
    mov r1, #0
    mov r2, #0
    mov r3, #0
    mov r4, #0
    mov r5, #0
    mov r6, #0
    mov r7, #0
    mov r8, #0
    mov r9, #0
    mov r10, #0
    mov r11, #0
    mov r12, #0
    mov sp, #0
    mov lr, #0

@ Set CPU to Supervisor mode
    mrs r0, cpsr
    bic r0, r0, #0x1F         @ Clear mode bits
    orr r0, r0, #0x13         @ Set SVC mode (0b10011)
    msr cpsr_c, r0

@ Disable IRQ and FIQ
    mrs r0, cpsr
    orr r0, r0, #0xC0         @ IRQ (0x80) + FIQ (0x40)
    msr cpsr_c, r0

@ Clear memory region (e.g. .bss)
    ldr r0, =0x102000       @ Start address
    ldr r1, =0x10cdb0       @ End address
    mov r2, #0                @ Value to store
clear_loop:
    str r2, [r0], #4          @ Store and increment
    cmp r0, r1
    bne clear_loop

@ Setup stack pointer
    ldr sp, =0x267000

@ Jump to next stage (e.g. U-Boot or kernel)
    ldr r0, =0x2743b0
    bx r0