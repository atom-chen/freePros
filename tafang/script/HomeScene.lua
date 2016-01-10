module("HomeScene",package.seeall)
function scene( ... )
	-- body
	local scene=CCScene:create()
	scene:addChild(create())
	return scene
end
function create( ... )
	-- body
	layer=CCLayer:create()
	init()
	return layer
end
function init( ... )
	-- body
	local bg=CCSprite:create("image/background.png")
	bg:setScale(2)
	bg:setPosition(ccp(LSSize.width/ 2, LSSize.height/ 2))
	layer:addChild(bg)	
	createMenu()
end
function createMenu( ... )
	-- body
	local newGameItem= CCMenuItemImage:create("image/newGame.png","image/newGame-over.png")
	newGameItem:setPosition(LSSize.width/ 4, LSSize.height/ 6* 5)
	newGameItem:registerScriptTapHandler(function ( ... )
		CCUserDefault:sharedUserDefault():setIntegerForKey("LEVEL", 1)
		CCUserDefault:sharedUserDefault():flush()
	    CCDirector:sharedDirector():replaceScene(GameScene:scene())
	end)

	local startGameItem= CCMenuItemImage:create("image/startGame.png","image/startGame-over.png")
	startGameItem:setPosition(LSSize.width/ 2, LSSize.height/ 4* 3)
	startGameItem:registerScriptTapHandler(function ( ... )
		CCUserDefault:sharedUserDefault():setIntegerForKey("LEVEL", 1)
		CCUserDefault:sharedUserDefault():flush()
	    CCDirector:sharedDirector():replaceScene(GameScene:scene())
	end)

	local Items= CCArray:create()
	Items:addObject(newGameItem)
	Items:addObject(startGameItem)

	local menu= CCMenu:createWithArray(Items)
	menu:setPosition(0, 0)
	layer:addChild(menu)
end
-- function createEffect( ... )
-- 	local temp= CCDictionary:createWithContentsOfFile("plist/monsterDate.plist")
-- 	local obj= temp:objectForKey("all")
-- 	tolua.cast(obj, "CCArray")
-- 	local n= math.random(5, 10)
-- 	for i= 1, n do
-- 		local cStr= obj:objectAtIndex(math.random(0,obj:count()- 1)	)
-- 		tolua.cast(cStr, "CCString")
-- 		local monster= Monster.create(cStr:getCString()	)
-- 		monster:setPosition(math.random(0, LSSize.width), math.random(0, LSSize.height/ 2)	)
-- 		this:addChild(monster)
-- 	end

-- 	return this
-- end