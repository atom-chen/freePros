require("extern")
require("MonsterGroup")
require "AudioEngine" 
require("GameScene")
require("Land")
require("Tower")
require("TowerSelect")
require("Monster")
require("TowerManage")
require("HomeScene")
require("TopBar")
require("Bullet")
require("Map")
require("Blood")
-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(msg) .. "\n")
    print(debug.traceback())
    print("----------------------------------------")
end
LSSize= CCSizeMake(960, 640)
local function main()
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)
    --分辨率
    CCDirector:sharedDirector():getOpenGLView():setDesignResolutionSize(960,640,kResolutionNoBorder)
    CCDirector:sharedDirector():runWithScene(HomeScene:scene())
end

xpcall(main, __G__TRACKBACK__)
