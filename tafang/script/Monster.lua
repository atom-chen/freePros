Monster=class("Monster", function ( MonsterName )
	-- body
	return CCSprite:create("image/monster/".. MonsterName..".png")
end)
Monster.__index= Monster

Monster.monstersTable={}
Monster.name=nil
Monster.life=nil
Monster.nowlife=nil
Monster.value=nil
Monster.speed=nil
Monster.blood=nil
Monster.beginPoint=nil
Monster.endPoint=nil

function Monster:ctor()
	self.name=0
	self.life=0
	self.nowlife=0
	self.value=0
	self.speed=0
	Monster.blood=0
	self.beginPoint=0
	self.endPoint=0
end
function Monster:create(MonsterName)
	local this= Monster.new(MonsterName)
	this.blood=Blood:create(this)
	this.blood:setPosition(32,64)
	this:addChild(this.blood)
	this:getData(MonsterName)
	this:doAction()
	return this
end
--从文件获取怪物数据 
function Monster:getData(MonsterName)
	-- body
	local monsters=CCArray:createWithContentsOfFile("plist/monsterDate.plist")
	tolua.cast(monsters,"CCArray")
	for i=0,monsters:count()-1 do
		dic=monsters:objectAtIndex(i)
		tolua.cast(dic, "CCDictionary")
		--塔的名字
	    self.name=dic:valueForKey("MonsterName"):getCString()
	    if self.name==MonsterName then
	    	--todo
	    	break
	    end
	end
	self.life=tonumber(dic:valueForKey("Life"):getCString())
	self.nowlife=self.life
	self.value=tonumber(dic:valueForKey("Value"):getCString())
	self.speed=tonumber(dic:valueForKey("Speed"):getCString())
end
function Monster:doAction(  )
	-- body
	local texture=CCTextureCache:sharedTextureCache():addImage("image/monster/".. self.name.."_animate.png")
	local frame1= CCSpriteFrame:createWithTexture(texture, CCRectMake(0, 0, 64, 64))
	local frame2= CCSpriteFrame:createWithTexture(texture, CCRectMake(64, 0, 64, 64))

	local frameArr=CCArray:create()
	frameArr:addObject(frame1)
	frameArr:addObject(frame2)

	local animation=CCAnimation:createWithSpriteFrames(frameArr,0.5)
	local animate=CCAnimate:create(animation)
	self:runAction(CCRepeatForever:create(animate))
end
function Monster:move( pathTable )
	-- body
	--判断是否是起点
	if self.beginPoint==0 then
		--todo
		self.beginPoint= pathTable[1]
		self:setPosition(self.beginPoint)
	end

	for i,v in ipairs(pathTable) do
		if self.beginPoint:equals(v) then
			--todo		
			self.endPoint= pathTable[i+1]
		end
	end

	if self.beginPoint.x== self.endPoint.x then
		--todo
		--判断 正反 方向
		if self.beginPoint.y< self.endPoint.y then
			--正
			self:setPositionY(self:getPositionY()+ self.speed)
			if self:getPositionY()> self.endPoint.y then
				self:setPositionY(self.endPoint.y)
				self.beginPoint=self.endPoint
			end
		else
			--反
			self:setPositionY(self:getPositionY()- self.speed)
			if self:getPositionY()< self.endPoint.y then
				self:setPositionY(self.endPoint.y)
				self.beginPoint=self.endPoint
			end
		end
	else
		--横
		if self.beginPoint.x< self.endPoint.x then
			self:setPositionX(self:getPositionX()+ self.speed)
			if self:getPositionX()> self.endPoint.x then
				self:setPositionX(self.endPoint.x)
				self.beginPoint=self.endPoint
			end
		else
			self:setPositionX(self:getPositionX()- self.speed)
			if self:getPositionX()< self.endPoint.x then
				self:setPositionX(self.endPoint.x)
				self.beginPoint=self.endPoint
			end
		end
	end
end