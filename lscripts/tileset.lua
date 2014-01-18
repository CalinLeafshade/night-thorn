--tileset

Tileset = Class("Tileset")

function Tileset:initialize(spriteID, tileSize)
	self.tiles = {}
	self.tileWidth = tileSize
	self.tileHeight = tileSize
	local sprite = lags.graphics.newSprite(spriteID)
	local i = 0
	for y=0,sprite.Height -1,tileSize do
		for x=0, sprite.Width - 1, tileSize do
			local s = lags.graphics.newSprite(spriteID)
			s:Crop(x,y,tileSize,tileSize)
			i = i + 1
			self.tiles[i] = s
		end
	end
	self.tileCount = i
end

function Tileset:draw(id,x,y)
	if self.tiles[id] then
		lags.graphics.draw(self.tiles[id], x, y)
	end
end