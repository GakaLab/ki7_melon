.PHONY: ramdisk boot.img

all: ramdisk

ramdisk:
	cd initrd && find | cpio -o --format=newc -R root:root | gzip -9 > ../ramdisk.cpio.gz

boot.img:
	mkbootimg --header_version 2 \
        --os_version 13.0.0 --os_patch_level 2023-01 \
		--kernel Image.gz --ramdisk ramdisk.cpio.gz --dtb fdt.dtb \
		--pagesize 0x00000800 --base 0x40000000 \
		--kernel_offset 0x00000000 --ramdisk_offset 0x7c80000 \
		--second_offset 0x00000000 --tags_offset 0xbc80000 \
		--dtb_offset 0xbc80000 --board CY-KI7-V7510 \
		--cmdline 'bootopt=64S3,32N2,64N2 loglevel=14 printk.devkmsg=on \
		    androidboot.selinux=permissive buildvariant=eng androidboot.usbconfig=adb' -o $@

flash:
	adb -d wait-for-usb-device reboot bootloader
	fastboot flash boot_a boot.img
	fastboot reboot
	sleep 15
	fastboot flash boot_a stock.img
	fastboot continue

log:
	for var in $$(adb -d wait-for-usb-device shell su -c ls /sys/fs/pstore/*); do \
	    name="$${var##*/}"; \
	    adb -d wait-for-usb-device shell su -c cat "$$var" > "$${name%%-*}".log; \
	done

metamode:
	mtk payload --metamode FASTBOOT

rescue: metamode
	fastboot flash boot_a stock.img
	fastboot continue