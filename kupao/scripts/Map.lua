Map=class("Map", function ( mapX )
	-- body
	--创建并返回一个角色
	return CCTMXTiledMap:create("images/"..mapX..".tmx")
end)

Map.__idex=Map
Map.coins=nil
Map.boxs=nil
Map.bullets=nil
Map.batchE=nil

function Map.create( mapX )
	-- body
	local map=Map.new(mapX)
    batch=CCSpriteBatchNode:create("images/parkour.png")
    map.batchE=CCParticleBatchNode:create("images/stars.png") --粒子渲染
    map:addChild(map.batchE)
    map:addChild(batch)
    map:initCoins()
    map:initBoxs()
    map:initBattery()
	return map
end

function Map:initCoins(  )
	-- body
	-- 获得地图的对象层
	local group = self:objectGroupNamed("coins")
	-- 获得对象层中的对象数组
	local objects = group:getObjects()
	for i=0,objects:count()-1 do
		local obj=objects:objectAtIndex(i)
		tolua.cast(obj, "CCDictionary")
		local x=obj:valueForKey("x"):intValue()
		local y=obj:valueForKey("y"):intValue()
		local coin
		local animation=CCAnimation:create()
		for i=0,7 do
			if i==0 then
				--todo
				 coin=CCSprite:createWithSpriteFrameName("coin"..i..".png")
			end
			local frame=CCSpriteFrameCache:sharedSpriteFrameCache():spriteFrameByName("coin"..i..".png")
			animation:addSpriteFrame(frame)
		end	
		animation:setDelayPerUnit(0.08)
		local animate=CCAnimate:create(animation)
		coin:setPosition(ccp(x,y))
		coin:setScale(0.8)
		batch:addChild(coin)
		coin:runAction(CCRepeatForever:create(animate))	
		table.insert(self.coins,coin)
	end
end

function Map:initBoxs(  )
	-- body
	-- 获得地图的对象层
	local group = self:objectGroupNamed("boxs")
	-- 获得对象层中的对象数组
	local objects = group:getObjects()
	for i=0,objects:count()-1 do
		local obj=objects:objectAtIndex(i)
		tolua.cast(obj, "CCDictionary")
		local x=obj:valueForKey("x"):intValue()
		local y=obj:valueForKey("y"):intValue()
		local box=CCSprite:createWithSpriteFrameName("rock.png")
		box:setAnchorPoint(ccp(0.5,0))
		box:setPosition(ccp(x,y))
		box:setScaleY(0.8)
		box:setScaleX(50.0/56)
		batch:addChild(box)
		table.insert(self.boxs,box)
	end
end
function Map:initBattery(  )
	-- body
	-- 获得地图的对象层
	local group = self:objectGroupNamed("battery")
	-- 获得对象层中的对象数组
	local objects = group:getObjects()
	for i=0,objects:count()-1 do
		local obj=objects:objectAtIndex(i)
		tolua.cast(obj, "CCDictionary")
		local x=obj:valueForKey("x"):intValue()
		local y=obj:valueForKey("y"):intValue()
		local battery=CCSprite:createWithSpriteFrameName("hathpace.png")
		battery:setAnchorPoint(ccp(0.5,0))
		battery:setPosition(ccp(x,y))
		batch:addChild(battery)
		table.insert(self.bullets,battery)
		if #self.bullets==1 then
	 	--todo
	 	schedule(self,function ( ... )
			-- body
			local bullet=CCSprite:create("images/close.png")
			bullet:setPosition(x-20, y+20)
			bullet:setScale(0.6)
			self:addChild(bullet)
			table.insert(self.bullets,bullet)
		end,2)
	end 
	end 

end
--构造方法，创建对象时会自动调用
function Map:ctor( ... )
	-- body
	self.coins={}
	self.boxs={}
	self.bullets={}
end