ARCHS = arm64 arm64e
TARGET = iphone:latest:12.0

# App configuration
THEOS_DEVICE_IP = 192.168.1.100
THEOS_DEVICE_PORT = 22

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = CheatEngine
CheatEngine_FRAMEWORKS = UIKit Foundation CoreGraphics
CheatEngine_FILES = NonJailbreak/AppDelegate.mm $(wildcard KittyMemory/*.cpp) $(wildcard CustomView/*.m)
CheatEngine_CFLAGS = -w -std=gnu++14 -fno-exceptions
CheatEngine_CCFLAGS = -w -std=gnu++14

# Sign the app for non-jailbreak distribution
CheatEngine_CODESIGN_FLAGS = -S

include $(THEOS_MAKE_PATH)/application.mk
