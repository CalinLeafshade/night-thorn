
--thread

local thread = 
{
	coroutines = {}
}

function thread.dispatch(block,fn, ...)
	local args = {...}
	if type(block) == "function" then
		table.insert(args,fn)
		fn = block
		block = true
	end
	local co = coroutine.create(fn)
	local result, err = coroutine.resume(co, unpack(args))
	if not result then log(nil, err) end
	table.insert(thread.coroutines, {co = co, blocking = block})
end

function thread.isBlocked()
	return #thread.coroutines > 0
end

function thread.update()
	for i,v in ipairs(thread.coroutines) do
		if coroutine.status(v.co) == "suspended" then
			local result,err = coroutine.resume(v.co, dt)
			if not result then error(err) end
		end
		if coroutine.status(v.co) == "dead" then
			table.remove(thread.coroutines,i)
		end
	end
end

return thread