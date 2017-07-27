-- Roomba control library for NodeMCU / ESP8266
--
-- The MIT License (MIT)
-- Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

-- Song functions and constants

SONG = {
  "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#",
   range_min = 31,
   range_max = 127,
  number_min = 0,
  number_max = 15,
  length_min = 1,
  length_max = 16
}


-- Helper: Generates a table of all notes from 31-127
-- Ex: n=generate_notes(), returns { ["G"][1] = 31, ["G"][2] = 43 }...
-- Can then be used like: n["G"][1] or n["F#"][3]
local function generate_notes()
  local N = {}

  for i = SONG.range_min, SONG.range_max do
    local mod  = (i+5)%12 + 1
    local note = SONG[mod]

    if N[note] == nil then
      N[note] = {}
    end

    table.insert(N[note], i)
  end

  return N
end

-- Helper: Obtains the note number based on the given note
-- Ex: parse_note(all_notes, "F#3"), returns 66
local function parse_note(notes, value)
  if (type(notes) ~= "table") then return nil end

  local note = string.sub(value, 1, -2)
  local  num = tonumber(string.sub(value, -1, -1))

  if (notes[note] == nil) then return nil end

  return notes[note][num]
end

-- Helper: Parses an entire song and returns all the notes and delays (duration)
-- Ex: parse_song_notes({ "G1", 16, "F#3", 16 }), returns { 31 16 66 16}
local function parse_song_notes(notes)
  if (type(notes) ~= "table") then return {} end

  local len = table.getn(notes)
  local mod = len % 2
  if (mod == 1) then return {} end

  local all_notes = generate_notes()
  local res = {}
  for i = 1, len, 2 do
    local m = parse_note(all_notes, notes[i])
    if (m ~= nil) then
      table.insert(res, m)
      table.insert(res, notes[i+1])
    end
  end

  return res
end

-- Ensures the song is valid, returns a table
-- Ex: song_bytes(1, { "G1", 16, "F#3", 16 }), returns { 1 2 31 16 66 16 }
function song_bytes(number, notes)
  local parsed_notes = parse_song_notes(notes)
  local len = table.getn(parsed_notes)

  if (len == 0) then return {} end

  return {
    byte_validate(number, SONG.number_min, SONG.number_max),
    byte_validate((len / 2), SONG.length_min, SONG.length_max),
    unpack(parsed_notes)
  }
end

-- Plays the song specified by its number
-- Ex: play_bytes(3), returns { 3 }
function play_bytes(song)
  return { byte_validate(song, SONG.number_min, SONG.number_max) }
end
