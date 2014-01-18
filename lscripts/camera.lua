-- camera

Camera = Class("Camera")

function Camera:initialize()
	self.x = 0
	self.y = 0
	self.w = lags.graphics:getWidth()
	self.h = lags.graphics.getHeight()
	self.limits = {-math.huge,-math.huge,math.huge,math.huge}
end

function Camera:setLimits(x,y,x2,y2)
	self.limits = {x,y,x2,y2}
end

function Camera:move(dx,dy)
	self.x = self.x + dx
	self.y = self.y + dy
end

function Camera:lookAt(x,y)
	self.x = x - self.w / 2
	self.y = y - self.h / 2
end

function Camera:attach()
	self.x = clamp(self.x, self.limits[1], self.limits[3] - self.w)
	self.y = clamp(self.y, self.limits[2], self.limits[4] - self.h)
	lags.graphics.translate(-self.x,-self.y)
end

function Camera:detach()
	lags.graphics.translate(self.x, self.y)
end
