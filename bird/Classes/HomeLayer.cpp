#include "HomeLayer.h"
#include "HelloWorldScene.h"
USING_NS_CC;
//外部变量
 extern float oneSec;

HomeLayer::HomeLayer(void)
{
}


HomeLayer::~HomeLayer(void)
{
}
CCScene* HomeLayer::scene()
{
	// 'scene' is an autorelease object
	CCScene *scene = CCScene::create();

	// 'layer' is an autorelease object
	HomeLayer *layer = HomeLayer::create();

	// add layer as a child to scene
	scene->addChild(layer);

	// return the scene
	return scene;
}
bool HomeLayer::init()
{
	//////////////////////////////
	// 1. super init first
	if ( !CCLayer::init() )
	{
		return false;
	}
	//创建场景
	CCSprite *bg=CCSprite::create("background.png");
	bg->setPosition(ccp(320,480));
	this->addChild(bg);
	//创建简单模式
	CCLabelTTF *easyLable=CCLabelTTF::create("easy","Arial",50);
	CCMenuItemLabel *easyItem=CCMenuItemLabel::create(easyLable,this,menu_selector(HomeLayer::easyBtnCallBack));
		//创建一般模式,
	CCLabelTTF *norLable=CCLabelTTF::create("normal","Arial",50);
	CCMenuItemLabel *norItem=CCMenuItemLabel::create(norLable,this,menu_selector(HomeLayer::norBtnCallBack));
	//创建困难模式
	CCLabelTTF *hardLable=CCLabelTTF::create("hard","Arial",50);
	CCMenuItemLabel *hardItem=CCMenuItemLabel::create(hardLable,this,menu_selector(HomeLayer::hardBtnCallBack));


	//菜单载体
	CCMenu *menu=CCMenu::create(easyItem,norItem,hardItem,NULL);
	//竖排按钮，50是按钮间的间隔
	menu->alignItemsVerticallyWithPadding(50);
	menu->setPosition(ccp(320,480));
	addChild(menu);
	return true;
}
//回调简单模式函数
void HomeLayer::easyBtnCallBack(CCObject* pSender)
{
	//获得实例
	CCDirector* pDirector=CCDirector::sharedDirector();
	//获得helloworld场景
	CCScene* pScene=HelloWorld::scene();
	//替换场景
	pDirector->replaceScene(pScene);
	oneSec=5.0f;

}
void HomeLayer::norBtnCallBack(CCObject* pSender)
{
	//获得实例
	CCDirector* pDirector=CCDirector::sharedDirector();
	//获得helloworld场景
	CCScene* pScene=HelloWorld::scene();
	//替换场景
	pDirector->replaceScene(pScene);
	oneSec=3.0f;

}
void HomeLayer::hardBtnCallBack(CCObject* pSender)
{
	//获得实例
	CCDirector* pDirector=CCDirector::sharedDirector();
	//获得helloworld场景
	CCScene* pScene=HelloWorld::scene();
	//替换场景
	pDirector->replaceScene(pScene);
	oneSec=1.0f;
}
