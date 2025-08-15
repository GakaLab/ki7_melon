project('bootloader', 'c',
  version : '0.1',
  default_options : ['c_std=c11'])

arm_toolchain = meson.get_compiler('c', native: false)

asm_file = 'bootloader.S'

# Linker arguments to generate map file
map_file = 'bootloader.map'
link_args = [
  '-nostdlib',
  '-Ttext=0x00000000',
  '-Wl,-Map=' + map_file
]

executable('bootloader.elf', asm_file,
  link_args : link_args,
  install : false)

custom_target('bootloader.bin',
  input : 'bootloader.elf',
  output : 'bootloader.bin',
  command : ['arm-none-eabi-objcopy', '-O', 'binary', '@INPUT@', '@OUTPUT@'],
  build_by_default : true)

# Optional: expose map file as build artifact
custom_target('bootloader.map',
  input : 'bootloader.elf',
  output : map_file,
  command : ['arm-none-eabi-objdump', '-h', '-x', '@INPUT@', '>', map_file],
  build_by_default : false)