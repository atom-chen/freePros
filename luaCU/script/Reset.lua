module("Reset",package.seeall)

function scene( ... )
	-- body
	local s=CCScene:create()
	layer=CCLayer:create()
	init()
	s:addChild(layer)
	return s
end
function init( ... )
	-- body
	local bg=CCSprite:create("background.jpg")
    bg:setScale(0.9)
    bg:setPosition(ccp(160,240))
    layer:addChild(bg)

	local backItem=CCMenuItemImage:create("back.png","back.png")
	backItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		CCDirector:sharedDirector():replaceScene(Homelayer:scene())
	end)
	backItem:setScale(0.6)
	local backMenu=CCMenu:createWithItem(backItem)
	backMenu:setPosition(ccp(44,459))
	layer:addChild(backMenu)

	local resetItem=MyBtns:create("green-button.png","green-button-over.png" ,"Reset Games",40)
	resetItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		CCUserDefault:sharedUserDefault():setIntegerForKey("LEVEL",0)
		CCUserDefault:sharedUserDefault():setIntegerForKey("SCORE",0)
		CCUserDefault:sharedUserDefault():setIntegerForKey("SKIPTIMES",2)
		CCUserDefault:sharedUserDefault():setIntegerForKey("ZOOMTIMES",5)
		CCUserDefault:sharedUserDefault():setIntegerForKey("REMOVETIMES",8)
		CCUserDefault:sharedUserDefault():flush()
	end)
	local reMenu=CCMenu:createWithItem(resetItem)
	reMenu:setPosition(ccp(160,30))
	local to=CCMoveTo:create(0.4,ccp(160,330))
	reMenu:runAction(to)
	layer:addChild(reMenu)

	local words1=CCLabelTTF:create("Thanks for playing Close Up Pics!","",15)
	words1:setPosition(ccp(160,260))
	layer:addChild(words1)
	local words2=CCLabelTTF:create("For support email","",15)
	words2:setPosition(ccp(160,240))
	layer:addChild(words2)
	local words3=CCLabelTTF:create("support@meidiaflex.co","",15)
	words3:setPosition(ccp(160,225))
	layer:addChild(words3)
	local words4=CCLabelTTF:create("Images are used on a Creative","",15)
	words4:setPosition(ccp(160,205))
	layer:addChild(words4)
end