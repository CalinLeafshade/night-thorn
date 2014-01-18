
require('state')

GamePlay = State()

GamePlay.opaque = true

local player = Actor(1,0,0)
local m = Map(require("maps.map1"))
m:attachObject(player)
local cam = Camera()
cam:setLimits(0,0,320,320)

function GamePlay:update(focussed)
	if focussed then 
		local dirs = {"left","right","up","down"}
		for i,v in ipairs(dirs) do
			if lags.keyboard.isDown(v) then
				player:move(v)
			end
		end
		if lags.keyboard.isNew("z") then
			Cutscene:run(function()
				player:say("LOL, This is some funny text")
				player:say("LMAO, I'm saying more silly things.")
			end)
		end
	end
	cam:lookAt(player.x + 8, player.y + 8)
	m:update()
end

function GamePlay:draw()
	cam:attach()
	m:draw()
	cam:detach()
end