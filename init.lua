-- Roomba control library for NodeMCU / ESP8266
--
-- The MIT License (MIT)
-- Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

-- Init

uart.alt(0)

-- timer to ensure we can kill the code if something is busted
tmr.alarm(0, 5000, tmr.ALARM_SINGLE, function()

  dofile("roomba.lc")

  function drive_clockwise_example()
    roomba_write(OPCODES.start) -- start
    roomba_write(OPCODES.control) -- control
    roomba_write(OPCODES.drive, drive_bytes(200, DRIVE.clockwise)) -- spin
  end

  tmr.delay(3000000)
  gpio.write(0, gpio.LOW) -- orange led on

  drive_clockwise_example()

  tmr.delay(3000000)
  gpio.write(0, gpio.HIGH) -- orange led off
end)
