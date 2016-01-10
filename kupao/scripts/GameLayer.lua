module("GameLayer",package.seeall)

scheduleID=nil
speedX=4
math.randomseed(os.time())

function scene(  )
    -- body
    local  s=CCScene:create()
    s:addChild(create())
    return s
end
function create( ... )
	-- body
	layer=CCLayerColor:create(ccc4(255,0,0,255))
	init()
	layer:registerScriptHandler(onEnterOronExit)
	return layer
end

function init( ... )
	-- body
	map1=Map.create("map"..math.random(1,6))
	--map1=Map.create("map6")
	map2=nil
	layer:addChild(map1)

	--人物初始化
	player=Role.create()
	player:setAnchorPoint(ccp(0.5,0))
	 --player:setScale(0.8)
	player:setPosition(ccp(152,32))
	layer:addChild(player,1)	

	timeCount=-1
	scoreCount=0
	distCount=0

	--返回按钮
	local backItem=CCMenuItemImage:create("images/backA.png","images/backB.png")
	backItem:registerScriptTapHandler(function ( ... )
		-- body
		timeCount=4
		CCDirector:sharedDirector():pushScene(HomeLayer:scene())
	end)
	backItem:setScale(0.6)
	local backMenu=CCMenu:createWithItem(backItem)
	backMenu:setPosition(17,303)
	layer:addChild(backMenu,1)
	--分数
	scoreLabel=CCLabelTTF:create("score:0","",20)
	scoreLabel:setPosition(320,295)
	scoreLabel:setColor(ccc3(255,255,0))
	layer:addChild(scoreLabel,1)
	--跑的长度
	distLabel=CCLabelTTF:create("dist:0","",20)
	distLabel:setPosition(200,295)
	distLabel:setColor(ccc3(255,255,0))
	layer:addChild(distLabel,1)
	--倒计时
	timeLabel=CCLabelTTF:create("","",40)
	timeLabel:setPosition(240,160)
	timeLabel:setColor(ccc3(255,255,0))
	layer:addChild(timeLabel,1)

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
	--print(timeCount)
	if timeCount>0 then
		--todo		
		timeLabel:stopAllActions()
		schedule(timeLabel,function ( ... )
		-- body
			if timeCount>=0 then
				--todo
				timeCount=timeCount-1
			    timeLabel:setString(tostring(timeCount))
			end
		end, 1)
	end
	if not scheduleID then
		--todo
		--状态机定时器
		scheduleID=CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(time, 0, false)
	end
	--开启鼠标点击调用函数
	layer:registerScriptTouchHandler(onTouch)
	--要写在后面
	layer:setTouchEnabled(true)
end
function onExit( ... )
	-- body
	if scheduleID then
		CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(scheduleID)
		scheduleID = nil
	end
end

function onTouch(s, x, y)
	-- body
	if s=="began" then
		--todo
		onTouchBegan(x,y)
	end
end
function onTouchBegan( x,y )
	if player.nowStatus == Role.statusRun or player.nowStatus == Role.statusSlip then
		--todo
		if x<CCDirector:sharedDirector():getWinSize().width/2 then
			--todo
			player.nowStatus = Role.statusSlip
		else
			--todo
			player.nowStatus = Role.statusUp
		end
	end
end

function time( dt )
	--todo
	if timeCount==-1 and player:getPositionY()>=32 then
		--todo
		timeLabel:setString("")
		mapMoveX()
	end
	if player.nowStatus == Role.statusRun then
		player:run()
	elseif player.nowStatus == Role.statusUp then
		player:up()
	elseif player.nowStatus == Role.statusDown then
		player:down()
	elseif player.nowStatus == Role.statusDie then
		player:die()
	elseif player.nowStatus == Role.statusSlip then
		player:slip()
	end

	local justchange=player:getPositionX()-map1:getContentSize().width
	if map1:getPositionX()>=justchange then
		--todo
		collisionWithCoins(map1)
		collisionWithBoxs(map1)
		if player:getPositionY()<=32 then
			--todo
			collisionWithFloor(map1)
		end
	else
		--todo
		collisionWithCoins(map2)
		collisionWithBoxs(map2)
		if player:getPositionY()<=32 then
			--todo
			collisionWithFloor(map2)
		end
	end
	collisionWithBullets()
	if (player.nowStatus == Role.statusRun or player.nowStatus == Role.statusSlip) and player:getPositionY()~=32 and flag==0 then
		--todo
		player.nowStatus = Role.statusDown
	end
	--判断游戏结束
	judgeOver()

