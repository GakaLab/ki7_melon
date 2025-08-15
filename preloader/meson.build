project('bootloader', 'c',
  version : '0.1',
  default_options : ['c_std=c11'])

# Define cross-compilation settings
arm_toolchain = meson.get_compiler('c', native: false)

asm_file = 'bootloader.S'

executable('bootloader.elf', asm_file,
  link_args : ['-nostdlib', '-Ttext=0x00000000'],
  install : false)

custom_target('bootloader.bin',
  input : 'bootloader.elf',
  output : 'bootloader.bin',
  command : ['arm-none-eabi-objcopy', '-O', 'binary', '@INPUT@', '@OUTPUT@'],
  build_by_default : true)