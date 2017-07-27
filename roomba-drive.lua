-- Roomba control library for NodeMCU / ESP8266
--
-- The MIT License (MIT)
-- Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

-- Drive functions and constants

DRIVE = {
  -- velocity
       velocity_min = -500,
       velocity_max = 500,
  -- radius
         radius_min = -2000,
         radius_max = 2000,
  -- radius special bytes
           straight = 32768,
          clockwise = -1,
  counter_clockwise = 1
}

-- Converts the velocity and radius to hex values, returns a table of decimal values between 0-255
-- Ex: drive_bytes(-200, 200), returns {255, 56, 0, 200}
function drive_bytes(velocity, radius)
  if (velocity < DRIVE.velocity_min or velocity > DRIVE.velocity_max) then return {} end
  if (radius < DRIVE.radius_min or (radius > DRIVE.radius_max and radius ~= DRIVE.straight)) then return {} end

  local hex_velocity = string.format("%x", (2 ^ 16 + velocity))
  local   hex_radius = string.format("%x", (2 ^ 16 + radius))

  return {
    tonumber(string.sub(hex_velocity, -4, -3), 16), -- high byte
    tonumber(string.sub(hex_velocity, -2, -1), 16), -- low byte
    tonumber(string.sub(hex_radius,   -4, -3), 16), -- high byte
    tonumber(string.sub(hex_radius,   -2, -1), 16)  -- low byte
  }
end
