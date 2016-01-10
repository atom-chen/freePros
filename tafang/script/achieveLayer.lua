module("achieveLayer",package.seeall)

function scene()
	local s = CCScene:create()
	s:addChild(create())
	return s
end

local function onEnter()
    print("onEnter")
end
--layer退出或关闭是调用此方法
local function onExit()
    print("onExit")
    --CCNotificationCenter:sharedNotificationCenter():removeAllObservers(layer)
end

local function onEnterOronExit(type)
    if type == "enter" then
        onEnter()
    elseif type == "exit" then
        onExit()
    end
end

function create()
	layer = CCLayer:create()
    layer:registerScriptHandler(onEnterOronExit)
    winSize = CCDirector:sharedDirector():getWinSize()

    local bg = CCSprite:create("images/listview.png")
    layer:addChild(bg)

    --添加题目提示
    local layerColor = createLayerColor()
    layer:addChild(layerColor)

    --添加返回按钮
   local backBtn=CCMenuItemImage:create("images/quit1.png","images/quit2.png")
    backBtn:registerScriptTapHandler(function ( ... )
        
        CCDirector:sharedDirector():replaceScene(homeLayer.scene())
    end)
    backBtn:setScale(0.6)
    local backMenu=CCMenu:createWithItem(backBtn)
    backMenu:setPosition(winSize.width*0.85,winSize.height*0.93)
    layer:addChild(backMenu)

    --加载plist文件
    datas = CCArray:createWithContentsOfFile("images/achieve.plist")
    datas:retain()

    tableView = CCTableView:create(CCSizeMake(480, 270))
    tableView:setDirection(kCCScrollViewDirectionVertical)
    tableView:setPosition(CCPointMake(45, winSize.height / 2 - 160))
    tableView:setVerticalFillOrder(kCCTableViewFillTopDown)
    layer:addChild(tableView)
    tableView:registerScriptHandler(scrollViewDidScroll,CCTableView.kTableViewScroll)
    tableView:registerScriptHandler(scrollViewDidZoom,CCTableView.kTableViewZoom)
    tableView:registerScriptHandler(tableCellTouched,CCTableView.kTableCellTouched)
    tableView:registerScriptHandler(cellSizeForTable,CCTableView.kTableCellSizeForIndex)
    tableView:registerScriptHandler(tableCellAtIndex,CCTableView.kTableCellSizeAtIndex)
    tableView:registerScriptHandler(numberOfCellsInTableView,CCTableView.kNumberOfCellsInTableView)
    tableView:reloadData()
	

    return layer
end

function createLayerColor( ... )
    local layerColor = CCLayerColor:create(ccc4(212, 212, 212, 212),290,40)
    layerColor:ignoreAnchorPointForPosition(false)
    layerColor:setAnchorPoint(0.5,1)
    layerColor:setPosition(layer:getContentSize().width*0.4,layer:getContentSize().height)
    
    local bg = CCSprite:create("images/completed.png")
    bg:setScale(0.7)
    bg:setPosition(layerColor:getContentSize().width*0.15,layerColor:getContentSize().height/2)
    layerColor:addChild(bg)

    local label = CCLabelTTF:create("成就系统","Arial",24)
    label:setColor(ccc3(0, 0, 0))
    label:setPosition(layerColor:getContentSize().width*0.5,layerColor:getContentSize().height/2)
    layerColor:addChild(label)

    return layerColor
end

function scrollViewDidScroll(view)
    print("scrollViewDidScroll")
end

function scrollViewDidZoom(view)
    print("scrollViewDidZoom")
end

function tableCellTouched(table,cell)
    print("cell touched at index: " .. cell:getIdx())
end

function cellSizeForTable(table,idx) 
    return 101,90
end

function numberOfCellsInTableView(table)
   return datas:count()
end

function tableCellAtIndex(table, idx)
   

     print("tableCellAtIndex",idx)

     ----获得重复利用的cell
    local cell = table:dequeueCell()
    if nil == cell then
     
         ----没有可以重复使用的cell

         ----创建新的cell
        cell = CCTableViewCell:new()

        ----背景
        local bg = CCLayerColor:create(ccc4(255,255,255,255),100,320)
        bg:setTag(101)
        bg:setContentSize(CCSizeMake(winSize.width*0.8,90))
        cell:addChild(bg)
         ----头像
        local avator = CCSprite:create("images/uncompleted.png")
        avator:setTag(102)
        avator:setAnchorPoint(CCPointMake(0,0.5))
        avator:setPosition(CCPointMake(20,40))
        cell:addChild(avator)

        local salutationStr = getPlistStr(idx ,"Salutation")
        local datasStr = getPlistStr(idx ,"datas")

        ----称号
        local salutationLabel = CCLabelTTF:create(salutationStr,"",25)
        salutationLabel:setTag(100)
        salutationLabel:setColor(ccc3(0,0,0))
        salutationLabel:setAnchorPoint(ccp(0,0.5))
        salutationLabel:setPosition(ccp(100,100*0.5))
        cell:addChild(salutationLabel)

        ----称号信息描述
        local datasLabel = CCLabelTTF:create(datasStr,"",15)
        datasLabel:setTag(103)
        datasLabel:setColor(ccc3(0,0,0))
        datasLabel:setAnchorPoint(ccp(0,0.5))
        datasLabel:setPosition(ccp(100,100*0.25))
        cell:addChild(datasLabel)
    else
        --使用重复利用的cell.
        local salutationLabel = cell:getChildByTag(100)
        local salutationStr = getPlistStr(idx ,"Salutation")
        tolua.cast(salutationLabel, "CCLabelTTF")
        salutationLabel:setString(salutationStr)

        local datasLabel = cell:getChildByTag(103)
        local datasStr = getPlistStr(idx ,"datas")
        tolua.cast(datasLabel, "CCLabelTTF")
        datasLabel:setString(datasStr)

        local avator = cell:getChildByTag(102)
        tolua.cast(avator, "CCSprite")
        print("idx..............",idx)
        for i=1,#userTable do
            print("userTableuserTableuserTable",userTable[i],i,idx)
        end
        if userTable[idx + 1] then
            avator:setTexture(CCTextureCache:sharedTextureCache():addImage("images/completed.png"))
            print("images/completed.png")
        else
            avator:setTexture(CCTextureCache:sharedTextureCache():addImage("images/uncompleted.png"))
            print("images/uncompleted.png")
        end
        --avator:setTexture(CCTextureCache:sharedTextureCache():addImage("images/uncompleted.png"))
    end
    return cell
end

function getPlistStr( idx ,mes)
    local dic = datas:objectAtIndex(idx)
    tolua.cast(dic, "CCDictionary")
    local str = dic:valueForKey(mes):getCString()
    return str
end
