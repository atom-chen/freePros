Blood=class("Blood", function ( ... )
	-- body
	return CCLayerColor:create(ccc4(0, 0, 0, 255),55,7)
end)

Blood.__index=Blood
Blood.master=nil
Blood.bloodBar=nil
function Blood:ctor( ... )
	-- body
	self.master=0
	--self.bloodBar=0
end

function Blood:create( Master )
	-- body
	local this=Blood.new()
	this:ignoreAnchorPointForPosition(false)
	this.master=Master
	this.bloodBar=CCLayerColor:create(ccc4(255, 0, 0, 255),55,7)
	this:addChild(this.bloodBar)
	return this
end
function Blood:setBlood( bullet )
	-- body
	self.master.nowlife=self.master.nowlife-bullet.Hurt
	if self.master.nowlife>0 then
		--todo
		local scaleBlood=self.master.nowlife/self.master.life
		self.bloodBar:setContentSize(CCSizeMake(64*scaleBlood,7))
	end
end