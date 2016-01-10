Role=class("Role", function ( file )
	-- body
	--创建并返回一个角色
	return CCSprite:createWithSpriteFrameName(file)
end)
--设置元方法
Role.__index=Role

Role.ystartSpeed=19
Role.accele=1
Role.nowySpeed=0

Role.statusUp="up"
Role.statusDown="down"
Role.statusRun="run"
Role.statusDie="die"
Role.statusSlip="slip"
Role.nowStatus=Role.statusRun

function Role.create( ... )
	-- body	
	local role=Role.new("runner0.png")
	return role
end
function Role:run( ... )
	-- body
	if self:getActionByTag(1) then
		--todo
	else
		--todo
		self:stopAllActions()
		local animationRun=CCAnimation:create()
		for i=1,7 do
		    local frame=CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("runner"..i..".png")
		    animationRun:addSpriteFrame(frame)
		end	
		animationRun:setDelayPerUnit(0.08)
		animationRun:setLoops(-1)
		local animateRun=CCAnimate:create(animationRun)
		animateRun:setTag(1)
		self:runAction(animateRun)
		--self:runAction(CCRepeatForever:create(animateRun))	
	end
end
function Role:up( ... )
	-- body
	if self:getActionByTag(2) then
		--todo
	else
		--todo
		self:stopAllActions()
		local animationUp=CCAnimation:create()
		for i=0,3 do
			local frame=CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("runnerJumpUp"..i..".png")
			animationUp:addSpriteFrame(frame)
		end
		animationUp:setDelayPerUnit(0.08)
		animationUp:setLoops(-1)
		local animateUp=CCAnimate:create(animationUp)	
		animateUp:setTag(2)
		self:runAction(animateUp)
		--初始速度
		self.nowySpeed=self.ystartSpeed
	end

	local y=self:getPositionY()
	self.nowySpeed=self.nowySpeed-self.accele
	y=y+self.nowySpeed
	self:setPositionY(y)
	if self.nowySpeed<=0 then
		--todo
		self.nowStatus=Role.statusDown
	end
end
function Role:down( ... )
	-- body
	if self:getActionByTag(3) then
		--todo
	else
		--todo
		self:stopAllActions()
		local animationDown=CCAnimation:create()
		for i=0,1 do
		    local frame=CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("runnerJumpDown"..i..".png")
		    animationDown:addSpriteFrame(frame)
		end	
		animationDown:setDelayPerUnit(0.08)
		animationDown:setLoops(-1)
		local animateDown=CCAnimate:create(animationDown)
		animateDown:setTag(3)
		self:runAction(animateDown)
		self.nowySpeed=0
	end

	local y=self:getPositionY()
	self.nowySpeed=self.nowySpeed+self.accele
	y=y-self.nowySpeed
	self:setPositionY(y)
end
function Role:die( ... )
	-- body
	CCDirector:sharedDirector():replaceScene(GameOver:scene())
end
function Role:slip( ... )
	-- body
	if self:getActionByTag(4) then
		--todo
	else
		--todo
		self:stopAllActions()
		local animationSlip=CCAnimation:create()
		for i=1,7 do
		    local frame=CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("runnerCrouch0.png")
		    animationSlip:addSpriteFrame(frame)
		end	
		animationSlip:setDelayPerUnit(0.08)
		animationSlip:setLoops(-1)
		local animateSlip=CCAnimate:create(animationSlip)
		animateSlip:setTag(4)
		self:runAction(animateSlip)	
	end
end
--构造方法，创建对象时会自动调用
function Role:ctor( ... )
	-- body
end
