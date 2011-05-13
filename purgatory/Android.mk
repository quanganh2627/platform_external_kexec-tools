LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

purgatory_x86_files := \
	arch/i386/entry32-16.S \
	arch/i386/entry32-16-debug.S \
	arch/i386/entry32.S \
	arch/i386/setup-x86.S \
	arch/i386/stack.S \
	arch/i386/compat_x86_64.S \
	arch/i386/purgatory-x86.c \
	arch/i386/console-x86.c \
	arch/i386/vga.c \
	arch/i386/pic.c \
	arch/i386/crashdump_backup.c

LOCAL_SRC_FILES := \
		purgatory.c \
		printf.c \
		string.c \
		../util_lib/sha256.c \
		$(purgatory_x86_files)

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/include \
		$(LOCAL_PATH)/arch/i386/include \
		$(LOCAL_PATH)/../util_lib/include \
		$(LOCAL_PATH)/../include

LOCAL_CFLAGS := -g -fno-strict-aliasing -fno-pic -Wall -Wstrict-prototypes \
		-Os -fno-builtin -ffreestanding -fno-zero-initialized-in-bss

PURGATORY_LDFLAGS := -Wl,--no-undefined -nostartfiles -nostdlib \
		-nodefaultlibs -e purgatory_start -r

LOCAL_MODULE := kexec_purgatory
LOCAL_MODULE_CLASS := STATIC_LIBRARIES
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_SUFFIX := .ro

intermediates := $(call intermediates-dir-for, STATIC_LIBRARIES, kexec)

include $(BUILD_SYSTEM)/binary.mk

$(LOCAL_BUILT_MODULE): $(all_objects)
	$(PRIVATE_CC) $(LOCAL_CFLAGS) $(PURGATORY_LDFLAGS) -o $@ $^

