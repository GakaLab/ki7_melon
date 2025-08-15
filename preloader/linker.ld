ENTRY(_start)

SECTIONS {
  . = 0x00000000;

  .text : {
    KEEP(*(.text.boot))
    *(.text*)
  }

  .data : {
    *(.data*)
  }

  .bss : {
    *(.bss*)
    *(COMMON)
  }

  /DISCARD/ : {
    *(.note*)
    *(.comment*)
  }
}