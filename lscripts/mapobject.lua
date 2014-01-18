
MapObject = Class("MapObject")

function MapObject:initialize(x,y)
	self.x = x or 0
	self.y = y or 0
end

function MapObject:getPosition()
	return self.x, self.y
end

function MapObject:getTileXY()
	return math.floor(self.x / 16), math.floor(self.y / 16)
end