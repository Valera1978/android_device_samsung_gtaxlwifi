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

LOCAL_PATH := $(call my-dir)

ifneq ($(filter gtaxlwifi, $(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

# Create links for OpenCL files
$(shell mkdir -p  $(TARGET_OUT_VENDOR)/lib; \
	mkdir -p  $(TARGET_OUT_VENDOR)/lib/hw; \
    ln -sf /vendor/lib/egl/libGLES_mali.so /vendor/lib/libOpenCL.so.1.1; \
    ln -sf /vendor/lib/egl/libGLES_mali.so /vendor/lib/libOpenCL.so.1; \
    ln -sf /vendor/lib/egl/libGLES_mali.so /vendor/lib/libOpenCL.so; \
    ln -sf /vendor/lib/egl/libGLES_mali.so /vendor/lib/hw/vulkan.exynos5.so)

$(shell mkdir -p  $(TARGET_OUT_VENDOR)/lib64; \
	mkdir -p  $(TARGET_OUT_VENDOR)/lib64/hw; \
    ln -sf /vendor/lib64/egl/libGLES_mali.so /vendor/lib64/libOpenCL.so.1.1; \
    ln -sf /vendor/lib64/egl/libGLES_mali.so /vendor/lib64/libOpenCL.so.1; \
    ln -sf /vendor/lib64/egl/libGLES_mali.so /vendor/lib64/libOpenCL.so; \
    ln -sf /vendor/lib64/egl/libGLES_mali.so /vendor/lib64/hw/vulkan.exynos5.so)

#WCNSS_INI_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/qcom_cfg.ini
#$(WCNSS_INI_SYMLINK): $(LOCAL_INSTALLED_MODULE)
#	@echo "WCNSS config ini link: $@"
#	@mkdir -p $(dir $@)
#	@rm -rf $@
#	$(hide) ln -sf /vendor/etc/wifi/$(notdir $@) $@

WCNSS_MAC_SYMLINK := $(TARGET_OUT_VENDOR)/firmware/wlan/wlan_mac.bin
$(WCNSS_MAC_SYMLINK): $(LOCAL_INSTALLED_MODULE)
	@echo "WCNSS MAC bin link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /persist/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(WCNSS_INI_SYMLINK) $(WCNSS_MAC_SYMLINK)

endif
