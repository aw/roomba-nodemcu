-- Roomba control library for NodeMCU / ESP8266
--
-- The MIT License (MIT)
-- Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

-- Leds functions and constants

LEDS = {
         status = {
          amber = 48,
          green = 32,
            red = 16
        },
          spot = 8,
         clean = 4,
           max = 2,
   dirt_detect = 1,
  -- bits
     range_min = 0,
     range_max = 63,
     color_min = 0,
     color_max = 255,
 intensity_min = 0,
 intensity_max = 255
}

-- Ensures the selected leds are valid, returns a table of decimal values between 0-64, and 0-255
-- Ex: leds_bytes(LEDS.spot + LEDS.status.green, 128, 255), returns { 40, 128, 255 }
function leds_bytes(leds, color, intensity)
  return {
    byte_validate(leds, LEDS.range_min, LEDS.range_max),
    byte_validate(color, LEDS.color_min, LEDS.color_max),
    byte_validate(intensity, LEDS.intensity_min, LEDS.intensity_max)
  }
end
