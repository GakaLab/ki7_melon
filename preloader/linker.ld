ENTRY(_start)

SECTIONS {
  /* Start placing code at offset 0xF4 to match preloader layout */
  . = 0xF4;

  .text.boot : {
    KEEP(*(.text.boot))
  }

  /DISCARD/ : {
    *(.comment)
    *(.note*)
  }
}