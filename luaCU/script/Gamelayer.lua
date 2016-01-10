module("Gamelayer",package.seeall)

math.randomseed(os.time())
function scene( ... )
	-- body
	local s=CCScene:create()
	layer=CCLayer:create()
	init()
	s:addChild(layer)
	return s
end

function init( ... )
	-- body
	--读取XML文件
	level=CCUserDefault:sharedUserDefault():getIntegerForKey("LEVEL")
	sumScore=CCUserDefault:sharedUserDefault():getIntegerForKey("SCORE")
	kiptimes=CCUserDefault:sharedUserDefault():getIntegerForKey("SKIPTIMES")
	zoomtimes=CCUserDefault:sharedUserDefault():getIntegerForKey("ZOOMTIMES")
	removetimes=CCUserDefault:sharedUserDefault():getIntegerForKey("REMOVETIMES")

	--读取plist文件
    imgs=CCArray:createWithContentsOfFile("imgs.plist")
    tolua.cast(imgs, "CCArray")
    dic=imgs:objectAtIndex(level)
    tolua.cast(dic, "CCDictionary")
    imgFile=dic:valueForKey("imgFile")
    tolua.cast(imgFile, "CCString")
    imgName=dic:objectForKey("imgName")
    tolua.cast(imgName, "CCArray")
    imgName:retain()
    guessName=dic:objectForKey("guessName")
    tolua.cast(guessName, "CCArray")
    guessName:retain()

    guessword=CCArray:create()
    guessword:retain()
    --添加猜的图片
    local str="images/"..imgFile:getCString()
    bg=CCSprite:create(str)
    bg:setPosition(ccp(160,312))
    bg:setAnchorPoint(ccp(0.7,0.7))
    bg:setScale(0.4)
    layer:addChild(bg)

    local masker=CCSprite:create("masker.png")
    masker:setPosition(ccp(160,240))
    layer:addChild(masker)
    intoButtons()
    intoBlocks()
    intoCharSprites()
    

    incorrect=CCSprite:create("incorrect.png")
    incorrect:setPosition(ccp(160,240))
    layer:addChild(incorrect)
    incorrect:setVisible(false)

    if level==0 then
    	--todo
    	howplay()
    end

    countremove=0
    countzoom=0

end

