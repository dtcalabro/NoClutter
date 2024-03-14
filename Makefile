TARGET := iphone:clang:latest:16.0

SDK_PATH = $(THEOS)/sdks/iPhoneOS16.5.sdk/
SYSROOT = $(SDK_PATH)

THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2222
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoClutter
NoClutter_FILES = Tweak.xm
NoClutter_CFLAGS = -fobjc-arc
NoClutter_EXTRA_FRAMEWORKS += Cephei
NoClutter_PRIVATE_FRAMEWORKS = CoreTelephony AppleMediaServices

SUBPROJECTS += noclutterprefs

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk