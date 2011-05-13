LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
	kexec.c \
	ifdown.c \
	kexec-elf.c \
	kexec-elf-exec.c \
	kexec-elf-core.c \
	kexec-elf-rel.c \
	kexec-elf-boot.c \
	kexec-iomem.c \
	firmware_memmap.c \
	crashdump.c \
	crashdump-xen.c \
	phys_arch.c \
	lzma.c \
	zlib.c \
	proc_iomem.c \
	virt_to_phys.c \
	phys_to_virt.c \
	add_segment.c \
	add_buffer.c \
	arch_reuse_initrd.c \
	arch_init.c

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/../include \
	$(LOCAL_PATH)/../util_lib/include \
	external/zlib

ifeq ($(TARGET_ARCH),x86)
LOCAL_C_INCLUDES += $(LOCAL_PATH)/arch/i386/include
LOCAL_SRC_FILES += \
	arch/i386/kexec-x86.c \
	arch/i386/kexec-x86-common.c \
	arch/i386/kexec-elf-x86.c \
	arch/i386/kexec-elf-rel-x86.c \
	arch/i386/kexec-bzImage.c \
	arch/i386/kexec-multiboot-x86.c \
	arch/i386/kexec-beoboot-x86.c \
	arch/i386/kexec-nbi.c \
	arch/i386/x86-linux-setup.c \
	arch/i386/crashdump-x86.c
endif
	

LOCAL_MODULE := kexec
LOCAL_MODULE_TAGS := optional
LOCAL_SHARED_LIBRARIES := libz
LOCAL_STATIC_LIBRARIES := libkexec_util_lib
LOCAL_CFLAGS := -g -O2 -fno-strict-aliasing -Wall -Wstrict-prototypes
LOCAL_MODULE_CLASS := EXECUTABLES

intermediates := $(local-intermediates-dir)
PURGATORY_C := $(intermediates)/purgatory.c
LOCAL_GENERATED_SOURCES += $(PURGATORY_C)
bin2hex := $(HOST_OUT_EXECUTABLES)/bin-to-hex
KEXEC_PURGATORY := $(TARGET_OUT_STATIC_LIBRARIES)/kexec_purgatory.ro
$(PURGATORY_C): $(KEXEC_PURGATORY) $(bin2hex)
	mkdir -p $(@D)
	$(bin2hex) purgatory < $(KEXEC_PURGATORY) > $@

include $(BUILD_EXECUTABLE)

$(LOCAL_BUILT_MODULE): $(KEXEC_PURGATORY)

