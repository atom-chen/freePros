module("Homelayer",package.seeall)

local function init(layer)
    -- body
    --layer=CCLayerColor:create(ccc4(255,0,0,255),320,480)
    
    local bg=CCSprite:create("background.jpg")
    bg:setScale(0.9)
    bg:setPosition(ccp(160,240))
    layer:addChild(bg)
    
    local logo=CCSprite:create("logo.png")
    logo:setScale(0.85)

    logo:setPosition(ccp(160,380))
    local fadein=CCFadeIn:create(2)
    logo:runAction(fadein)
    layer:addChild(logo)
--添加按钮
    local playItem=MyBtns:create("green-button.png","green-button-over.png" ,"Play",40)
    playItem:registerScriptTapHandler(function ( ... )
        -- body
        AudioEngine.playEffect("sound/enter.wav")
        local s=Gamelayer:scene()
        local co=CCTransitionFadeUp:create(1,s)
        CCDirector:sharedDirector():replaceScene(co)
    end)
    playItem:setPosition(ccp(30,130))
    local to2=CCMoveTo:create(0.4,ccp(160,270))
    playItem:runAction(to2)
    local opItem=MyBtns:create("grey-button.png","grey-button-over.png" ,"Options" ,40)
    opItem:registerScriptTapHandler(function ( ... )
        -- body
        AudioEngine.playEffect("sound/enter.wav")
        CCDirector:sharedDirector():replaceScene(Reset:scene())
    end)
    opItem:setScaleX(0.75)
    opItem:setPosition(ccp(160,130))
    local to3=CCMoveTo:create(0.2,ccp(160,200))
    opItem:runAction(to3)
    local moreItem=MyBtns:create("green-button.png","green-button-over.png" ,"More Games" ,30)
    moreItem:registerScriptTapHandler(function ( ... )
        -- body
        AudioEngine.playEffect("sound/enter.wav")
    end)
    moreItem:setScaleX(0.75)
    moreItem:setPosition(ccp(50,140))
    local to4=CCMoveTo:create(0.3,ccp(160,140))
    moreItem:runAction(to4)
    
    local Items=CCArray:create()
    Items:addObject(playItem)
    Items:addObject(opItem)
    Items:addObject(moreItem)

    local menu=CCMenu:createWithArray(Items)
    menu:setPosition(ccp(0,0))
    layer:addChild(menu)
end
function scene(  )
    -- body
    local  s=CCScene:create()
    local layer=CCLayer:create()
    init(layer)
    s:addChild(layer)
    return s
end
