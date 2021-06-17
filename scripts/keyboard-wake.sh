#!/usr/bin/env bash
# echo 'enabled' > /sys/bus/usb/devices/1-1.3/power/wakeup:disabled
# echo 'enabled' > /sys/bus/usb/devices/1-1/power/wakeup:disabled
# echo 'enabled' > /sys/bus/usb/devices/2-1/power/wakeup:disabled
# echo 'enabled' > /sys/bus/usb/devices/3-1/power/wakeup:enabled
# echo 'enabled' > /sys/bus/usb/devices/3-2.1/power/wakeup:enabled
# echo 'enabled' > /sys/bus/usb/devices/3-2.2/power/wakeup:enabled
# echo 'enabled' > /sys/bus/usb/devices/3-2.4/power/wakeup:disabled
# echo 'enabled' > /sys/bus/usb/devices/3-2/power/wakeup:disabled
sudo echo 'enabled' > /sys/bus/usb/devices/usb1/power/wakeup
sudo echo 'enabled' > /sys/bus/usb/devices/usb2/power/wakeup
sudo echo 'enabled' > /sys/bus/usb/devices/usb3/power/wakeup
sudo echo 'enabled' > /sys/bus/usb/devices/usb4/power/wakeup
exit