function intoButtons( ... )
	-- body

	local Items=CCArray:create()

	local backItem=CCMenuItemImage:create("back.png","back.png")
	backItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		CCDirector:sharedDirector():replaceScene(Homelayer:scene())
	end)
	backItem:setScale(0.5)
	backItem:setPosition(ccp(44,459))
	Items:addObject(backItem)
	local skipItem=CCMenuItemImage:create("skip-btn.png","skip-btn-over.png")
	skipItem:registerScriptTapHandler(function ( ... )
		--body
		AudioEngine.playEffect("sound/enter.wav")
		 if kiptimes>0 then
			--todo
			for i=0,guessName:count()-1 do
					local chItem=chMenu:getChildByTag(i)
					local y=chItem:getPositionY()
					if y==166 then
						--todo
						chItem:setPosition(ccp(charsPosX[i],charsPosY[i]))
					end
				end
			for i=0,imgName:count()-1 do
				local cR=imgName:objectAtIndex(i)
				tolua.cast(cR,"CCString")
				--获得下面所有字母tag
				local m=0
				local ta={}
				for k=0,guessName:count()-1 do
						local chItem=chMenu:getChildByTag(k)
						local y=chItem:getPositionY()
						if y~=166 then
							--todo
							ta[m]=k
							m=m+1
						end
				end
				print(m)
				for j=0,m-1 do
					local cG=guessName:objectAtIndex(ta[j])
					tolua.cast(cG,"CCString")
					if cG:isEqual(cR) then
						--todo
						local cgItem=chMenu:getChildByTag(ta[j])
            			cgItem:setScale(0.75)
            			cgItem:setPosition(ccp(blocksPosX[i],166))
            			break
					end
				end
			end
			bg:setAnchorPoint(ccp(0.5,0.5))
			local to=CCScaleTo:create(1,0.135)
			local call=CCCallFunc:create(function ( ... )
				-- body
				level=level+1
				kiptimes=kiptimes-1
				saveDatas()
				CCDirector:sharedDirector():replaceScene(Gamelayer:scene())
			end)
			local quence=CCSequence:createWithTwoActions(to, call)
			bg:runAction(quence)
		else
			--todo
			buylayer(1)
		end
	end)
	skipItem:setPosition(ccp(300,306))
	Items:addObject(skipItem)
	local zoomItem=CCMenuItemImage:create("zoom.png","zoom-over.png")
	zoomItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		if zoomtimes>0 then
			--todo
			if countzoom>2 then
				--todo
			else
				--todo
				countzoom=countzoom+1
				zoomtimes=zoomtimes-1
				zoomTimes:setString(tostring(zoomtimes))
				local scaleby=CCScaleBy:create(0.5,0.9)
				bg:runAction(scaleby)
			end
		else
			--todo
			buylayer(2)
		end
	end)
	zoomItem:setPosition(ccp(300,262))
	Items:addObject(zoomItem)
	local removeItem=CCMenuItemImage:create("remove-btn.png","remove-btn-over.png")
	removeItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		if removetimes>0 then
			--todo
			if countremove>3 then
				--todo
				
			else
				--todo
				countremove=countremove+1
				removetimes=removetimes-1				
				local tag={}
				local tg
				local n=0
				local ran
				local  fla=0
				for i=0,guessName:count()-1 do
					local chItem=chMenu:getChildByTag(i)
					local y=chItem:getPositionY()
					if y~=166 then
						--todo
						tag[n]=i
						n=n+1
					end
				end
				print(n)
				repeat
					--todo
					fla=0
					ran=math.random(0,n-1)
					tg=tag[ran]
					print(tg)
					local chRand=guessName:objectAtIndex(tg)
					tolua.cast(chRand,"CCString")
					for j=0,imgName:count()-1 do
						rightCh=imgName:objectAtIndex(j)
						tolua.cast(rightCh,"CCString")
						if chRand:isEqual(rightCh) then
							--todo
							fla=1
							break
						end
					end
					print(chRand:getCString())
					print(rightCh:getCString())
				until fla==0
				local cItem=chMenu:getChildByTag(tg)
				cItem:setVisible(false)
				cItem:setPositionY(166)
				removeTimes:setString(tostring(removetimes))
				end
		else
			--todo
			buylayer(3)
		end
	end)
	removeItem:setPosition(ccp(300,218))
	Items:addObject(removeItem)
	local freeItem=CCMenuItemImage:create("free.png","free-over.png")
	freeItem:registerScriptTapHandler(function ( ... )
		-- body
	end)
	freeItem:setPosition(ccp(20,306))
	Items:addObject(freeItem)
	local facebookItem=CCMenuItemImage:create("facebookBtn.png","facebookBtn-over.png")
	facebookItem:registerScriptTapHandler(function ( ... )
		-- body
	end)
	facebookItem:setPosition(ccp(20,262))
	Items:addObject(facebookItem)
	local twitterItem=CCMenuItemImage:create("twitterBtn.png","twitterBtn-over.png")
	twitterItem:registerScriptTapHandler(function ( ... )
		-- body
	end)
	twitterItem:setPosition(ccp(20,218))
	Items:addObject(twitterItem)

	local Menu=CCMenu:createWithArray(Items)
	Menu:setPosition(ccp(0,0))
	layer:addChild(Menu)

	kipTimes=CCLabelTTF:create(tostring(kiptimes),"",10)
	kipTimes:setPosition(ccp(312,316))
	layer:addChild(kipTimes)
	zoomTimes=CCLabelTTF:create(tostring(zoomtimes),"",10)
	zoomTimes:setPosition(ccp(312,272))
	layer:addChild(zoomTimes)
	removeTimes=CCLabelTTF:create(tostring(removetimes),"",10)
	removeTimes:setPosition(ccp(312,228))
	layer:addChild(removeTimes)

    local s="level:"..level+1
	Level=CCLabelTTF:create(s,"",15)
	Level:setPosition(ccp(160,465))
	layer:addChild(Level)
	local Levelbar=CCSprite:create("level-bar.png")
	Levelbar:setPosition(ccp(160,445))
	layer:addChild(Levelbar)
	local bar=CCSprite:create("Box.png")
	bar:setScaleY(16.0/29)
	bar:setScaleX(12.5*level/293)
	bar:setPosition(ccp(103.75+6.25*level,445))
	layer:addChild(bar)
   
    score=CCLabelTTF:create(tostring(sumScore),"",20)
    score:setPosition(ccp(300,460))
    layer:addChild(score)
