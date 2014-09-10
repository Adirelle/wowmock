--[[
wowmock - WoW environment mock
Copyright 2014 Adirelle (adirelle@gmail.com)
See LICENSE for usage.
--]]

package.path = package.path .. ';../?.lua'
local LuaUnit = require('luaunit')
local wowlua = require('wowlua')

tests = {}

function tests:test_strjoin()
	assertEquals(wowlua.strjoin(":", "a", "b"), "a:b")
	assertEquals(wowlua.strjoin(":", "a"), "a")
	assertEquals(wowlua.strjoin(":"), "")
end

function tests:test_strsplit()
	assertEquals({wowlua.strsplit(":", "a:b:c")}, {"a", "b", "c"})
	assertEquals({wowlua.strsplit(":", "a:b:c", 2)}, {"a", "b:c"})
	assertEquals({wowlua.strsplit(":", "a")}, {"a"})
	assertEquals({wowlua.strsplit(":", "")}, {""})
end

function tests:test_strconcat()
	assertEquals(wowlua.strconcat("a", "b"), "ab")
	assertEquals(wowlua.strconcat("a"), "a")
end

function tests:test_tContains()
	assertEquals(wowlua.tContains({ 5 }, 5), true)
	assertEquals(wowlua.tContains({ 4 }, 5), false)
end

function tests:test_tostringall()
	assertEquals({wowlua.tostringall("a", 5, false, true, nil)}, {"a", "5", "false", "true", "nil"})
end

os.exit(LuaUnit:Run())
