APP_PLATFORM := android-17

# afaik V8 uses v7a, so we might as well use it
APP_ABI := armeabi-v7a

APP_STL := gnustl_static

APP_CPPFLAGS += -std=c++11