end

function intoCharSprites( ... )
	-- body
	charsPosX={}
	charsPosY={}
	charsArr=CCArray:create()
	for i=0,2,1 do
		for j=0,5,1 do
			local str=guessName:objectAtIndex(i*6+j)
			tolua.cast(str,"CCString")		
			local chItem=MyBtns:createChar("letter.png",str:getCString())
			chItem:setTag(i*6+j)
			chItem:registerScriptTapHandler(charBtn)
			chItem:setPosition(ccp(61+j*40,120-i*43))
			charsArr:addObject(chItem)	
            charsPosX[i*6+j]=chItem:getPositionX()
            charsPosY[i*6+j]=chItem:getPositionY()
		end
	end
	chMenu=CCMenu:createWithArray(charsArr)
	chMenu:setPosition(ccp(0,0))
	layer:addChild(chMenu)
end

function intoBlocks( ... )
	-- body
	blocksPosX={}
	blocksPosY={}
	m=imgName:count()-2
	for i=0,imgName:count() do
		local block=CCSprite:create("block.png")
		block:setPosition(ccp(145+i*30-15*m,166))
		blocksPosX[i]=block:getPositionX()
		blocksPosY[i]=block:getPositionY()
		layer:addChild(block)
		if i==imgName:count() then
			--todo
			block:setVisible(false)
		end
	end
end

function winlayer( ... )
	-- body
	complete=MyBtns:createChar("complete.png","")
	complete:setPosition(ccp(160,240))
	completeMenu=CCMenu:createWithItem(complete)
	completeMenu:setPosition(0,0)
	layer:addChild(completeMenu)

	local quan=CCParticleSystemQuad:create("xinxin.plist")
	layer:addChild(quan)

	local well=MyBtns:create("grass.png", "grass.png", "Well done!", 40)
	well:setScale(1)
	well:setPosition(ccp(160,450))
	well:setOpacity(200)
	layer:addChild(well)

	local sco=MyBtns:create("score-box.png", "score-box.png","", 30)
	sco:setPosition(ccp(160,222))
	layer:addChild(sco)

	lastscore=CCLabelTTF:create(tostring(sumScore),"",30)
	lastscore:setPosition(ccp(160,222))
	layer:addChild(lastscore)
	local delay=CCDelayTime:create(1)
	lastscore:runAction(delay)

	local score50=CCLabelTTF:create("50","",30)
	score50:setPosition(ccp(160,300))
	local to=CCMoveTo:create(0.5,ccp(160,222))
	local call=CCCallFunc:create(function ( ... )
		-- body
		score50:removeFromParentAndCleanup(true)
		schedule(lastscore,function ( ... )
			-- body
			if sumScore<50*(level-2+kiptimes) then
				--todo
				sumScore=sumScore+1
			    lastscore:setString(tostring(sumScore))
			end
		end, 0.04)
	end)
	local quence=CCSequence:createWithTwoActions(to,call)
	score50:runAction(quence)
	layer:addChild(score50)

	local continu=MyBtns:create( "green-button.png", "green-button.png","Continue", 30)
	continu:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		saveDatas()
		CCDirector:sharedDirector():replaceScene(Gamelayer:scene())
	end)
	local conMenu=CCMenu:createWithItem(continu)
	conMenu:setPosition(ccp(160,100))
	layer:addChild(conMenu)

end

