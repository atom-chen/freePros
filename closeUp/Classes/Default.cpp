#include "Default.h"
#include "HomeLayer.h"
Default::Default(void)
{
}

Default::~Default(void)
{
}

CCScene* Default::scene()
{
	CCScene *scene=CCScene::create();
	CCLayer *layer=Default::create();
	scene->addChild(layer);
	return scene;
}
bool Default::init()
{
	if (!CCLayer::init())
	{
		return false;
	}

	CCSprite *bg=CCSprite::create("Default.png");
	bg->setPosition(ccp(160,240));
	addChild(bg);

	CCFadeIn *fadein=CCFadeIn::create(2);
	CCCallFunc *cal=CCCallFunc::create(this,callfunc_selector(Default::callFun));
	CCSequence *quence=CCSequence::create(fadein,cal,NULL);
	bg->runAction(quence);
	return true;
}
void Default::callFun()
{
	CCScene *scene=HomeLayer::scene();
	CCDirector::sharedDirector()->replaceScene(scene);
}
