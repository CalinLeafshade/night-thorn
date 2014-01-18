
require("tileset")

Map = Class("Map")

local tileset = Tileset(1,16,16)

function Map:initialize(def)
	self.objects = {}
	self.layers = {}
	self.width = def.width
	self.height = def.height
	for i,v in ipairs(def.layers) do
		if v.type == "tilelayer" then
			self:processTileLayer(v)
		else
			self:processObjectLayer(v)
		end
	end
end

Map.objectProcessors = 
{
	exit = function(map,obj)
		-- body
	end
}

function Map:processObjectLayer(layer)
	for i,v in ipairs(layer.objects) do
		self.objectProcessors[v.type:lower()](self, v)
	end
	table.insert(self.layers, {type = "objectlayer"})
end

function Map:processTileLayer(layer)
		local l = {}
		l.name = layer.name:lower()
		l.opacity = layer.opacity
		l.width = layer.width
		l.height = layer.height
		l.type = l.name == "collision" and "collision" or "tilelayer"
		local i = 1
		l.data = {}
		for y=0,l.height - 1 do
				for x=0,l.width - 1 do
						l.data[x] = l.data[x] or {}
						l.data[x][y] = layer.data[i]
						i = i + 1
				end
		end
		self.layers[l.name] = l
		table.insert(self.layers, l)
end

function Map:sane(x,y)
	return x >= 0 and x < self.width and y >=0 and y < self.height
end

function Map:walkable(x,y)
	if self:sane(x,y) and self.layers.collision then
		return self.layers.collision.data[x][y] == 0
	else
		return false
	end
end

function Map:drawObjects( ... )
	for i,v in pairs(self.objects) do
		v:draw()
	end
end

function Map:attachObject(obj)
	self.objects[obj] = obj
	obj.map = self
end

function Map:update()
	for i,v in pairs(self.objects) do
		v:update()
	end
end

function Map:draw(lowerX, lowerY, upperX, upperY)
	lowerX = lowerX or 0
	lowerY = lowerY or 0
	upperX = upperX or self.width - 1
	upperY = upperY or self.height - 1
	for _,layer in ipairs(self.layers) do 
		if layer.type == "tilelayer" then
			for x=lowerX, upperX do
				for y=lowerY, upperY do
					local tile = layer.data[x][y]
					tileset:draw(tile,x * tileset.tileWidth, y * tileset.tileHeight)
				end
			end
		else
			self:drawObjects()
		end
	end
end