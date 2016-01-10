module("GameScene",package.seeall)
scheduleID=nil

function scene( ... )
	-- body
	local scene=CCScene:create()
	scene:addChild(create())
	return scene
end
function create( ... )
	-- body
	layer=CCLayer:create()
	init()
	layer:registerScriptHandler(onEnterOronExit)
	return layer
end
function init( ... )
	-- body
	level=CCUserDefault:sharedUserDefault():getIntegerForKey("LEVEL")
	--创建地图
	bg=Map:create(level)
	layer:addChild(bg)

	getLevelData()
	--创建土地提示框
	land=Land:create()
	land:setTag(1)
	bg:addChild(land)
	--创建菜单栏
	topBar=TopBar:create()
	topBar:setPosition(480,640)
	topBar:setTag(5)
	bg:addChild(topBar)
	topBar.coinLable:setString(coins)
	--创建塔的菜单
	local towerMenu=CCMenu:create()
	towerMenu:setPosition(0, 0)
	towerMenu:setTag(4)
	bg:addChild(towerMenu)
	--创建选择塔
	towerSelect=TowerSelect:create()
	towerSelect:addTowers(towersArr)
	towerSelect:setTag(2)
	bg:addChild(towerSelect,1)
	--创建升级或卖出提示框
	towerManage=TowerManage:create()
	towerManage:setTag(3)
	bg:addChild(towerManage,1)
	--注册监听
	--CCNotificationCenter:sharedNotificationCenter():registerScriptObserver(layer, createTower, "MY_NOTIFICATION")
	timeCount=4
	--倒计时
	timeLabel=CCLabelTTF:create("","",60)
	timeLabel:setPosition(480,320)
	timeLabel:setColor(ccc3(255,255,0))
	layer:addChild(timeLabel,1)

	tower=Tower:create("bunker")
	bg:addChild(tower)
	tower:setVisible(false)
	monster=Monster:create("misspiggy")
	bullet=Bullet:create(tower.mybullet,monster,tower)
	bg:addChild(bullet)
	getOutData(waves,bg.pathTable,bg,monster.monstersTable)
end
function onEnterOronExit( s )
	-- body	
	if s == "enter"  then
		onEnter()
	elseif s == "exit" then
		onExit()
	end
end
function onEnter( ... )
	-- body
	if not scheduleID then
		--todo
		--状态机定时器
		scheduleID=CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(update, 0, false)
	end
		--开启鼠标点击调用函数
	layer:registerScriptTouchHandler(onTouch)
	--要写在后面
	layer:setTouchEnabled(true)
	schedule(timeLabel,function ( ... )
		-- body
		timeCount=timeCount-1
		if timeCount>0 then
			--todo		
		    timeLabel:setString(tostring(timeCount))
		else
			timeLabel:stopAllActions()
			timeLabel:setVisible(false)
			--layer:setTouchEnabled(true)
		end
	end, 1)
end

function onExit( ... )
	-- body
	if scheduleID then
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(scheduleID)
		scheduleID = nil
	end
	--删除监听
	CCNotificationCenter:sharedNotificationCenter():removeAllObservers(layer)
end
function onTouch(eventType, x, y)
	local x=x- x% 64+ 32
	local y=y- y% 64+ 32
	towerManage:setVisible(false)
	if eventType== "began" then
		land:setPos(x,y,bg.disorderTable)
		return true
	elseif eventType== "moved" then
		land:setPos(x,y,bg.disorderTable)
	else
		--print(eventType) --输出为 ended
	end
end
function update( dt )
	--todo
	createMonGroup( dt )
	if #bullet.bulletTable~=0 then
		--todo
		for i,v in ipairs(bullet.bulletTable) do
			v:move()
		end
	end
	collision()
	if #monster.monstersTable~=0 then
		--todo
		for i,v in ipairs(monster.monstersTable) do
			if v.nowlife<0 then
				for j,w in ipairs(bullet.bulletTable) do
					if w.target==v then
						table.remove(bullet.bulletTable,j)
				        w:removeFromParentAndCleanup(true)
					end
				end
				local coins=tonumber(topBar.coinLable:getString())+v.value
				topBar.coinLable:setString(coins)
				table.remove(monster.monstersTable,i)
				v:removeFromParentAndCleanup(true)
			end
		end
		if #monster.monstersTable==0 then
			num=num+1
			which=0
			print(num)
		end
	end
	if #tower.towerTable~=0 then
		--todo
		for i,v in ipairs(tower.towerTable) do
			v:createBullet(monster.monstersTable ,dt)
		end
	end
end

function getLevelData( ... )
	-- body
	local levels=CCArray:createWithContentsOfFile("plist/levelDate.plist")
	tolua.cast(levels,"CCArray")
	local dic=levels:objectAtIndex(level-1)
	tolua.cast(dic, "CCDictionary")
    coins=dic:valueForKey("Coins"):getCString()

    towersArr=dic:objectForKey("TowerTypes")
    tolua.cast(towersArr,"CCArray")
    waves=dic:objectForKey("Waves")
    tolua.cast(waves,"CCArray")
    waves:retain()
end
function collision( ... )
	-- body
	for i,v in ipairs(bullet.bulletTable) do
		 --local bulletRect=v:boundingBox()
		local point=CCPoint(v:getPositionX(),v:getPositionY())
		local monsterRect=v.target:boundingBox()
		monsterRect=CCRectMake(monsterRect.origin.x-7,monsterRect.origin.y-7,monsterRect.size.width-14,monsterRect.size.height-14)
		--if bulletRect:intersectsRect(monsterRect) then
		if monsterRect:containsPoint(point) then	
			--todo
			v.target.blood:setBlood(v)
			v:removeFromParentAndCleanup(true)
			table.remove(bullet.bulletTable,i)
		end
	end
end
