-- Roomba control library for NodeMCU / ESP8266
--
-- The MIT License (MIT)
-- Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

-- Generic constants and functions

local gpio_dd = 6 -- device detect pin used to wake-up Roomba
local uart_id = 0

local OPCODES = {
    start = 128,
     baud = 129,  -- + 1 byte
  control = 130,
     safe = 131,
     full = 132,
    power = 133,
     spot = 134,
    clean = 135,
      max = 136,
    drive = 137,  -- + 4 bytes
   motors = 138,  -- + 1 byte
     leds = 139,  -- + 3 bytes
     song = 140,  -- + 2 bytes + 2xN bytes (N = # of notes)
     play = 141,  -- + 1 byte
  sensors = 142,  -- + 1 byte
     dock = 143
}

-- Helper: converts a byte to a number which can be sent to Roomba
local function byte2num(hb, lb)
  local hex = string.format("%02X%02X", string.byte(string.char(lb)), string.byte(string.char(hb)))
  return tonumber("0x" .. hex, 10)
end

-- Helper: Validates a value based on min and max values, defaults to min
function byte_validate(value, min, max)
  if (type(value) == "number" and value >= min and value <= max) then
    return value
  else
    return min
  end
end

-- Send a message to Roomba over uart
function roomba_write(opcode, args)
  if (opcode < OPCODES.start or opcode > OPCODES.dock) then return end

  local bytes = args or {}
  uart.alt(1)
  uart.write(uart_id, string.char(opcode, unpack(bytes)))
  tmr.delay(25000) -- 25 milliseconds delay between each command
  uart.alt(0)
end

-- Setup, should only run once per boot
-- NOTE: switches to the alternate uart temporarily, to control Roomba on D7/D8
local function roomba_setup()
  uart.alt(1)
  gpio.mode(gpio_dd, gpio.INPUT)
  gpio.write(gpio_dd, gpio.LOW) -- wake up
  tmr.delay(500000) -- wait 500ms
  gpio.write(gpio_dd, gpio.HIGH)
  uart.setup(uart_id, 115200, 8, uart.PARITY_NONE, uart.STOPBITS_1, 1)
  uart.alt(0)
end

roomba_setup()

dofile("roomba-drive.lua")
dofile("roomba-leds.lua")
dofile("roomba-motors.lua")
dofile("roomba-song.lua")

local function drive_clockwise_example()
  roomba_write(OPCODES.start) -- start
  roomba_write(OPCODES.control) -- control
  roomba_write(OPCODES.drive, drive_bytes(200, DRIVE.clockwise)) -- spin
end

drive_clockwise_example()
