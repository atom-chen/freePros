module("HomeLayer",package.seeall)
function scene(  )
    -- body
    local  s=CCScene:create()
    layer=CCLayer:create()
    init()
    s:addChild(layer)
    return s
end
function init( ... )
	-- body
	local bg=CCSprite:create("images/MainMenu.png")
	bg:setScale(0.5)
	bg:setPosition(240,160)
	layer:addChild(bg)

	local Items=CCArray:create()
	local newItem=CCMenuItemImage:create("images/newgameA.png","images/newgameB.png")
	newItem:registerScriptTapHandler(function ( ... )
		-- body
		CCDirector:sharedDirector():replaceScene(GameLayer:scene())
	end)
	newItem:setScaleX(0.7)
	Items:addObject(newItem)

	local continuItem=CCMenuItemImage:create("images/continueA.png","images/continueB.png")
	continuItem:registerScriptTapHandler(function ( ... )
		-- body
		CCDirector:sharedDirector():popScene()
	end)
	continuItem:setScaleX(0.7)
	Items:addObject(continuItem)

	local menu=CCMenu:createWithArray(Items)
	menu:alignItemsVerticallyWithPadding(25)
	menu:setPosition(240,160)
	layer:addChild(menu)
end
