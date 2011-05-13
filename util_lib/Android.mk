LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
		compute_ip_checksum.c \
		sha256.c

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/include \
		$(LOCAL_PATH)/../include

LOCAL_MODULE := libkexec_util_lib

include $(BUILD_STATIC_LIBRARY)

