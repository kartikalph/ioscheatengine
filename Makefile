export THEOS = $(HOME)/theos
ARCHS = arm64 

DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ADMIN

ADMIN_FRAMEWORKS = IOKit  UIKit Foundation Security QuartzCore CoreGraphics CoreText  AVFoundation Accelerate GLKit SystemConfiguration GameController
ADMIN_LDFLAGS += JRMemory.framework/JRMemory
ADMIN_CCFLAGS = -w -std=gnu++14 -fno-rtti -fno-exceptions -DNDEBUG -Wno-module-import-in-extern-c
ADMIN_CFLAGS = -w -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

ADMIN_FILES = Dolphins.mm $(wildcard abc/*.m) $(wildcard View/*.mm) $(wildcard Module/*.mm) $(wildcard CustomView/*.m) $(wildcard utils/*.cpp) $(wildcard utils/*.m) $(wildcard HOST/*.m) $(wildcard imgui/*.mm) $(wildcard imgui/*.cpp)  $(wildcard ESP/*.mm) $(wildcard ESP/*.cpp) $(wildcard SDK/*.cpp)

#Dolphins_LIBRARIES += substrate
# GO_EASY_ON_ME = 1

include $(THEOS_MAKE_PATH)/tweak.mk
