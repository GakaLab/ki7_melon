project('bootloader', 'c', version: '0.1', default_options: ['c_std=gnu99'])

# Toolchain
arm_as = find_program('arm-none-eabi-as')
arm_ld = find_program('arm-none-eabi-ld')
arm_objcopy = find_program('arm-none-eabi-objcopy')
arm_objdump = find_program('arm-none-eabi-objdump')

# Assemble boot.S
boot_obj = arm_as.compile('src/boot.S')

# Convert header.bin to object file
header_obj = custom_target('header.o',
  input: 'header.bin',
  output: 'header.o',
  command: ['arm-none-eabi-ld', '-r', '-b', 'binary', '-o', '@OUTPUT@', '@INPUT@'],
  build_by_default: true
)

# Link ELF with linker script
boot_elf = custom_target('bootloader.elf',
  output: 'bootloader.elf',
  input: [header_obj, boot_obj],
  command: [arm_ld, '-T', 'linker.ld', '-o', '@OUTPUT@', '@INPUT@'],
  build_by_default: true
)

# Convert ELF to raw binary
boot_bin = custom_target('bootloader.raw',
  output: 'bootloader.raw',
  input: boot_elf,
  command: [arm_objcopy, '-O', 'binary', '@INPUT@', '@OUTPUT@'],
  build_by_default: true
)

# Optional: Generate map file for inspection
boot_map = custom_target('bootloader.map',
  output: 'bootloader.map',
  input: boot_elf,
  command: [arm_objdump, '-x', '@INPUT@'],
  build_by_default: true
)