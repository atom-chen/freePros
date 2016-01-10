
Bullet=class("Bullet", function (bulletName)
	-- body
	return CCSprite:create("image/"..bulletName..".png")
end)

Bullet.__index=Bullet
Bullet.bulletTable={}

Bullet.masterTower=nil
Bullet.speedTable=nil
Bullet.sizeTable=nil
Bullet.hurtTable=nil
Bullet.Speed=nil   --子弹速度
Bullet.Size=nil    --子弹大小
Bullet.Hurt=nil    --子弹伤害
Bullet.grade=nil   --子弹等级
Bullet.target=nil  --子弹目标
Bullet.name=nil

function Bullet:ctor( ... )
	-- body
	self.speedTable={}
	self.sizeTable={}
	self.hurtTable={}
	self.Speed=0
	self.Size=0
	self.Hurt=0
	self.grade=1
	self.name=0
	self.target=0
	self.masterTowe=0
end

function Bullet:create(bulletName,Target,Master)
	-- body
	local this=Bullet.new(bulletName)
	this.target=Target
	this.masterTower=Master
	this:setPosition(Master:getPositionX(),Master:getPositionY())
	this.grade=Master.grade
	this:getBulletData(bulletName)
	this:setScale(this.Size/16)
	return this
end
function Bullet:getBulletData( bulletName )
	-- body
	local bullets=CCArray:createWithContentsOfFile("plist/bulletDate.plist")
	tolua.cast(bullets,"CCArray")
	for i=0,bullets:count()-1 do
		dic=bullets:objectAtIndex(i)
		tolua.cast(dic, "CCDictionary")
		self.name=dic:valueForKey("BULLETNAME"):getCString()
		if self.name==bulletName then
			break
		end
	end
	self:getKeyData( self.speedTable, "SPEED" )
	self:getKeyData( self.sizeTable, "SIZE" )
	self:getKeyData( self.hurtTable, "HURT" )
    self.Speed=self.speedTable[self.grade]
	self.Size=self.sizeTable[self.grade]
	self.Hurt=self.hurtTable[self.grade]
end
function Bullet:getKeyData( localTable,key )
	-- body
	local Arr=dic:objectForKey(key)
	tolua.cast(Arr, "CCArray")
	for i=0,Arr:count()-1 do
		local str=Arr:objectAtIndex(i)
		tolua.cast(str, "CCString")
		table.insert(localTable,tonumber(str:getCString()))
	end
end
function Bullet:move( ... )
	-- body
	local k=(self.target:getPositionY()-self:getPositionY())/(self.target:getPositionX()-self:getPositionX())
	local x1=self:getPositionX()+self.Speed/math.sqrt(k*k+1)
	local x2=self:getPositionX()-self.Speed/math.sqrt(k*k+1)
	local x=nil
	if self.target:getPositionX()>self:getPositionX() then
		x=x1
	else
		x=x2
	end
	self:setPosition(x, k*(x-self:getPositionX())+self:getPositionY())
end