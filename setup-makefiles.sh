#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=gtaxlwifi
DEVICE_COMMON=gtaxlwifi
VENDOR=samsung

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true

# Warning headers and guards
write_headers "gtaxlwifi gtanotexlwifi"

write_makefiles "${MY_DIR}/proprietary-files.txt" true

###################################################################################################
# CUSTOM PART START                                                                               #
###################################################################################################
OUTDIR=vendor/$VENDOR/$DEVICE
(cat << EOF) >> $ANDROID_ROOT/$OUTDIR/Android.mk
include \$(CLEAR_VARS)
LOCAL_MODULE := libGLES_mali
LOCAL_MODULE_OWNER := samsung
LOCAL_SRC_FILES_64 := proprietary/vendor/lib64/egl/libGLES_mali.so
LOCAL_SRC_FILES_32 := proprietary/vendor/lib/egl/libGLES_mali.so
LOCAL_MULTILIB := both
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_CHECK_ELF_FILES := false
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_PATH_32 := \$(\$(TARGET_2ND_ARCH_VAR_PREFIX)TARGET_OUT_VENDOR_SHARED_LIBRARIES)/egl
LOCAL_MODULE_PATH_64 := \$(TARGET_OUT_VENDOR_SHARED_LIBRARIES)/egl

SYMLINKS := \$(TARGET_OUT)/vendor
\$(SYMLINKS):
	@mkdir -p \$@/lib/hw
	@mkdir -p \$@/lib64/hw
	@echo "Symlink: vulkan.exynos5.so"
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib/vulkan.exynos5.so
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib64/vulkan.exynos5.so
	@echo "Symlink: libOpenCL.so"
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib/libOpenCL.so
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib64/libOpenCL.so
	@echo "Symlink: libOpenCL.so.1"
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib/libOpenCL.so.1
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib64/libOpenCL.so.1
	@echo "Symlink: libOpenCL.so.1.1"
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib/libOpenCL.so.1.1
	\$(hide) ln -sf egl/libGLES_mali.so \$@/lib64/libOpenCL.so.1.1

ALL_MODULES.\$(LOCAL_MODULE).INSTALLED := \\
	\$(ALL_MODULES.\$(LOCAL_MODULE).INSTALLED) \$(SYMLINKS)

include \$(BUILD_PREBUILT)

EOF

(cat << EOF) >> $ANDROID_ROOT/$OUTDIR/$DEVICE-vendor.mk

# Create Mali symlinks for Vulkan and OpenCL
PRODUCT_PACKAGES += libGLES_mali
EOF
###################################################################################################
# CUSTOM PART END                                                                                 #
###################################################################################################

# Finish
write_footers
