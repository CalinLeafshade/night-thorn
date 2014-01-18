
local mouse = {}

local buttons = 
	{
		l = 0,
		r = 1
	}

function mouse.getX( ... )
	return ags.mouse.x
end

function mouse.getY( ... )
	return ags.mouse.y
end

function mouse.getPosition( ... )
	return mouse.getX(), mouse.getY()
end

function mouse.isDown(b)
	if type(b) == "string" then
		b = buttons[b]
	end
	assert(b, "Mouse button cant be nil/false")
	return ags.mouse.IsButtonDown(b)
end

function mouse.update()
	-- body
end

return mouse