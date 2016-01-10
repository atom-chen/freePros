Tower=class("Tower", function (towerName)
	-- body
	return CCMenuItemImage:create(towerName,towerName)
end)

Tower.__index=Tower
Tower.towerTable={}    --放塔的表
Tower.countTime=nil    --计时发子弹

Tower.statusUp="up"
Tower.statusSale="sale"
Tower.statusCre="create"
Tower.status=nil

Tower.name=nil
Tower.grade=nil   --等级
Tower.mybullet=nil    --塔发射的子弹

Tower.costTable=nil   --升级所需的钱
Tower.saleTable=nil   --销毁塔获得的钱
Tower.rateTable=nil    --塔发射子弹的频率
Tower.radiusTable=nil --攻击半径

Tower.radius=nil
Tower.cost=nil
Tower.sale=nil
Tower.rate=nil --发射子弹的频率

--先执行create到new,再执行构造函数,再继续执行reate剩下的语句
function Tower:create(towerName)
	-- body
	local this=Tower.new("image/tower/"..towerName.."1.png")
	this:registerScriptTapHandler(function ( ... )
		-- body
		if this.status==Tower.statusCre then
			this:createTower()
		else
			local bg=this:getParent():getParent()   --第一个parent是TowerSelect
			local land=bg:getChildByTag(1)
			land:setVisible(false)
			local towerSelect=bg:getChildByTag(2)
			towerSelect:setVisible(false)
			local towerManage=bg:getChildByTag(3)
			towerManage:setVis(this)
		end
	end)
	this:getTowerData(towerName)
	return this
end
function Tower:createTower()
	-- body
	local towerSelect=self:getParent():getParent()  --第一个parent是菜单
	local bg=towerSelect:getParent()
	local land=bg:getChildByTag(1)
	local topBar=bg:getChildByTag(5)
	local towerMenu=bg:getChildByTag(4)

	towerSelect:setVisible(false)
	land:setVisible(false)
	local tower=self:create(self.name)
	table.insert(self.towerTable,tower)
	tower:setPosition(towerSelect:getPositionX(),towerSelect:getPositionY()-64)
	towerMenu:addChild(tower)
	topBar.coinLable:setString(tostring(tonumber(topBar.coinLable:getString())-tower.cost))  --改变金币文本
	--使用监听
	--CCNotificationCenter:sharedNotificationCenter():postNotification("MY_NOTIFICATION")
end
function Tower:createBullet(monstersTable ,dt)
	-- body
	self.countTime=self.countTime+dt
	if self.countTime>self.rate and #monstersTable~=0 then
		--todo
		for i,v in ipairs(monstersTable) do
			--获得塔与动物的距离
			local distance=math.sqrt(math.pow(self:getPositionX()-v:getPositionX(), 2)+math.pow(self:getPositionY()-v:getPositionY(), 2))
			if distance<=self.radius then  --距离小于攻击范围
				--todo
				local bullet=Bullet:create(self.mybullet,v,self)
				table.insert(bullet.bulletTable,bullet)
				self:getParent():getParent():addChild(bullet)
				self.countTime=0
				break
			end
		end
	end
end
function Tower:upGrade(  )
	-- body
	if self.grade<3 then
		--todo
		self.grade= self.grade+1
	    self.cost=self.costTable[self.grade]
		self.sale=self.saleTable[self.grade]
		self.rate=self.rateTable[self.grade]
		self.radius=self.radiusTable[self.grade]
		--改变塔的纹理
		local frame= CCSpriteFrame:create("image/tower/".. self.name.. self.grade.. ".png", CCRectMake(0, 0, 64, 64)	)
		self:setNormalSpriteFrame(frame)
		self:setSelectedSpriteFrame(frame)
	end
end
function Tower:Sale(  )
	-- body
	self:removeFromParentAndCleanup(true)
	--从表里删除
	for i,v in ipairs(Tower.towerTable) do
		if v==self then
			table.remove(Tower.towerTable,i)
		end
	end
end
function Tower:ctor( ... )
	-- body
	self.name=0
	self.mybullet=0
	self.countTime=0
	self.costTable={}
	self.saleTable={}
	self.rateTable={}
	self.radiusTable={}
	self.status=Tower.statusUp
	self.grade=1 
	self.cost=0
	self.sale=0
	self.rate=0
	self.radius=0
end
function Tower:getTowerData( towerName )
	-- body
	local towers=CCArray:createWithContentsOfFile("plist/towerDate.plist")
	tolua.cast(towers,"CCArray")
	--塔的名字
	for i=0,towers:count()-1 do
		dic=towers:objectAtIndex(i)
		tolua.cast(dic, "CCDictionary")
		self.name=dic:valueForKey("TOWERNAME"):getCString()
		if self.name==towerName then
			break
		end
	end
	self.mybullet=dic:valueForKey("MYBULLET"):getCString()
	self:getKeyData( self.costTable,"COST" )
	self:getKeyData( self.saleTable, "SALE" )
	self:getKeyData( self.rateTable,"RATE" )
	self:getKeyData( self.radiusTable,"RADIUS" )
    self.cost=self.costTable[self.grade]
	self.sale=self.saleTable[self.grade]
	self.rate=self.rateTable[self.grade]
	self.radius=self.radiusTable[self.grade]
end
function Tower:getKeyData( localTable,key )
	-- body
	local Arr=dic:objectForKey(key)
	tolua.cast(Arr, "CCArray")
	for i=0,Arr:count()-1 do
		local str=Arr:objectAtIndex(i)
		tolua.cast(str, "CCString")
		table.insert(localTable,tonumber(str:getCString()))
	end
end