end

function mapMoveX( ... )
	-- body
	--无限显示地图
	local justOut=CCDirector:sharedDirector():getWinSize().width-map1:getContentSize().width
	local justEnd=0-map1:getContentSize().width
	local x=map1:getPositionX()-speedX
	if x<=justOut  then
		--todo	
		if x==justOut  then
			--todo
			--随机一张地图添加
			map2=Map.create("map"..math.random(1,6))
			map2:setPositionX(483)
			layer:addChild(map2)
		end
		map2:setPositionX(map2:getPositionX()-speedX)
	end
	map1:setPositionX(x)
	if x==justEnd then
		--todo
		map1:removeFromParentAndCleanup(true)
	 	map1=map2
	 	map1:setPositionX(0)	 
	end
	for i,v in ipairs(map1.bullets) do
		if i~=1 then
			--todo
			v:setPositionX(v:getPositionX()-2)
		end
	end

	distCount=distCount+speedX
	distLabel:setString("dist:"..distCount)
end

-- function setCamara(  )
-- 	-- 获得屏幕可视大小
--     local visibleSize = CCEGLView:sharedOpenGLView():getVisibleSize()
--     -- 获得玩家当前坐标
--     local curY = player:getPositionY()

--     -- 玩家当前坐标与屏幕中心点进行比较，取大的那个
--     -- 作用：让玩家移动，地图不动
--     -- if map:getPositionX() == -mapEnd then
--     -- 	map:removeFromParentAndCleanup(true)
--     -- 	player:setPositionX(x)
--     -- 	initMap()
--     -- 	local x = curX
--     -- else
--     --local x = math.max(curX, visibleSize.width / 2)
--     --end
      
--     local y = math.max(curY, visibleSize.height / 2)
    
--     -- map:getMapSize()获得地图的大小（即块的个数）
--     -- map:getTileSize() 地图每小块的大小
--     -- 两个相乘得到地图总的大小
--     -- x = math.min(x, map:getMapSize().width * map:getTileSize().width - visibleSize.width/2);  
    
--     y = math.min(y, map1:getMapSize().height * map1:getTileSize().height - visibleSize.height/2)
--     --print("x,y",x,y)
--     local goodPoint = ccp(x, y)
--     -- 屏幕中心坐标
--     local centerOfScreen = ccp(visibleSize.width/2, visibleSize.height/2)  
--     -- 相减得到地图的偏移量，因为地图起始坐标就是（0，0），所以偏移量就是地图的坐标
--     local diffence = ccpSub(centerOfScreen, goodPoint)  
--     -- 设置地图坐标
--     map1:setPosition(diffence)
-- end

