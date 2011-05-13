LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := kdump.c
LOCAL_MODULE := kdump
LOCAL_MODULE_TAGS := optional

include $(BUILD_EXECUTABLE)

