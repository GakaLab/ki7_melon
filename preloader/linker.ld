SECTIONS {
  . = 0x0;

  .header : {
    KEEP(*(.data))   /* header.o uses .data by default */
  }

  . = 0xF4;

  .text.boot._start : {
    KEEP(*(.text.boot._start))
  }

  . = 0x110;

  .text.boot.main : {
    KEEP(*(.text.boot.main))
  }

  /DISCARD/ : {
    *(.comment)
    *(.note*)
    *(.eh_frame)
  }
}