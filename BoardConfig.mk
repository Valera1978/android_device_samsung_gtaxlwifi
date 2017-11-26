#
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH := device/samsung/gtaxllte

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

#BLOCK_BASED_OTA:= false

# Platform
TARGET_BOARD_PLATFORM := exynos5
TARGET_SLSI_VARIANT := cm
TARGET_SOC := exynos7870
TARGET_BOOTLOADER_BOARD_NAME := universal7870

# CPU
FORCE_32_BIT := true

TARGET_BOARD_SUFFIX := _32
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53
TARGET_CPU_CORTEX_A53 := true

# Binder
TARGET_USES_64_BIT_BINDER := false

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/$(HOST_OS)-x86/aarch64/aarch64-linux-android-4.9/bin

BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

TARGET_KERNEL_SOURCE := kernel/samsung/exynos7870
TARGET_KERNEL_CONFIG := lineage-gtaxllte_defconfig

BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive

BOARD_KERNEL_SEPARATED_DT := true
TARGET_CUSTOM_DTBTOOL := dtbhtoolExynos

BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
TARGET_USES_UNCOMPRESSED_KERNEL := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 39845888
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 3072000000
#original system size = 3565158400, but some times device had diff system size (us-eu), better decrease a bit
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_CACHEIMAGE_PARTITION_SIZE    := 209715200
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

# Use these flags if the board has a ext4 partition larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_HAS_QCA_BT_ROME := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
QCOM_BT_USE_BTNV := true
QCOM_BT_USE_SMD_TTY := true

# Samsung HALs
TARGET_AUDIOHAL_VARIANT := samsung
TARGET_POWERHAL_VARIANT := samsung

# Samsung Hardware
BOARD_HARDWARE_CLASS := $(LOCAL_PATH)/cmhw
BOARD_HARDWARE_CLASS += hardware/samsung/cmhw

# Samsung Camera
BOARD_USE_SAMSUNG_CAMERAFORMAT_NV21 := true

# Graphics
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# HDMI
BOARD_HDMI_INCAPABLE := true
# FIMG2D
BOARD_USES_SKIA_FIMGAPI := true
# (G)SCALER
BOARD_USES_SCALER := true
# Samsung OpenMAX Video
BOARD_USE_STOREMETADATA := true
BOARD_USE_METADATABUFFERTYPE := true
BOARD_USE_DMA_BUF := true
BOARD_USE_ANB_OUTBUF_SHARE := true
BOARD_USE_IMPROVED_BUFFER := true
BOARD_USE_NON_CACHED_GRAPHICBUFFER := true
BOARD_USE_GSC_RGB_ENCODER := true
BOARD_USE_CSC_HW := false
BOARD_USE_QOS_CTRL := false
BOARD_USE_S3D_SUPPORT := true
BOARD_USE_VP8ENC_SUPPORT := true

# Video scaling issue workaround
TARGET_OMX_LEGACY_RESCALING := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_AP := "ap"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_P2P := "p2p"
WIFI_DRIVER_MODULE_NAME := wlan
WIFI_DRIVER_MODULE_PATH := /system/lib/modules/qca_cld/qca_cld_wlan.ko
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Wifi loader
BOARD_HAVE_SAMSUNG_WIFI := true

# Charger
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
CHARGING_ENABLED_PATH := /sys/class/power_supply/battery/batt_lp_charging

# RIL
BOARD_VENDOR := samsung
BOARD_MODEM_TYPE := ss333
BOARD_PROVIDES_LIBRIL := true

# RIL.java overwrite
BOARD_RIL_CLASS := ../../../$(LOCAL_PATH)/ril

# Sensors
TARGET_NO_SENSOR_PERMISSION_CHECK := true
TARGET_SEC_FP_HAL_VARIANT := bauth

# Release tools
TARGET_RELEASETOOLS_EXTENSIONS := $(LOCAL_PATH)

# Recovery
#RECOVERY_VARIANT := twrp
BOARD_HAS_DOWNLOAD_MODE := true
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk/fstab.samsungexynos7870
TARGET_OTA_ASSERT_DEVICE := gtaxllte

# TWRP
ifeq ($(RECOVERY_VARIANT),twrp)
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/twrp.fstab
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_THEME := portrait_hdpi
TW_BRIGHTNESS_PATH := /sys/class/backlight/panel/brightness
TW_MAX_BRIGHTNESS := 255
TW_NO_REBOOT_BOOTLOADER := true
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_NTFS_3G := true
TW_HAS_DOWNLOAD_MODE := true
TW_NO_EXFAT_FUSE := true
TW_EXCLUDE_SUPERSU := true
endif

# Seccomp filters
BOARD_SECCOMP_POLICY += $(LOCAL_PATH)/seccomp

# SELinux
BOARD_SEPOLICY_DIRS := $(LOCAL_PATH)/sepolicy

# Inherit from the proprietary version
-include vendor/samsung/gtaxllte/BoardConfigVendor.mk
