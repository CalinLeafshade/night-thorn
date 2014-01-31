
require('mapobject')
require('animation')
Actor = Class("Actor", MapObject)

local deltas = 
{
	left = {-1,0},
	right = {1,0},
	up = {0,-1},
	down = {0,1},
}

function Actor:initialize(view,x,y)
	MapObject.initialize(self,x,y)
	self.dir = "down"
	self.animations = 
	{
		left = Animation(view,1),
		right = Animation(view,2),
		up = Animation(view,3),
		down = Animation(view,0)
	}
end

function Actor:face(dir)
	self.dir = dir
end

function Actor:move(dir)
	if not self.moving then
		local x,y = self:getTileXY()
		local d = deltas[dir]
		self.dir = dir
		self.animations[self.dir]:reset()
		if self.map:walkable(x + d[1], y + d[2]) then
			self.moving = dir
		end
	end
end

function Actor:handleMoving()
	if self.moving then
		if self.moving == "up" then
			self.y = self.y - 1
		elseif self.moving == "left" then
			self.x = self.x - 1
		elseif self.moving == "down" then
			self.y = self.y + 1
		else
			self.x = self.x + 1
		end
		self.animations[self.dir]:update()
	end
	if self.x % 16 == 0 and self.y % 16 == 0 then
		self.moving = false
	end
end

function Actor:say(text)
	local gui = GUI(5,130,310,45)
	gui.text = text:sub(1,1)
	local speaking = true
	local i = 0
	while speaking do
		coroutine.yield()
		if gui.text ~= text and i%3 == 0 then
			gui.text = text:sub(1, gui.text:len() + 1)
		end
		i = i + 1
		if lags.keyboard.isNew("z") then
			if gui.text == text then
				speaking = false
			else
				gui.text = text
			end
		end
	end
	gui:destroy()
end

function Actor:update()
	self:handleMoving()	
end

function Actor:draw()
	self.animations[self.dir]:draw(self:getPosition())
end

