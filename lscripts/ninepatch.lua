
NinePatch = Class("NinePatch")

function NinePatch:initialize(spriteID, c)
	self.corner = c -- corner width
	self.images = {}
	self.images.topLeft = lags.graphics.newSprite(spriteID)
	self.images.topLeft:Crop(0,0,c,c)
	
end