Land=class("Land", function ( ... )
	-- body
	return CCLayerColor:create(ccc4(0, 0, 0, 125),64,64)
end)
Land.__index=Land

function Land:create( ... )
	-- body
	local this=Land.new()
	this:ignoreAnchorPointForPosition(false)
	this:setVisible(false)
	return this
end
function Land:setPos(x, y, pointTable)
	-- body
	local towerSelect=self:getParent():getChildByTag(2)
	if CCPoint(x,y):equals(CCPoint(self:getPosition(x,y))) and self:isVisible()==true then
		--todo
		self:setVisible(false)
		towerSelect:setVisible(false)
	else
		--todo
		self:setVisible(true)
		self:setPosition(x, y)

		local points=CCRectMake(x-32,y-32,64,64)
		for i,v in ipairs(pointTable) do
			if points:containsPoint(v) then
				--todo
				self:setColor(ccc3(255, 0, 0))
				towerSelect:setVisible(false)
				return
			end
		end
		towerSelect:setVisible(true)
		towerSelect:setPosition(x,y+64)
		self:setColor(ccc3(255, 255, 255))
	end
end
function Land:ctor( ... )
	-- body
end