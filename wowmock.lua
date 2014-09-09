--[[
wowmock - WoW environment mock
Copyright 2014 Adirelle (adirelle@gmail.com)
All rights reserved.
--]]

local function strsplit(delim, str, count)
	if count and count <= 1 then return str end
	local a, b = str:find(delim, 1, true)
	if not a then return str end
	return str:sub(1, a-1), strsplit(delim, str:sub(b+1), count and (count-1))
end

local baseEnv = setmetatable(
	{
		format = string.format,
		gsub = string.gsub,
		tinsert = table.insert,
		tremove = table.remove,
		sort = table.sort,
		wipe = function(t) for k in pairs(t) do t[k] = nil end end,
		strsplit = strsplit,
	},
	{ __index = _G }
)
for key, func in pairs(string) do
	baseEnv["str"..key] = func
end

return function(path, mock, ...)
	local env = setmetatable(
		{},
		{ __index = function(_, name) return baseEnv[name] or mock[name] end }
	)
	local chunk = loadfile(path)
	setfenv(chunk, env)
	return chunk(...)
end
