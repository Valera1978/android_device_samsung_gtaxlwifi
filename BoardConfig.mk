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

LOCAL_PATH := device/samsung/gtaxlwifi

# Include path
TARGET_SPECIFIC_HEADER_PATH := $(LOCAL_PATH)/include

# Firmware
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

#BLOCK_BASED_OTA:= false

# ADB Legacy Interface
TARGET_USES_LEGACY_ADB_INTERFACE := true

# Platform
TARGET_BOARD_PLATFORM := exynos5
TARGET_SLSI_VARIANT := cm
TARGET_SOC := exynos7870
TARGET_BOOTLOADER_BOARD_NAME := universal7870

# CPU
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# Binder
TARGET_USES_64_BIT_BINDER := true

# Kernel
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-

BOARD_KERNEL_BASE := 0x10000000
BOARD_KERNEL_PAGESIZE := 2048

TARGET_KERNEL_SOURCE := kernel/samsung/exynos7870
TARGET_KERNEL_CONFIG := lineage-gtaxlwifi_defconfig

BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100

BOARD_KERNEL_SEPARATED_DT := true
TARGET_CUSTOM_DTBTOOL := dtbhtoolExynos

BOARD_CUSTOM_BOOTIMG_MK := hardware/samsung/mkbootimg.mk
BOARD_KERNEL_IMAGE_NAME := Image

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE     := 33554432
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 39845888
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 3072000000
#original system size = 3565158400, but some times device had diff system size (us-eu), better decrease a bit
BOARD_USERDATAIMAGE_PARTITION_SIZE := 10737418240
BOARD_CACHEIMAGE_PARTITION_SIZE    := 209715200
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE  := ext4
BOARD_FLASH_BLOCK_SIZE := 4096

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BOARD_HAS_QCA_BT_ROME := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
QCOM_BT_USE_BTNV := true
#QCOM_BT_USE_SMD_TTY := true

# Samsung HALs
TARGET_AUDIOHAL_VARIANT := samsung
TARGET_POWERHAL_VARIANT := samsung

# Lineage HW
JAVA_SOURCE_OVERLAYS := org.lineageos.hardware|device/samsung/gtaxlwifi/lineagehw|**/*.java

# Samsung Camera
BOARD_USE_SAMSUNG_CAMERAFORMAT_NV21 := true
TARGET_USES_MEDIA_EXTENSIONS := true
USE_DEVICE_SPECIFIC_CAMERA := true

# Graphics
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# HDMI
BOARD_HDMI_INCAPABLE := true

# FIMG2D
BOARD_USES_SKIA_FIMGAPI := true

# (G)SCALER
BOARD_USES_SCALER := true
BOARD_USES_DT := true

# Samsung LSI OpenMAX
BOARD_GLOBAL_CFLAGS += -DUSE_NATIVE_SEC_NV12TILED

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
BOARD_USE_S3D_SUPPORT := false
BOARD_USE_TIMESTAMP_REORDER_SUPPORT := true
BOARD_USE_DEINTERLACING_SUPPORT := true
BOARD_USE_VP8ENC_SUPPORT := true
BOARD_USE_HEVCDEC_SUPPORT := true
BOARD_USE_HEVCENC_SUPPORT := true
BOARD_USE_HEVC_HWIP := false
BOARD_USE_VP9DEC_SUPPORT := true
BOARD_USE_VP9ENC_SUPPORT := false
BOARD_USE_CUSTOM_COMPONENT_SUPPORT := true
BOARD_USE_VIDEO_EXT_FOR_WFD_HDCP := true
BOARD_USE_SINGLE_PLANE_IN_DRM := true

# Video scaling issue workaround
TARGET_OMX_LEGACY_RESCALING := true

# Render Script
BOARD_OVERRIDE_RS_CPU_VARIANT_32 := cortex-a53
BOARD_OVERRIDE_RS_CPU_VARIANT_64 := cortex-a53

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
#WIFI_DRIVER_FW_PATH_AP           := "ap"
#WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_P2P         := "p2p"
WPA_SUPPLICANT_VERSION           := VER_0_8_X

# Wifi loader
BOARD_HAVE_SAMSUNG_WIFI := true

# Charger
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/class/power_supply/battery/batt_lp_charging
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_CHARGER_SHOW_PERCENTAGE := true
CHARGING_ENABLED_PATH := /sys/class/power_supply/battery/batt_lp_charging

# RIL
BOARD_VENDOR := samsung

#Hidl
#DEVICE_MANIFEST_FILE := device/samsung/gtaxlwifi/manifest.xml

# Release tools
TARGET_RELEASETOOLS_EXTENSIONS := $(LOCAL_PATH)

# Recovery
#RECOVERY_VARIANT := twrp
BOARD_HAS_DOWNLOAD_MODE := true
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk/fstab.samsungexynos7870
TARGET_OTA_ASSERT_DEVICE := gtaxlwifi

# TWRP
ifeq ($(RECOVERY_VARIANT),twrp)
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/ramdisk/twrp.fstab
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

# Shims: libui
TARGET_LD_SHIM_LIBS += \
    /system/lib/omx/libOMX.Exynos.AVC.Decoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.AVC.Encoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.HEVC.Decoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.HEVC.Encoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.MPEG2.Decoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.MPEG4.Decoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.MPEG4.Encoder.so|libui_shim.so \
    /system/lib/omx/libOMX.Exynos.VP9.Decoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.AVC.Decoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.AVC.Encoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.HEVC.Decoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.HEVC.Encoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.MPEG2.Decoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.MPEG4.Decoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.MPEG4.Encoder.so|libui_shim.so \
    /system/lib64/omx/libOMX.Exynos.VP9.Decoder.so|libui_shim.so

# Shims: camera
TARGET_LD_SHIM_LIBS += \
    /system/lib/libcamera_client.so|libcamera_client_shim.so \
    /system/lib/libexynoscamera.so|libexynoscamera_shim.so

# Shims: gps
TARGET_LD_SHIM_LIBS += \
    /system/bin/gpsd|gpsd_shim.so

# SELinux
BOARD_SEPOLICY_DIRS := $(LOCAL_PATH)/sepolicy

# Inherit from the proprietary version
-include vendor/samsung/gtaxlwifi/BoardConfigVendor.mk
