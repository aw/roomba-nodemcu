### Makefile for Roomba/NodeMCU project

UPLOAD_PORT = /dev/tty.SLAB_USBtoUART
# UPLOAD_PORT = /dev/tty.usbserial
COMMAND = nodemcu-uploader --port $(UPLOAD_PORT)

.PHONY: all roomba roomba-drive roomba-leds roomba-motors roomba-song roomba-sensors

all: roomba roomba-drive roomba-leds roomba-motors roomba-song roomba-sensors init

init:
		$(COMMAND) upload init.lua --verify=sha1

roomba:
		$(COMMAND) upload roomba.lua --compile --verify=sha1

roomba-drive:
		$(COMMAND) upload roomba-drive.lua --compile --verify=sha1

roomba-leds:
		$(COMMAND) upload roomba-leds.lua --compile --verify=sha1

roomba-motors:
		$(COMMAND) upload roomba-motors.lua --compile --verify=sha1

roomba-song:
		$(COMMAND) upload roomba-song.lua --compile --verify=sha1

roomba-sensors:
		$(COMMAND) upload roomba-sensors.lua --compile --verify=sha1

restart:
		$(COMMAND) node restart
