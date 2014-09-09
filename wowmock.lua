--[[
wowmock - WoW environment mock
Copyright 2014 Adirelle (adirelle@gmail.com)
All rights reserved.
--]]

local wowlua = require('wowlua')


return function(path, mock, ...)
	local chunk = loadfile(path)
	local env = setmetatable({}, {
		__index = function(self, name)
			local value = wowlua[name]
			if value == nil then
				value = globals[name]
			end
			self[name] = value
			return value
		end
	})
	setfenv(chunk, env)
	return chunk(...)
end
