--util

function round(num)
	return math.floor(num + 0.5)
end

function clamp(val,min,max)
	if val < min then
		return min
	elseif val > max then
		return max
	else
		return val
	end
end