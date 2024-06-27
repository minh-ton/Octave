TARGET = iphone:clang::13.3
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard # mediaserverd

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Octave

Octave_FILES = Octave.xm $(wildcard colors/*.m)
Octave_CFLAGS = -fobjc-arc
Octave_FRAMEWORKS = UIKit
Octave_PRIVATE_FRAMEWORKS = MediaRemote

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
