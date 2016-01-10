require "AudioEngine" 
require "extern"
require "Homelayer"
require "Gamelayer"
require "First"
require "Reset"
require "Tishi"
require "MyBtns"
-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end

local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
 CCDirector:sharedDirector():runWithScene(First.scene())
end

xpcall(main, __G__TRACKBACK__)
