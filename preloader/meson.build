project('bootloader', 'c', version: '0.1', default_options: ['c_std=gnu99'])

# Toolchain
arm_as = find_program('arm-none-eabi-as')
arm_ld = find_program('arm-none-eabi-ld')
arm_objcopy = find_program('arm-none-eabi-objcopy')

# Source
boot_asm = arm_as.compile('src/boot.S')

# Link to ELF using custom linker script
boot_elf = custom_target('bootloader.elf',
  output: 'bootloader.elf',
  input: boot_asm,
  command: [arm_ld, '-T', 'linker.ld', '-o', '@OUTPUT@', '@INPUT@'],
  build_by_default: true
)

# Convert ELF to raw binary
boot_raw = custom_target('bootloader.raw',
  output: 'bootloader.raw',
  input: boot_elf,
  command: [arm_objcopy, '-O', 'binary', '@INPUT@', '@OUTPUT@'],
  build_by_default: true
)

# Generate dummy header (0xF4 bytes of zero)
pad = custom_target('pad.bin',
  output: 'pad.bin',
  command: ['dd', 'if=/dev/zero', 'bs=1', 'count=244', 'status=none'],
  build_by_default: true
)

# Stitch header + raw binary
stitched = custom_target('bootloader.stitched',
  output: 'bootloader.stitched',
  input: [pad, boot_raw],
  command: ['cat', '@INPUT@', '>', '@OUTPUT@'],
  build_by_default: true
)