function buylayer(flag)
	-- body
	buy=MyBtns:createChar("complete.png","")
	buy:setPosition(ccp(160,240))
	buyMenu=CCMenu:createWithItem(buy)
	buyMenu:setPosition(0,0)
	layer:addChild(buyMenu)

	local kon=CCSprite:create("background.jpg")
	kon:setScale(0.76)
	kon:setColor(ccc3(255,255,255))
	kon:setPosition(ccp(180,285))
	buy:addChild(kon)

	local clo=CCSprite:create("close.png")
	local cloItem=CCMenuItemSprite:create(clo,clo)
	cloItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		buy:setVisible(false)
	end)
	local cloMenu=CCMenu:createWithItem(cloItem)
	cloMenu:setPosition(ccp(355,565))
	kon:addChild(cloMenu)

	local re=CCLabelTTF:create("This Tool Outs","",40)
	re:setPosition(ccp(180,500))
	kon:addChild(re)

	local oneItem=MyBtns:create("green-button.png","green-button-over.png","1x-$3.0", 30)
    oneItem:registerScriptTapHandler(function ( ... )
    	-- body
    	AudioEngine.playEffect("sound/coin.wav")
    	if flag==3 then
    		--todo
    		removetimes=removetimes+1
    		removeTimes:setString(tostring(removetimes))
    	elseif flag==2 then
    		--todo
    		zoomtimes=zoomtimes+1
    		zoomTimes:setString(tostring(zoomtimes))
    	else
    		--todo
    		kiptimes=kiptimes+1
    		kipTimes:setString(tostring(kiptimes))
    	end

    end)
    local twoItem=MyBtns:create("green-button.png","green-button-over.png","2x-$5.0", 30)
    twoItem:registerScriptTapHandler(function ( ... )
    	-- body
    	AudioEngine.playEffect("sound/coin.wav")
    	if flag==3 then
    		--todo
    		removetimes=removetimes+2
    		removeTimes:setString(tostring(removetimes))
    	elseif flag==2 then
    		--todo
    		zoomtimes=zoomtimes+2
    		zoomTimes:setString(tostring(zoomtimes))
    	else
    		--todo
    		kiptimes=kiptimes+2
    		kipTimes:setString(tostring(kiptimes))
    	end

    end)
    local threetem=MyBtns:create("green-button.png","green-button-over.png","3x-$7.0", 30)
    threetem:registerScriptTapHandler(function ( ... )
    	-- body
    	AudioEngine.playEffect("sound/coin.wav")
    	if flag==3 then
    		--todo
    		removetimes=removetimes+3
    		removeTimes:setString(tostring(removetimes))
    	elseif flag==2 then
    		--todo
    		zoomtimes=zoomtimes+3
    		zoomTimes:setString(tostring(zoomtimes))
    	else
    		--todo
    		kiptimes=kiptimes+3
    		kipTimes:setString(tostring(kiptimes))
    	end

    end)
    local fourItem=MyBtns:create("green-button.png","green-button-over.png","4x-$9.0", 30)
    fourItem:registerScriptTapHandler(function ( ... )
    	-- body
    	AudioEngine.playEffect("sound/coin.wav")
    	if flag==3 then
    		--todo
    		removetimes=removetimes+4
    		removeTimes:setString(tostring(removetimes))
    	elseif flag==2 then
    		--todo
    		zoomtimes=zoomtimes+4
    		zoomTimes:setString(tostring(zoomtimes))
    	else
    		--todo
    		kiptimes=kiptimes+4
    		kipTimes:setString(tostring(kiptimes))
    	end
    end)
    local numArr=CCArray:create()
    numArr:addObject(oneItem)
    numArr:addObject(twoItem)
    numArr:addObject(threetem)
    numArr:addObject(fourItem)
    local numMenu=CCMenu:createWithArray(numArr)
    numMenu:setPosition(ccp(213,290))
    numMenu:alignItemsVerticallyWithPadding(20)
    numMenu:setScale(1.2)
    kon:addChild(numMenu)
end

