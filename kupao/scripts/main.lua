require "AudioEngine" 
require "extern"
require "Map"
require "HomeLayer"
require "GameLayer"
require "Role"
require "GameOver"
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
    --加载图片到缓存
    CCTextureCache:sharedTextureCache():addImage("images/parkour.png")
    --加载plist文件
    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("images/parkour.plist") 
    
    CCDirector:sharedDirector():runWithScene(HomeLayer:scene())
end

xpcall(main, __G__TRACKBACK__)
