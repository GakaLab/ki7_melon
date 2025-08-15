project('bootloader', 'c', 'cpp', version: '0.1', default_options: ['c_std=gnu11'])

arm_as = find_program('arm-none-eabi-as')
arm_ld = find_program('arm-none-eabi-ld')
arm_objcopy = find_program('arm-none-eabi-objcopy')

bootloader_src = files('bootloader.S', 'src/startup.S')

bootloader_obj = []
foreach src : bootloader_src
  bootloader_obj += custom_target(
    src.basename() + '_obj',
    input: src,
    output: src.basename() + '.o',
    command: [arm_as, '-mcpu=cortex-a7', '-o', '@OUTPUT@', '@INPUT@']
  )
endforeach

bootloader_bin = custom_target(
  'bootloader_bin',
  input: bootloader_obj,
  output: 'bootloader.bin',
  command: [
    arm_ld, '-T', 'linker.ld', '-Map=bootloader.map', '-o', 'bootloader.elf',
    '@INPUT@'
  ],
  build_by_default: true
)

bootloader_final = custom_target(
  'bootloader_final',
  input: bootloader_bin,
  output: 'bootloader_final.bin',
  command: [arm_objcopy, '-O', 'binary', 'bootloader.elf', '@OUTPUT@']
)