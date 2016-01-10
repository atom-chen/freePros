Map=class("Map", function ( level )
	-- body
	return CCTMXTiledMap:create("tmx/level_"..level .. ".tmx")
end)
Map.__index=Map

Map.pathTable=nil
Map.disorderTable=nil
function Map:ctor( ... )
	-- body
	self.pathTable={}
	self.disorderTable={}
end

function Map:create( level )
	-- body
	local this=Map.new(level)
		--获得地图的点
	this:getObjectsPoint(this.disorderTable,"disorder")
	this:getObjectsPoint(this.pathTable,"path")
	local texture=CCTextureCache:sharedTextureCache():addImage("image/animation1.png")
	local frameArr=CCArray:create()
	for i=0,3 do
		local frame=CCSpriteFrame:createWithTexture(texture,CCRectMake(i*64,0,64,64))
		if i==0 then
			player=CCSprite:createWithSpriteFrame(frame)
			--player:setAnchorPoint(ccp(0,0.5))
			player:setPosition(this.pathTable[1])
			this:addChild(player)
		end
		frameArr:addObject(frame)
	end
	local animation=CCAnimation:createWithSpriteFrames(frameArr,0.2)
	local animate=CCAnimate:create(animation)
	player:runAction(CCRepeatForever:create(animate))
	return this
end
function Map:getObjectsPoint( Table,str )
	-- body
	local group= self:objectGroupNamed(str)
	local objects= group:getObjects()
	for i=0, objects:count()- 1 do
		local obj= objects:objectAtIndex(i)
		tolua.cast(obj, "CCDictionary")
		local x= obj:valueForKey("x"):intValue()
		local y= obj:valueForKey("y"):intValue()
		local point= CCPoint(x,y)
		table.insert(Table, point)
	end 
end