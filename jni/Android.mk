LOCAL_PATH := $(call my-dir)

# First, define local static libraries for use in LOCAL_STATIC_LIBRARIES
# We need all of these for V8 to run.
# We put them in jni/lib, but we could also put them somewhere else.

# The following 3 libraries are copied from:
# <V8_HOME>/out/android_arm.release/obj.host/tools/gyp/libv8_base.a


# stlport is a StdC++ library, copied from:
#<NDK_r9d_HOME>/sources/cxx-stl/stlport/libs/armeabi/libstlport_static.a

# include $(CLEAR_VARS)

# LOCAL_MODULE          := stlport
# LOCAL_MODULE_FILENAME := stlport_static
# LOCAL_SRC_FILES := lib/libstlport_static.a

# include $(PREBUILT_STATIC_LIBRARY)



include $(CLEAR_VARS)

LOCAL_MODULE          := v8_base
LOCAL_MODULE_FILENAME := v8_base_static
LOCAL_SRC_FILES := lib/libv8_base.a

include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)

LOCAL_MODULE          := v8_snapshot
LOCAL_MODULE_FILENAME := v8_snapshot_static
LOCAL_SRC_FILES := lib/libv8_snapshot.a

include $(PREBUILT_STATIC_LIBRARY)


# include $(CLEAR_VARS)

# LOCAL_MODULE          := v8_libbase
# LOCAL_MODULE_FILENAME := v8_libbase_static
# LOCAL_SRC_FILES := lib/libv8_libbase.arm.a

# include $(PREBUILT_STATIC_LIBRARY)


# Now, compile our code and link everything together as a shared library
# in libs/.
# Note that the order of libraries in LOCAL_STATIC_LIBRARIES is important.
# If you swap the order, it likely won't link anymore.

include $(CLEAR_VARS)

LOCAL_MODULE    := glesjs
LOCAL_SRC_FILES := main.cpp
LOCAL_LDLIBS    := -llog -landroid -lEGL -lGLESv1_CM -lGLESv2
# LOCAL_STATIC_LIBRARIES := libv8_base libv8_libbase libv8_nosnapshot libstlport
LOCAL_STATIC_LIBRARIES := libv8_base libv8_snapshot
#LOCAL_STATIC_LIBRARIES := android_native_app_glue libv8_base libv8_libbase libv8_nosnapshot libstlport
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

# hide symbols from included static libraries
LOCAL_CPPFLAGS += -std=c++11 -Wl,--exclude-libs,libv8_base
LOCAL_CFLAGS += -Wl,--exclude-libs,libv8_base
LOCAL_LDFLAGS += -Wl,--exclude-libs,libv8_base

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)

