TARGET := iphone:clang:latest:7.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = OctavePrefs

OctavePrefs_FILES = OCTRootListController.m
OctavePrefs_FRAMEWORKS = UIKit
OctavePrefs_PRIVATE_FRAMEWORKS = Preferences
OctavePrefs_INSTALL_PATH = /Library/PreferenceBundles
OctavePrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
