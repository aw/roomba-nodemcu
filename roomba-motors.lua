-- Roomba control library for NodeMCU / ESP8266
--
-- The MIT License (MIT)
-- Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

-- Motors functions and constants

MOTORS = {
  main_brush = 4,
      vacuum = 2,
  side_brush = 1,
  -- bits
   range_min = 0,
   range_max = 7
}

-- Ensures the selected motors are valid, returns a table with a decimal value between 0-7
-- Ex: motors_bytes(MOTORS.main_brush + MOTORS.vacuum), returns 6
function motors_bytes(motors)
  return { byte_validate(motors, MOTORS.range_min, MOTORS.range_max) }
end
