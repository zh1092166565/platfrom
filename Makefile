ROOTFS_DIR=/home/linux/nfs/rootfs

MODULE_NAME = pla_led_pdev
MODULE_NAME2= pla_led_pdrv
#MODULE_NAME3= mydrv
APP_NAME=led_app

CROSS_COMPILE=/home/linux/gcc-4.6.4/bin/arm-none-linux-gnueabi-
CC=$(CROSS_COMPILE)gcc

ifeq ($(KERNELRELEASE), )

KERNEL_DIR=/home/linux/A53/kernel-3.4.39
CUR_DIR=$(shell pwd)

all:
	$(CC) $(APP_NAME).c -o $(APP_NAME)
	make -C $(KERNEL_DIR) M=$(CUR_DIR) modules
#	$(CC) $(APP_NAME).c -o $(APP_NAME)

clean:
	make -C $(KERNEL_DIR) M=$(CUR_DIR) clean
	rm -rf $(APP_NAME)
install:
	cp -raf *.ko $(APP_NAME) $(ROOTFS_DIR)/drv_module
	cp -raf *.ko $(ROOTFS_DIR)/drv_module

else
obj-m += $(MODULE_NAME).o
obj-m += $(MODULE_NAME2).o
#obj-m += $(MODULE_NAME3).o


endif

