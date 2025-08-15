.syntax unified
    .cpu cortex-a7
    .thumb
    .global _start

_start:
    // Branch to main logic
    b main

main:
    // Load address from literal pool
    ldr r6, =0x201000
    str r4, [r6]         // Store r4 to memory

    // Zero out general-purpose registers
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

    // Zero out stack pointer and link register
    mov sp, #0
    mov lr, #0

    // Read APSR (Application Program Status Register)
    mrs r0, apsr

    // Mask out condition flags
    bic r0, r0, #0x1F
    orr r0, r0, #0xD3

    // Write to CPSR (Control Program Status Register)
    msr cpsr_fc, r0

    // Set interrupt flags
    mrs r0, apsr
    mov r1, #0xC0
    orr r0, r0, r1
    msr cpsr_fsxc, r0

    // Infinite loop
hang:
    b hang