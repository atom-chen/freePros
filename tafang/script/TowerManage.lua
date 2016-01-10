TowerManage=class("TowerManage", function ( ... )
	-- body
	return CCLayerColor:create(ccc4(255, 255, 255, 0),384,384)
end)
TowerManage.__index=TowerManage
TowerManage.masterTower=nil
function TowerManage:ctor( ... )
	-- body
end
function TowerManage:create( ... )
	-- body
	local this=TowerManage.new()
	this:ignoreAnchorPointForPosition(false)
	this:setVisible(false)
	this:addItem()
	return this
end
function TowerManage:addItem( ... )
	-- body
	coverItem=CCMenuItemImage:create("image/boundary.png","image/boundary.png")
	coverItem:registerScriptTapHandler(function ( ... )
		-- body
		self:setVisible(false)
	end)
	coverItem:setOpacity(125)
	coverItem:setPosition(192,192)
	local menu1=CCMenu:createWithItem(coverItem)
	menu1:setPosition(0, 0)
	self:addChild(menu1)

	local Items=CCArray:create()
	local upItem=CCMenuItemImage:create("image/upgrade.png","image/upgrade.png")
	upItem:registerScriptTapHandler(function ( ... )
		-- body
		--执行升级任务
		self.masterTower:upGrade()
		self:setVisible(false)
		local topBar=self:getParent():getChildByTag(5)
		topBar.coinLable:setString(tostring(tonumber(topBar.coinLable:getString())-self.masterTower.cost))
	end)
	upItem:setTag(1)
	upItem:setPosition(192, 192+64*0.6)
	local upLable=CCLabelTTF:create("144","",25)
	upLable:setColor(ccc3(255, 255, 0))
	upLable:setPosition(upItem:getPositionX(),upItem:getPositionY()+30)
	self:addChild(upLable,1)

	local saleItem=CCMenuItemImage:create("image/closeBtn.png","image/closeBtn-over.png")
	saleItem:registerScriptTapHandler(function ( ... )
		-- body
		local topBar=self:getParent():getChildByTag(5)
		topBar.coinLable:setString(tostring(tonumber(topBar.coinLable:getString())+self.masterTower.sale))
		self.masterTower:Sale()
		self:setVisible(false)
	end)
	saleItem:setTag(2)
	saleItem:setPosition(192, 192-64*0.6)
	local saleLable=CCLabelTTF:create("144","",25)
	saleLable:setColor(ccc3(255, 255, 0))
	saleLable:setPosition(saleItem:getPositionX(),saleItem:getPositionY()-30)
	self:addChild(saleLable,1)
	Items:addObject(saleItem)
	Items:addObject(upItem)
	local menu=CCMenu:createWithArray(Items)
	menu:setPosition(0, 0)
	self:addChild(menu)
end
function TowerManage:setVis( tower )
	-- body
	self:setVisible(true)
	self:setPosition(tower:getPositionX(),tower:getPositionY())
	self.masterTower=tower
	coverItem:setScale(tower.radius/32)
end
