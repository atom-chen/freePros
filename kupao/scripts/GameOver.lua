
module("GameOver",package.seeall)
function scene(  )
    -- body
    local  s=CCScene:create()
    layer=CCLayer:create()
    init()
    s:addChild(layer)
    return s
end

function init( ... )
	-- body
	local bg=CCSprite:create("images/back_1.png")
	bg:setScale(0.7)
	bg:setPosition(240,160)
	layer:addChild(bg)

	local over=CCSprite:create("images/gameover.png")
	over:setScale(0.6)
	over:setPosition(260,200)
	layer:addChild(over)

	local reItem=CCMenuItemImage:create("images/restart_n.png","images/restart_s.png")
	reItem:registerScriptTapHandler(function ( ... )
		-- body
		CCDirector:sharedDirector():replaceScene(GameLayer:scene())
	end)
	reItem:setScale(0.5)
	local menu=CCMenu:createWithItem(reItem)
	menu:setPosition(240,120)
	layer:addChild(menu)
end