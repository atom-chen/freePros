require("extern")

MyBtns=class("MyBtns",function (imgfile1,imgfile2)
	-- body
	--创建并返回一个菜单
	return CCMenuItemImage:create(imgfile1,imgfile2)
end)
--设置元方法

MyBtns.kom=nil
function MyBtns:create(imgfile1,imgfile2,str,size)
	-- body
	local imgItem=MyBtns.new(imgfile1,imgfile2)
	local word=CCLabelTTF:create(str,"",size)
	word:setPosition(ccp(imgItem:getContentSize().width/2,imgItem:getContentSize().height/2+2))
	imgItem:addChild(word)
	imgItem:setScale(0.85)
	return imgItem
end
function MyBtns:createChar(imgfile1,str)
	-- body
	local imgItem=MyBtns.new(imgfile1,imgfile1)
	local word=CCLabelTTF:create(str,"",25)
	word:setPosition(ccp(imgItem:getContentSize().width/2,imgItem:getContentSize().height/2))
	word:setColor(ccc3(0,0,0))
	imgItem:addChild(word)
	return imgItem
end
function MyBtns:createBg( imgfile1 )
	-- body
	local bgItem=MyBtns.new(imgfile1,imgfile1)
	local bgMenu=CCMenu:createWithItem(bgItem)
	bgMenu:setPosition(ccp(160,240))

	bgItem.kon=CCSprite:create("background.jpg")
	bgItem.kon:setScale(0.76)
	bgItem.kon:setColor(ccc3(255,255,255))
	bgItem.kon:setPosition(ccp(180,285))
	bgItem:addChild(bgItem.kon)

	local clo=CCSprite:create("close.png")
	local cloItem=CCMenuItemSprite:create(clo,clo)
	cloItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		bgMenu:setVisible(false)
	end)
	local cloMenu=CCMenu:createWithItem(cloItem)
	cloMenu:setPosition(ccp(355,565))
	bgItem.kon:addChild(cloMenu)
	return  bgItem
	--return self.kon
end
--构造方法，创建对象时会自动调用
function MyBtns:ctor( ... )
	-- body
end