
require('state')

StateManager = 
{
	stack = {}
}

function StateManager:push(s)
	if self.stack[1] then
		self.stack[1]:onBlur()
	end
	table.insert(self.stack, 1, s)
	self.stack[1]:onFocus()
end

function StateManager:pop()
	local o = table.remove(self.stack,1)
	o:onBlur()
	if self.stack[1] then
		self.stack[1]:onFocus()
	end
end

function StateManager:update()
	for i,v in ipairs(self.stack) do
		v:update(i == 1)
	end
end

function StateManager:draw()
	local toDraw = {}
	for i,v in ipairs(self.stack) do
		toDraw[i] = v
		if v.opaque then
			break
		end
	end
	for i=#toDraw,1,-1 do
		toDraw[i]:draw()
	end
end