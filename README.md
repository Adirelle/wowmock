wowmock
=======

WoW environment mock for unit testing.

Dependencies
============

wowmock has been designed to work with [luaunit 2.1](https://github.com/rjpcomputing/luaunit) and [mockagne 1.0+](https://github.com/PunchWolf/mockagne), which you can install using [LuaRocks](http://luarocks.org/), but any testing framework and mock libraries that mimics mockagne interface should work.
  
Sample test
===========

```lua
local LuaUnit = require('luaunit')
local mockagne = require('mockagne')
local wowmock = require('wowmock')

local when, verify = mockagne.when, mockagne.verify

-- Mocks
local globals, addon

tests = {}

function tests:setup()

  -- Prepare a addon mock
	addon = mockagne:getMock()
	
	-- Prepare a global mock
	globals = mockagne:getMock()
	
	-- Load the file to test in that environment
	wowmock("FileToTest.lua", globals, "AddonName", addon)
end

function tests:addon_doSomething()
  -- 
	when(globals.UnitSpeed("player")).thenAnswer(7)
	
	-- Call the function to test
	local result = addon.doSomething()
	
	-- Ensure UnitSpeed("player") has been called
	verify(globals.UnitSpeed("player"))
	
	-- Ensure the result returned the expected result
	assertEquals("expectedResult", result)
end

os.exit(LuaUnit:Run())
```