--与地板的碰撞检测
function collisionWithFloor(map)
	-- body
	--读取地板信息
	local group=map:objectGroupNamed("floors")
	local objects=group:getObjects()
	for i=0,objects:count()-1 do
		local obj=objects:objectAtIndex(i)
		tolua.cast(obj,"CCDictionary")
		local x = obj:valueForKey("x"):intValue() --intValue转化为整形的
		local y = obj:valueForKey("y"):intValue()
		local width = obj:valueForKey("width"):intValue() 
		local height = obj:valueForKey("height"):intValue()
		--判断玩家与地板碰撞
		--获得人物的巨型区域
		local playerRect = player:boundingBox()
		local playerBottom=CCPoint(playerRect.origin.x+playerRect.size.width/2,playerRect.origin.y)

		local floorRect = CCRectMake(x, y, width, height)
		local floorWord=map:convertToWorldSpace(floorRect.origin)
		floorRect=CCRectMake(floorWord.x,floorWord.y,floorRect.size.width,floorRect.size.height)
		if floorRect:containsPoint(playerBottom) then
			--todo
			if player.nowStatus == Role.statusSlip then
				player.nowStatus = Role.statusSlip
			else
				player.nowStatus = Role.statusRun
			end
			player:setPositionY(32)
			return
		end
	end
	player.nowStatus = Role.statusDown
end
--与金币的碰撞检测
function collisionWithCoins( map )
	-- body
	for i,v in ipairs(map.coins) do
		local playerRect =player:boundingBox()
		local coinRect = v:boundingBox()
		local coinWord=map:convertToWorldSpace(coinRect.origin) --获得硬币框左下点世界坐标
		coinRect=CCRectMake(coinWord.x,coinWord.y,coinRect.size.width,coinRect.size.height)
		if playerRect:intersectsRect(coinRect) then
			--todo
			local explo=CCParticleSystemQuad:create("images/explo2.plist")
			explo:setPosition(v:getPosition())
			map.batchE:addChild(explo)
			v:removeFromParentAndCleanup(true)
			--从tabel删除
			table.remove(map.coins,i)
			scoreCount=scoreCount+1
			scoreLabel:setString("score:"..scoreCount)
		end
	end
end
--与箱子的碰撞检测
function collisionWithBoxs( map )
	--body
	flag=0
	for i,v in ipairs(map.boxs) do
		local playerRect =player:boundingBox()
		local playerRight=CCPoint(playerRect.origin.x+playerRect.size.width-5,playerRect.origin.y+playerRect.size.height/2)
		local playerBottom=CCPoint(playerRect.origin.x+playerRect.size.width/2,playerRect.origin.y)
		local playerTop=CCPoint(playerRect.origin.x+playerRect.size.width-5,playerRect.origin.y+playerRect.size.height)

		local boxRect = v:boundingBox()
		local boxWord=map:convertToWorldSpace(boxRect.origin)
		boxRect=CCRectMake(boxWord.x,boxWord.y,boxRect.size.width,boxRect.size.height)
		
		if boxRect:containsPoint(playerRight) or boxRect:containsPoint(playerTop) then
			--todo
			player:setPositionX(boxRect:getMinX()-playerRect.size.width/2+5)
		end	
		if boxRect:containsPoint(playerBottom) then
			--todo
			flag=1
			if player.nowStatus == Role.statusSlip then
				player.nowStatus = Role.statusSlip
			else
				player.nowStatus = Role.statusRun
			end
			player:setPositionY(boxRect.origin.y+boxRect.size.height)
		end
	end
end
function collisionWithBullets( ... )
	-- body
	for i,v in ipairs(map1.bullets) do
		local playerRect =player:boundingBox()
		playerRect=CCRectMake(playerRect.origin.x+playerRect.size.width/2,playerRect.origin.y,playerRect.size.width/2-5,playerRect.size.height)
		local bulletRect = v:boundingBox()
		local bulletWord=map1:convertToWorldSpace(bulletRect.origin) --获得硬币框左下点世界坐标
		bulletRect=CCRectMake(bulletWord.x,bulletWord.y,bulletRect.size.width,bulletRect.size.height)
		if playerRect:intersectsRect(bulletRect) then
			--todo
			player.nowStatus = Role.statusDie
		end
	end
end

function judgeOver( ... )
	-- body
	if player:getPositionY()<32 then
		--todo
		player.nowStatus = Role.statusDown
	end
	if player:getPositionY()<0 or player:getPositionX()<-player:boundingBox().size.width/2 then
		--todo
		player.nowStatus = Role.statusDie
	end
end