TopBar=class("TopBar", function ( ... )
	-- body
	return CCLayerColor:create(ccc4(255, 255, 255, 0),896,64)
end)
TopBar.__index=TopBar
TopBar.coinLable=nil
function TopBar:ctor( ... )
	-- body
end
function TopBar:create( ... )
	-- body
	local this=TopBar.new()
	this:ignoreAnchorPointForPosition(false)
	this:setAnchorPoint(ccp(0.5,1))

	local topItem=CCMenuItemImage:create("image/topBar.png","image/topBar.png")
	topItem:registerScriptTapHandler(function ( ... )
		-- body
	end)
	topItem:setScaleX(896.0/960)
	topItem:setAnchorPoint(ccp(0,0))
	topItem:setPosition(0, 0)
	local stopItem=CCMenuItemImage:create("image/play_1.png","image/play_2.png")
	stopItem:registerScriptTapHandler(function ( ... )
		-- body
	end)
	stopItem:setScale(44.0/80)
	stopItem:setPosition(700,32)

	local Items=CCArray:create()
	Items:addObject(topItem)
	Items:addObject(stopItem)
	local menu=CCMenu:createWithArray(Items)
	menu:setPosition(0, 0)
	this:addChild(menu)

	--创建显示图片
	local dollar= CCSprite:create("image/dollar.png")
	dollar:setPosition(20,32)
	this:addChild(dollar)
	--创建分数标签
	this.coinLable= CCLabelTTF:create("0","",40)
	this.coinLable:setColor(ccc3(255, 255, 0))
	this.coinLable:setAnchorPoint(ccp(0,0))
	this.coinLable:setPosition(dollar:boundingBox():getMaxX(), dollar:boundingBox():getMinY())
	this:addChild(this.coinLable)
	
	return this 
end