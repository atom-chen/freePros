#include "HomeLayer.h"
#include "GameLayer.h"
#include "Reset.h"
HomeLayer::HomeLayer(void)
{
}

HomeLayer::~HomeLayer(void)
{
}

CCScene* HomeLayer::scene()
{
	CCScene *scene=CCScene::create();
	HomeLayer *layer=HomeLayer::create();
	scene->addChild(layer);
	return scene;
}
bool HomeLayer::init()
{
	if (!CCLayer::init())
	{
		return false;
	}
	//CCUserDefault::sharedUserDefault()->setIntegerForKey("LEVEL",1);
	//CCUserDefault::sharedUserDefault()->setIntegerForKey("SCORE",0);
	//CCUserDefault::sharedUserDefault()->setIntegerForKey("SKIPTIMES",3);
	//CCUserDefault::sharedUserDefault()->setIntegerForKey("ZOOMTIMES",5);
	//CCUserDefault::sharedUserDefault()->setIntegerForKey("REMOVETIMES",5);
	//CCUserDefault::sharedUserDefault()->flush();
	//添加自己代码
	CCSize WINSIZE=CCDirector::sharedDirector()->getVisibleSize();
	CCLayerColor *contain = CCLayerColor::create(ccc4(255,0,0,255));
	CCSprite *bg=CCSprite::create("background.jpg");
	bg->setScale(0.9);
	bg->setPosition(ccp(160,240));
	contain->addChild(bg);

	CCSprite *logo=CCSprite::create("logo.png");
	logo->setScale(0.85);
	logo->setPosition(ccp(90,300));
	CCMoveTo *to1=CCMoveTo::create(0.2,ccp(160,380));
	logo->runAction(to1);
	contain->addChild(logo);

	CCSprite *play=Letters::create("green-button.png","Play",30,ccc3(255,255,255));
	play->setScaleX(0.6);
	play->setPosition(ccp(-200,-70));
	CCMoveTo *to2=CCMoveTo::create(0.5,ccp(0,0));
	play->runAction(to2);
	CCSprite *options=Letters::create("grey-button.png","Options",30,ccc3(255,255,255));
	options->setScaleX(0.6);
	options->setPosition(ccp(0,-60));
	CCMoveTo *to3=CCMoveTo::create(0.4,ccp(0,0));
	options->runAction(to3);
	CCSprite *more=Letters::create("green-button.png","More Games",30,ccc3(255,255,255));
	more->setScaleX(0.6);
	more->setPosition(ccp(-260,0));
	CCMoveTo *to4=CCMoveTo::create(0.2,ccp(0,0));
	more->runAction(to4);

	CCMenuItemSprite *pl=CCMenuItemSprite::create(play,play,this,menu_selector(HomeLayer::playBtn));
	CCMenuItemSprite *op=CCMenuItemSprite::create(options,options,this,menu_selector(HomeLayer::opBtn));
	CCMenuItemSprite *mo=CCMenuItemSprite::create(more,more,this,menu_selector(HomeLayer::moreBtn));

	CCMenu *menu=CCMenu::create(pl,op,mo,NULL);
	menu->alignItemsVerticallyWithPadding(20);
	menu->setPosition(ccp(210,200));
	contain->addChild(menu);

	//创建滚动视图 设置大小，容器             移动的是容器
	scroll = CCScrollView::create(CCSizeMake(320,480),contain);
	//scroll->setContainer(contain);
	scroll->ignoreAnchorPointForPosition(false);
	scroll->setPosition(ccp(WINSIZE.width/2,WINSIZE.height/2));
	//委托
	scroll->setDelegate(this);
	//方向
	scroll->setDirection(kCCScrollViewDirectionVertical);
	addChild(scroll);

	////设置内容大小
	//scroll->setContentSize(WINSIZE);
	////设置界面大小
	scroll->setViewSize(CCSizeMake(400,400));
	////设置偏移量
	//scroll->setContentOffset(ccp(0,200-WINSIZE.height),false);



	return true;
}
void HomeLayer::scrollViewDidScroll(CCScrollView* view)
{
	CCLOG("scrolview 移动");
}
void HomeLayer::scrollViewDidZoom(CCScrollView* view)
{
	CCLOG("scrolview 缩放");
}

void HomeLayer::playBtn(CCObject *pSender)
{
	CCScene *scene=GameLayer::scene();
	CCTransitionFadeUp *co=CCTransitionFadeUp::create(1,scene);
	CCDirector::sharedDirector()->replaceScene(co);
}
void HomeLayer::opBtn(CCObject *pSender)
{
	CCScene *scene=Reset::scene();
	CCTransitionCrossFade *c=CCTransitionCrossFade::create(0.1,scene);
	CCDirector::sharedDirector()->replaceScene(c);
}
void HomeLayer::moreBtn(CCObject *pSender)
{
	CCScene *scene=GameLayer::scene();
	CCTransitionCrossFade *c=CCTransitionCrossFade::create(1,scene);
	CCDirector::sharedDirector()->replaceScene(c);
}