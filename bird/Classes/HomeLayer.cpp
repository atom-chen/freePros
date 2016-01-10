#include "HomeLayer.h"
#include "HelloWorldScene.h"
USING_NS_CC;
//�ⲿ����
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
	//��������
	CCSprite *bg=CCSprite::create("background.png");
	bg->setPosition(ccp(320,480));
	this->addChild(bg);
	//������ģʽ
	CCLabelTTF *easyLable=CCLabelTTF::create("easy","Arial",50);
	CCMenuItemLabel *easyItem=CCMenuItemLabel::create(easyLable,this,menu_selector(HomeLayer::easyBtnCallBack));
		//����һ��ģʽ,
	CCLabelTTF *norLable=CCLabelTTF::create("normal","Arial",50);
	CCMenuItemLabel *norItem=CCMenuItemLabel::create(norLable,this,menu_selector(HomeLayer::norBtnCallBack));
	//��������ģʽ
	CCLabelTTF *hardLable=CCLabelTTF::create("hard","Arial",50);
	CCMenuItemLabel *hardItem=CCMenuItemLabel::create(hardLable,this,menu_selector(HomeLayer::hardBtnCallBack));


	//�˵�����
	CCMenu *menu=CCMenu::create(easyItem,norItem,hardItem,NULL);
	//���Ű�ť��50�ǰ�ť��ļ��
	menu->alignItemsVerticallyWithPadding(50);
	menu->setPosition(ccp(320,480));
	addChild(menu);
	return true;
}
//�ص���ģʽ����
void HomeLayer::easyBtnCallBack(CCObject* pSender)
{
	//���ʵ��
	CCDirector* pDirector=CCDirector::sharedDirector();
	//���helloworld����
	CCScene* pScene=HelloWorld::scene();
	//�滻����
	pDirector->replaceScene(pScene);
	oneSec=5.0f;

}
void HomeLayer::norBtnCallBack(CCObject* pSender)
{
	//���ʵ��
	CCDirector* pDirector=CCDirector::sharedDirector();
	//���helloworld����
	CCScene* pScene=HelloWorld::scene();
	//�滻����
	pDirector->replaceScene(pScene);
	oneSec=3.0f;

}
void HomeLayer::hardBtnCallBack(CCObject* pSender)
{
	//���ʵ��
	CCDirector* pDirector=CCDirector::sharedDirector();
	//���helloworld����
	CCScene* pScene=HelloWorld::scene();
	//�滻����
	pDirector->replaceScene(pScene);
	oneSec=1.0f;
}
