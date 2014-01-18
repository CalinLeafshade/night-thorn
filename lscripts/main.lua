--main
require("util")

Class = require('lib.middleclass')
require('statemanager')
require("map")
require("camera")
require("actor")
require('states.gameplay')
require('states.cutscene')
require('gui')

function lags.load()
	StateManager:push(GamePlay)
end

function lags.onKeyDown( key )
	if key == "Q" then
		lags.quit()
	end
end

function lags.update( ... )
	StateManager:update()	
end

function lags.draw( ... )
	StateManager:draw()
	for i,v in pairs(GUIs) do
		v:draw()
	end
end