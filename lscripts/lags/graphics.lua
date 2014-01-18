local floor = math.floor

-- lags graphics

local graphics = {
	font = 1,
	color = {255,255,255,255}
}

local width, height,translation

local function translateCoords(x,y)
	return x + translation[1], y + translation[2]
end 

local low32 = {
  [-1] = 0x000000; -- COLOR_TRANSPARENT
  [ 0] = 0x000000; [ 1] = 0x0000A5; [ 2] = 0x00A500; [ 3] = 0x00A5A5;
  [ 4] = 0xA50000; [ 5] = 0xA500A5; [ 6] = 0xA5A500; [ 7] = 0xA5A5A5;
  [ 8] = 0x525252; [ 9] = 0x5252FF; [10] = 0x52FF52; [11] = 0x52FFFF;
  [12] = 0xFF5252; [13] = 0xFF52FF; [14] = 0xFFFF52; [15] = 0xFFFFFF;
  [16] = 0x000000; [17] = 0x101010; [18] = 0x212121; [19] = 0x313131;
  [20] = 0x424242; [21] = 0x525252; [22] = 0x636363; [23] = 0x737373;
  [24] = 0x848484; [25] = 0x949494; [26] = 0xA5A5A5; [27] = 0xB5B5B5;
  [28] = 0xC6C6C6; [29] = 0xD6D6D6; [30] = 0xE7E7E7; [31] = 0xF7F7F7;
}
 
local function getRGB(agsColor)
  if agsColor < 32 then
    local rgb = low32[agsColor] or 0x000000
    return floor(rgb / 0x10000) % 0x100,
           floor(rgb /   0x100) % 0x100,
                 rgb            % 0x100
  end
  return (floor(agsColor / 0x800) % 0x20) * 8,
         (floor(agsColor /  0x20) % 0x40) * 4,
         (      agsColor          % 0x20) * 8
end

function graphics.line( ... )
	assert(graphics.surface, "no surface active, must be called from lags.draw")
	local t = {...}
	assert(#t >= 4, "At least 4 vertices must be supplied")
	for i=3,#t,2 do
		local x,y,xx,yy = t[i-2], t[i-1], t[i], t[i+1]
		x,y = translateCoords(x,y)
		xx,yy = translateCoords(xx,yy)
		graphics.surface:DrawLine(x,y,xx,yy)
	end
end

function graphics.rect(style, x,y,w,h)
	if style == "fill" then
		x,y = translateCoords(x,y)
		graphics.surface:DrawRectangle(x,y,x+w,y+h)
	else
		graphics.line(x,y,x+w,y,x+w,y+h,x,y+h,x,y)
	end
end

function graphics.newSprite(w,h)
	if h then
		return ags.DynamicSprite.Create(w,h,true)
	else
		return ags.DynamicSprite.CreateFromExistingSprite(w)
	end
end

function graphics.draw(spriteID, x, y, rot, scale,flipX, flipY)
	assert(graphics.surface, "no surface active, must be called from lags.draw")
	if type(spriteID) == "userdata" then
		assert(spriteID.Graphic, "spriteID is not a dynamic sprite or sprite ID")
		spriteID = spriteID.Graphic
	end
	rot = rot or 0
	scale = scale or 1
	local sprite
	if rot ~= 0 or scale ~= 1 or flipX or flipY then
		sprite = ags.DynamicSprite.CreateFromExistingSprite(spriteID)
		if rot ~= 0 then
			sprite:Rotate(rot)
		end
		if scale ~= 0 then
			local w,h = sprite.Width * scale , sprite.Height * scale
			sprite:Resize(w,h)
		end
		if flipX and flipY then
			sprite:Flip(ags.eFlipBoth)
		elseif flipY then
			sprite:Flip(ags.eFlipUpsideDown)
		elseif flipX then 
			sprite:Flip(ags.eFlipLeftToRight)
		end
		spriteID = sprite.Graphic
	end
	x,y = translateCoords(x,y)
	graphics.surface:DrawImage(x,y,spriteID)
end

function graphics.print(text,x,y)
	assert(graphics.surface, "no surface active, must be called from lags.draw")
	x,y = translateCoords(x,y)
	graphics.surface:DrawString(x,y,graphics.font,text)
end

function graphics.setFont(font)
	graphics.font = font
end

function graphics.setColor(r,g,b,a)
	a = a or 255
	if type(r) == "table" then
		graphics.color = r
	else
		graphics.color = {r,g,b,a}
	end
	if graphics.surface then
		graphics.surface.DrawingColor = ags.Game.GetColorFromRGB(graphics.color[1],graphics.color[2],graphics.color[3])
	end
end

function graphics.init()
	width = ags.System.ViewportWidth
	height = ags.System.ViewportHeight
end

function graphics.reset()
	translation = {0,0}
	graphics.setColor(255,255,255,255)
end

function graphics.beginFrame()
	graphics.reset()
	graphics.surface = ags.Room.GetDrawingSurfaceForBackground()
	graphics.surface:Clear()
	graphics.setColor(graphics.color) -- set color properly
end

function graphics.endFrame()
	graphics.surface:Release()
	graphics.surface = nil
end

function graphics.getWidth()
	return width
end

function graphics.getHeight()
	return height
end

function graphics.translate(x,y)
	translation[1] = translation[1] + x
	translation[2] = translation[2] + y
end

return graphics