function charBtn(tag, thisBtn)
	num=guessword:count()
    local charY=thisBtn:getPositionY()
    local charX=thisBtn:getPositionX()
    local blockX=blocksPosX[num]
    local blockY=blocksPosY[num]
    print(charX,charY,blockX,blockY)
    if charY==blockY and charX==blockX-30  then
    	--todo
    	local back=CCMoveTo:create(0.5,ccp(charsPosX[tag],charsPosY[tag]))
    	thisBtn:runAction(back)
    	thisBtn:setScale(1)
    	guessword:removeLastObject()
    	incorrect:setVisible(false)
    	num=num-1
    elseif charY~=blockY then
    	--todo
    	print(imgName)
    	if num<imgName:count() then
    		--todo
    		local to=CCMoveTo:create(0.5,ccp(blockX,blockY))
            thisBtn:runAction(to)
            thisBtn:setScale(0.75)
            local ch=guessName:objectAtIndex(tag)
            tolua.cast(ch, "CCString")
            guessword:addObject(ch)
            num=num+1
	        if judgeWin() then
	        	--todo
	        	winlayer()
	            saveDatas()
	        end

    	end
    end   
end

function saveDatas( ... )
	-- body
	if level==8 then
		--todo
		level=0
	end
	CCUserDefault:sharedUserDefault():setIntegerForKey("LEVEL",level)
	CCUserDefault:sharedUserDefault():setIntegerForKey("SCORE",sumScore)
	CCUserDefault:sharedUserDefault():setIntegerForKey("SKIPTIMES",kiptimes)
	CCUserDefault:sharedUserDefault():setIntegerForKey("ZOOMTIMES",zoomtimes)
	CCUserDefault:sharedUserDefault():setIntegerForKey("REMOVETIMES",removetimes)
	CCUserDefault:sharedUserDefault():flush()
end

function judgeWin( ... )
	-- body
	if num==imgName:count() then
		--todo
		if guessword:isEqualToArray(imgName) then
			--todo
			level=level+1
			num=0
			bg:setAnchorPoint(ccp(0.5,0.5))
			local to=CCScaleTo:create(1,0.135)
			bg:runAction(to)
			return true
		else
			--todo
			incorrect:setVisible(true)
		end
	end
	return false
end

function howplay( ... )
	-- body
	howlayer=CCSprite:create("complete.png")
	howlayer=MyBtns:createChar("complete.png","")
	howlayer:setPosition(ccp(160,240))
	howMenu=CCMenu:createWithItem(howlayer)
	howMenu:setPosition(0,0)
	layer:addChild(howMenu)

	local howkon=CCSprite:create("background.jpg")
	howkon:setScale(0.76)
	howkon:setColor(ccc3(255,255,255))
	howkon:setPosition(ccp(180,285))
	howlayer:addChild(howkon)

	local clo=CCSprite:create("close.png")
	local cloItem=CCMenuItemSprite:create(clo,clo)
	cloItem:registerScriptTapHandler(function ( ... )
		-- body
		AudioEngine.playEffect("sound/enter.wav")
		howlayer:setVisible(false)
	end)
	local cloMenu=CCMenu:createWithItem(cloItem)
	cloMenu:setPosition(ccp(355,565))
	howkon:addChild(cloMenu)
	--local howkon=MyBtns:createBg("complete.png")

	local how=CCLabelTTF:create("How to Play","",40)
	how:setPosition(ccp(180,510))
	howkon:addChild(how)

	local howskip=CCSprite:create("skip-btn.png")
	howskip:setPosition(ccp(40,420))
	howkon:addChild(howskip)
	local skipexplain=CCLabelTTF:create("跳到下一关","",25)
	skipexplain:setAnchorPoint(0,0.5)
	skipexplain:setPosition(ccp(70,420))
	howkon:addChild(skipexplain)

	local howzoom=CCSprite:create("zoom.png")
	howzoom:setPosition(ccp(40,340))
	howkon:addChild(howzoom)
	local zoomexplain=CCLabelTTF:create("缩放图片,每关最多3次","",25)
	zoomexplain:setAnchorPoint(0,0.5)
	zoomexplain:setPosition(ccp(70,340))
	howkon:addChild(zoomexplain)

	local howremove=CCSprite:create("remove-btn.png")
	howremove:setPosition(ccp(40,260))
	howkon:addChild(howremove)
	local removeexplain=CCLabelTTF:create("移除错误字母\n每关最多4个","",25)
	removeexplain:setAnchorPoint(0,0.5)
	removeexplain:setPosition(ccp(70,260))
	howkon:addChild(removeexplain)
end
