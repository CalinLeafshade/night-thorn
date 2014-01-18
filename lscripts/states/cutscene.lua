

Cutscene = State()

Cutscene.opaque = false

function Cutscene:run(fn)
	StateManager:push(self)
	self.coroutine = coroutine.create(fn)
end

function Cutscene:draw()
	lags.graphics.print("In Cutscene", 5,5)
end

function Cutscene:update(focussed)
	if coroutine.status(self.coroutine) == "suspended" then
		local result,err = coroutine.resume(self.coroutine)
		if not result then error(err) end
	end
	if coroutine.status(self.coroutine) == "dead" then
		StateManager:pop()
	end
end