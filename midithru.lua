-- midithru
-- 
--
-- ENC2 - Select MIDI IN device
-- ENC3 - Select MIDI OUT device
--
--
-- 
-- 
--

local midi_in_device = midi.connect(1)
local midi_out_device = midi.connect(2)

function init()
  
  -- Add params
  
  params:add{type = "number", id = "midi_in_device", name = "MIDI IN Device", min = 1, max = 4, default = 1, action = function(value)
	midi_in_device.event = nil
	midi_in_device = midi.connect(value)
	
	midi_in_device.event = function(data)
	  midi_out_device:send(data)
	end
	
  end}
  
  params:add{type = "number", id = "midi_out_device", name = "MIDI Out Device", min = 1, max = 4, default = 2, action = function(value)
	midi_out_device = midi.connect(value)
	midi_out_device.event = nil
  end}
  
  params:bang()
  
end

function enc(n,d)
  if n == 2 then
	if params:get("midi_in_device") + d ~= params:get("midi_out_device") then
	  params:delta("midi_in_device",d)
	end
  elseif n == 3 then
	if params:get("midi_out_device") + d ~= params:get("midi_in_device") then
	  params:delta("midi_out_device",d)
	end
  end
  redraw()
end


function redraw()
  screen.clear()
  screen.move(10,20)
  screen.text("Midi thru")
  screen.move(10,40)
  screen.text(string.format("IN device: %d", params:string("midi_in_device")))
  screen.move(70,40)
  screen.text(string.format("OUT device: %d", params:string("midi_out_device")))
  screen.update()
end


