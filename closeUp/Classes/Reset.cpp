#include "Reset.h"
#include "HomeLayer.h"
#include "Letters.h"
#include "GameLayer.h"
Reset::Reset(void)
{
}

Reset::~Reset(void)
{
}
CCScene* Reset::scene()
{
	CCScene *scene=CCScene::create();
	CCLayer *layer=Reset::create();
	scene->addChild(layer);
	return scene;
}
bool Reset::init()
{
	if (!CCLayer::init())
	{
		return false;
	}

	CCSprite *bg=CCSprite::create("background.jpg");
	bg->setPosition(ccp(160,240));
	addChild(bg);

	//CCLayerColor *bai=CCLayerColor::create(ccc4(255,255,255,255),100,100);
	//bai->setPosition(ccp(160,200));
	//addChild(bai);

	CCMenuItemImage *back=CCMenuItemImage::create("back@2x.png","back-over@2x.png",this,menu_selector(Reset::backBtn));
	back->setScale(0.5);
	CCMenu *backMenu=CCMenu::create(back,NULL);
	backMenu->setPosition(ccp(44,459));
	addChild(backMenu);

	CCSprite *reset=Letters::create("green-button.png","Reset Game",30,ccc3(255,255,255));
	CCMenuItemSprite *reItem=CCMenuItemSprite::create(reset,reset,this,menu_selector(Reset::reSet));
	CCMenu *reMenu=CCMenu::create(reItem,NULL);
	reMenu->setPosition(ccp(160,30));
	CCMoveTo *to=CCMoveTo::create(0.4,ccp(160,330));
	reMenu->runAction(to);
	addChild(reMenu);


	return true;
}
void Reset::backBtn(CCObject *pSender)
{
	CCScene *scene=HomeLayer::scene();
	CCTransitionCrossFade *co=CCTransitionCrossFade::create(0.1,scene);
	CCDirector::sharedDirector()->replaceScene(co);
}
void Reset::reSet(CCObject *pSender)
{
	CCUserDefault::sharedUserDefault()->setIntegerForKey("LEVEL",0);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("SCORE",0);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("SKIPTIMES",2);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("ZOOMTIMES",3);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("REMOVETIMES",4);
	CCUserDefault::sharedUserDefault()->flush();
}