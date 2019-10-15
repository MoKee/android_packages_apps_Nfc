LOCAL_PATH:= $(call my-dir)

########################################
# NXP Configuration
########################################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
        $(call all-java-files-under, src)

LOCAL_SRC_FILES += \
        $(call all-java-files-under, nxp)

LOCAL_SRC_FILES += \
        $(call all-java-files-under, nfcid)

LOCAL_PACKAGE_NAME := Nfc

LOCAL_PRIVATE_PLATFORM_APIS := true
LOCAL_CERTIFICATE := platform

LOCAL_JNI_SHARED_LIBRARIES  := libnfc_jni
LOCAL_JNI_SHARED_LIBRARIES  += libmokee_nfc_id_jni

LOCAL_STATIC_JAVA_LIBRARIES := android-support-v4

LOCAL_ADDITIONAL_DEPENDENCIES := Cards

LOCAL_PROGUARD_ENABLED := disabled

include $(BUILD_PACKAGE)

########################################
# NCI Configuration
########################################
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := \
        $(call all-java-files-under, src)

LOCAL_SRC_FILES += \
        $(call all-java-files-under, nci)

LOCAL_SRC_FILES += \
        $(call all-java-files-under, nfcid)

LOCAL_PACKAGE_NAME := NfcNci
LOCAL_OVERRIDES_PACKAGES := Nfc

LOCAL_PRIVATE_PLATFORM_APIS := true
LOCAL_CERTIFICATE := platform

LOCAL_JNI_SHARED_LIBRARIES := libnfc_nci_jni
LOCAL_JNI_SHARED_LIBRARIES += libmokee_nfc_id_jni

LOCAL_STATIC_JAVA_LIBRARIES := android-support-v4

LOCAL_ADDITIONAL_DEPENDENCIES := Cards

LOCAL_PROGUARD_ENABLED := disabled

include $(BUILD_PACKAGE)

include $(call all-makefiles-under,$(LOCAL_PATH))
