--lags init

local NULLFUNC = function() end

lags = {
	load = NULLFUNC,
	update = NULLFUNC,
	draw = NULLFUNC,
	onKeyDown = NULLFUNC,
	onKeyUp = NULLFUNC
}

lags.graphics = require('lags.graphics')
lags.mouse = require('lags.mouse')
lags.keyboard = require('lags.keyboard')
lags.thread = require('lags.thread')

local time = 0

function lags.getTime( ... )
	return time
end

function lags.init()
	lags.graphics.init()
	require("main")
	lags.load()
end

function lags.frame()
	time = time + 1 / ags.GetGameSpeed()
	lags.keyboard.update()
	lags.mouse.update()
	lags.thread.update()
	lags.update()
	lags.graphics.beginFrame()
	lags.draw()
	lags.graphics.endFrame()
end

function lags.quit(ask)
	ask = ask or 0
	ags.QuitGame(ask)
end
