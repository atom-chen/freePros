module("First",package.seeall)
local function init(layer)
	-- body
	local bg=CCSprite:create("Default.png")
	bg:setPosition(ccp(160,240))
	layer:addChild(bg)

	local actionArr=CCArray:create()
	local fadein=CCFadeIn:create(2)
	actionArr:addObject(fadein)
	local cal=CCCallFunc:create(function ( ... )
		-- body
		CCDirector:sharedDirector():replaceScene(Homelayer.scene())
	end)
	actionArr:addObject(cal)
	local quence=CCSequence:create(actionArr)
	bg:runAction(quence)
end

function scene( ... )
	-- body
	local s=CCScene:create()
	local layer=CCLayer:create()
	init(layer)
	s:addChild(layer)
	return s
end
