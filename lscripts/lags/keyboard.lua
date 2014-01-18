
--lags.keyboard

local keyboard = {}


local function buildCharMap(from,to)
	local o = {}
	for i=from,to do
		o[string.char(i)] = i
	end
	return o
end

local keys = buildCharMap(65,90)
local downKeys
local lastDownKeys

keys.UP = 372
keys.LEFT = 375
keys.DOWN = 380
keys.RIGHT = 377
keys.SPACE = 32

function keyboard.isDown(key)
	return downKeys[key:upper()]
end

function keyboard.isNew(key)
	return downKeys[key:upper()] and not lastDownKeys[key:upper()]
end

function keyboard.update( ... )
	lastDownKeys = downKeys
	downKeys = {}
	for i,v in pairs(keys) do
		downKeys[i] = ags.IsKeyPressed(v)
		if lastDownKeys then
			if downKeys[i] and not lastDownKeys[i] then
				lags.onKeyDown(i)
			elseif not downKeys[i] and lastDownKeys[i] then
				lags.onKeyUp(i)
			end
		end
	end
end

return keyboard
