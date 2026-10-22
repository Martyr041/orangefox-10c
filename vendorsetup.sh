#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2018-2023 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
#  == == == == == == == == == == == == ==
#  * Device Tree by Romeo13card-sys
#  * Ported to R12 by Martyr_
#  == == == == == == == == == == == == ==
#  Note: This device tree alone will NOT give you the
#  same exact result as the Release builds!
#
#  There are numerous amounts of modifications within the OrangeFox
#  Source Code that includes tweaks and fixes (e.g: Flashlight Toggle)
FDEVICE="fog"
fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
	if [ -n "$chkdev" ]; then
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}
if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
	export FOX_TARGET_DEVICES="fog,rain,wind"
	export TARGET_DEVICE_ALT="fog"
	export FOX_USE_BASH_SHELL=1
	export FOX_USE_NANO_EDITOR=1
	export FOX_USE_TAR_BINARY=1
	export FOX_USE_SED_BINARY=1
	export FOX_USE_XZ_UTILS=1
	export FOX_BUGGED_AOSP_ARB_WORKAROUND="1616300800"; # Sun 21 Mar 04:26:40 GMT 2021
	export OF_QUICK_BACKUP_LIST="/boot;/data;"
	export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
	export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
	export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
	export OF_NO_MIUI_PATCH_WARNING=1
	export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
	export FOX_BUILD_TYPE="Unofficial"
	export FOX_VARIANT="Kitsune"
	export OF_MAINTAINER="Martyr_"
	export FOX_VIRTUAL_AB_DEVICE=1
	export OF_ADVANCED_SECURITY=1

	# Addons/Extras
	export FOX_ENABLE_APP_MANAGER=1
	export FOX_DELETE_AROMAFM=1
	export OF_ENABLE_FRP_ADDON=1
    export FOX_USE_MISANS_FONTS=1
    export FOX_USE_UPDATED_MAGISKBOOT=1
	export OF_DONT_PATCH_ENCRYPTED_DEVICE=0

    # Screen Settings
	export OF_SCREEN_H=2400
	export OF_SCREEN_W=720
	export OF_STATUS_H=90
	export OF_STATUS_INDENT_LEFT=74
	export OF_STATUS_INDENT_RIGHT=60
  	export OF_HIDE_NOTCH=1
	export OF_ALLOW_DISABLE_NAVBAR=1

    # maximum permissible splash image size (in kilobytes); do *NOT* increase!
	export OF_SPLASH_MAX_SIZE=130

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

 	# == Flashlight ==
 	# 99% of Custom Roms don't expose the flashlight path
	# in recovery, so this pretty much only works under stock MIUI...
    export OF_FLASHLIGHT_ENABLE=1
    export OF_FL_PATH1="/sys/class/leds/led:torch"
    export OF_FL_PATH2=""

	# Clock settings
	export OF_CLOCK_AM_PM=1
	export OF_USE_CLOCK_SECONDS=0
	export OF_CLOCK_POS=1

	# enable adb during zip installation
	export OF_ADB_AFTER_ZIP=1
	export OF_USE_LZMA_COMPRESSION=1
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi

# Clone kernel tree
git clone --depth=1 https://github.com/r0ddty/kernel_xiaomi_fog kernel/xiaomi/fog
