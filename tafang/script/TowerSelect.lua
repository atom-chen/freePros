TowerSelect=class("TowerSelect", function (  )
	-- body
	return CCLayerColor:create(ccc4(0, 0, 0, 125))
end)
TowerSelect.__index= TowerSelect

function TowerSelect:ctor()
end
function TowerSelect:create(  )
	-- body
	local this=TowerSelect.new()
	this:ignoreAnchorPointForPosition(false)
	this:setVisible(false)	
	return this
end
function TowerSelect:addTowers( towersArr )
	-- body
	self:setContentSize(CCSizeMake(64*towersArr:count(),70))
	local Items=CCArray:create()
	for i=0,towersArr:count()-1 do
		local str=towersArr:objectAtIndex(i)
		tolua.cast(str, "CCString")
		local tower= Tower:create(str:getCString())
		tower.status=Tower.statusCre
		tower:setPosition(64*i+32,25)
		Items:addObject(tower)

		local costLable=CCLabelTTF:create(tostring(tower.cost),"",25)
		costLable:setColor(ccc3(255, 255, 0))
		costLable:setPosition(64*i+32,55)
		self:addChild(costLable,1)
	end
	local menu=CCMenu:createWithArray(Items)
	menu:setPosition(0, 0)
	self:addChild(menu)
end