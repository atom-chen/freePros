#include "HelloWorldScene.h"
#include "iconv/iconv.h"
#include "SimpleAudioEngine.h"
#include "HomeLayer.h"

USING_NS_CC;
using namespace std;
using namespace CocosDenshion;
//��ʱ��
float curTime= 0.0f;
//���ʱ��
float oneSec= 2.0f;
//����С������
vector <CCSprite*> birdVec;
//����ֵ
int score= 0;
//����ֵ
int life= 5;
//score�ı�
CCLabelTTF *scoreLabel;
//life�ı�
CCLabelTTF *lifeLabel;
//gameOver �ı�
CCLabelTTF *gameOverLabel;
//����ʱ
int reTime=5;
//����ʱ�ı�
CCLabelTTF *reTimeLable;
//��ť
CCMenu *menu;


CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
	//������������
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
	//����HelloWorld���� layer��
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
	//����Ž�������
    scene->addChild(layer);

    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !CCLayer::init() )
    {
        return false;
    }
    
    CCSize visibleSize = CCDirector::sharedDirector()->getVisibleSize();
    CCPoint origin = CCDirector::sharedDirector()->getVisibleOrigin();
/*
    /////////////////////////////
    // 2. add a menu item with "X" image, which is clicked to quit the program
    //    you may modify it.

    // add a "close" icon to exit the progress. it's an autorelease object
    CCMenuItemImage *pCloseItem = CCMenuItemImage::create(
                                        "CloseNormal.png",
                                        "CloseSelected.png",
                                        this,
                                        menu_selector(HelloWorld::menuCloseCallback));
    
	pCloseItem->setPosition(ccp(origin.x + visibleSize.width - pCloseItem->getContentSize().width/2 ,
                                origin.y + pCloseItem->getContentSize().height/2));

    // create menu, it's an autorelease object
    CCMenu* pMenu = CCMenu::create(pCloseItem, NULL);
    pMenu->setPosition(CCPointZero);
    this->addChild(pMenu, 1);
*/
/*    
    /////////////////////////////
    // 3. add your codes below...

    // add a label shows "Hello World"
    // create and initialize a label

    CCLabelTTF* pLabel = CCLabelTTF::create("Hello World", "Arial", 24);
    
    // position the label on the center of the screen
    pLabel->setPosition(ccp(origin.x + visibleSize.width/2,
                            origin.y + visibleSize.height - pLabel->getContentSize().height));

    // add the label as a child to this layer
    this->addChild(pLabel, 1);

    // add "HelloWorld" splash screen"
    CCSprite* pSprite = CCSprite::create("HelloWorld.png");

    // position the sprite on the center of the screen
    pSprite->setPosition(ccp(visibleSize.width/2 + origin.x, visibleSize.height/2 + origin.y));

    // add the sprite as a child to this layer
    this->addChild(pSprite, 0);
*/
	//��ӳ���
	CCSprite *bg= CCSprite::create("background.png");
	//���ó�����ʾ������  CCSprite *bg=CCSprite::create("background.png") bg->setPosition(ccp(320,480))
	bg->setPosition(ccp(320,480));
	//��������ӵ�������
	this->addChild(bg);

	//��������С��ʱ�� schedule(schedule_selector(HelloWorld::update)); setTouchEnabled(true)
	schedule(schedule_selector(HelloWorld::update));
	//���������
	setTouchEnabled(true);

	//��������ֵ�ı� char lifeArr[10] sprintf(lifeArr,"life:%d",life) lifeLabel=CCLabelTTF::create(lifeArr,"Arial",50)  lifeLabel->setp
	//��һ����������ʾ����������
	//�ڶ���������������ʽ
	//����������:����Ĵ�С
	/*char lifeArr[10];
	sprintf(lifeArr,"life:%d",life);*/
	lifeLabel= CCLabelTTF::create("life:5","Arial",50);
	lifeLabel->setPosition(ccp(350,900));
	this->addChild(lifeLabel);
	
	//���������ı�
	scoreLabel= CCLabelTTF::create("score:0","Arial",50);
	scoreLabel->setPosition(ccp(100,900));
	this->addChild(scoreLabel);

	//����gameover�ı�
	gameOverLabel= CCLabelTTF::create("GAME OVER","Arial",100);
	gameOverLabel->setPosition(ccp(320,480));
	this->addChild(gameOverLabel);

	//����gameOver�ı�
	gameOverLabel->setVisible(false);

	//��ӱ�������
	SimpleAudioEngine::sharedEngine()->playBackgroundMusic("music.mid",true);
	//�����ͣ��ť
	//��ť�˵�
	CCMenuItemImage *pauseImage= CCMenuItemImage::create("CloseNormal.png","CloseSelected.png",this,menu_selector(HelloWorld::menuCloseCallback));  /*���*/
	//menu=CCMenu::create(pauseImage,NULL);
	//menu->setPosition(ccp(600,900));
	//this->addChild(menu);

	//�������ذ�ť
	CCLabelTTF *backLable=CCLabelTTF::create("back","Arial",40);

	CCMenuItemLabel *backItem=CCMenuItemLabel::create(backLable,this,menu_selector(HelloWorld::backBtnCallBack)); /*���*/
	menu=CCMenu::create(pauseImage,backItem,NULL);
	menu->alignItemsVerticallyWithPadding(30);
	menu->setPosition(ccp(500,900));
	this->addChild(menu);


	char reTimeArr[10];
	sprintf(reTimeArr,"%d",reTime);
   //��������ʱ�ı�
	reTimeLable=CCLabelTTF::create(reTimeArr,"Arial",80);
	reTimeLable->setPosition(ccp(320,480));
	this->addChild(reTimeLable);
   //���ص���ʱ�ı�
	reTimeLable->setVisible(false);
    return true;
	
}

//�ص�����С��ʱ������
void HelloWorld::update(float dt)
{
	// ��Ϸ���� gameOverLabel->setVisible(true) menu->setVisible(false) vector <CCSprite*>::iterator birdIter for (birdIter=birdVec.begin();birdIter1=birdVec.end())
	//��ʱʱ��
	curTime+=dt;
	//CCLOG("curTime=%f",curTime);

	if(curTime>oneSec){
		//���С��
		CCSprite *bird= CCSprite::create("bird.png");
		//��������
		int rH=rand()%960;
		bird->setPosition(ccp(-60,rH));
		//��ӵ�������
		this->addChild(bird);
		//��С����ӵ�������
		birdVec.push_back(bird);

		//��С������
		//��һ��������С���˶����ٶ�
		//�ڶ�������:С���˶�����յ�����
		int yH=rand()%960;
		CCMoveTo *moveTo= CCMoveTo::create(3.0f,ccp(700,yH));
		bird->runAction(moveTo);
		curTime-= oneSec;
		//����С����ٶ�Խ��Խ��
		if(oneSec>0.2)
		{
			oneSec-= dt;
		}
	}

	if(life==0)
	{
		//�رն�ʱ��
		unschedule(schedule_selector(HelloWorld::update));

		gameOverLabel->setVisible(true);
		menu->setVisible(false);

  		vector <CCSprite*>::iterator birdIter;
		for (birdIter= birdVec.begin();birdIter!=birdVec.end();)
		{
			CCSprite *bird= *birdIter;
			bird->removeFromParent();
			birdIter= birdVec.erase(birdIter);
		}
		
		
	}
	
	//������
	vector <CCSprite*>::iterator birdIter;
	//ѭ�����������С��
	for (birdIter= birdVec.begin();birdIter!=birdVec.end();)
	{
		//ȡ��ÿһֻС��
		CCSprite *bird= *birdIter;
		//���С���X�����꣬���ж�С���X�������Ƿ񳬳�����X������ֵ
		if(bird->getPositionX()>640)
		{
			//�������巶Χ��ʱ������С��
			bird->removeFromParent();
			//��������
			//������ʧЧ
			//�����µĵ�����
			birdIter= birdVec.erase(birdIter);
			//��������ֵ
			life--;
			char lifeArr[10];
			sprintf(lifeArr,"life:%d",life);
			lifeLabel->setString(lifeArr);

			//�����Ч
			SimpleAudioEngine::sharedEngine()->playEffect("1270.mp3");
		}
		else
		{
			birdIter++;
		}
	}
	
}
//�ص�������¼�
void HelloWorld::ccTouchesBegan(cocos2d::CCSet *pTouches, cocos2d::CCEvent *pEvent)
{
	//��Ϸ���������������¿�ʼ��Ϸ
	if(life==0)
	{
		gameOverLabel->setVisible(false);
		menu->setVisible(true);
		//��ʼ������ֵ
		life= 5;
		char lifeArr[10];
		sprintf(lifeArr,"life:%d",life);
		lifeLabel->setString(lifeArr);
		//��ʼ������ֵ
		score= 0;
		char scoreArr[10];
		sprintf(scoreArr,"score:%d",score);
		scoreLabel->setString(scoreArr);
		//��ʼ�����ʱ��
		oneSec= 2.0f;

		schedule(schedule_selector(HelloWorld::update));
	}
	//��������������
	CCTouch *touch= (CCTouch *)pTouches->anyObject();
	CCPoint point= touch->getLocation();
	//�������X���Y��
	//CCLOG("x=%f",point.x);
	//CCLOG("y=%f",point.y);

	vector <CCSprite*>::iterator birdIter;
	for (birdIter=birdVec.begin();birdIter!=birdVec.end();)
	{
		//ȡ��ÿһֻС��
		CCSprite *bird= *birdIter;
		//���С��ľ�������
		CCRect birdRect= bird->boundingBox();
		//�ж��������λ���Ƿ������С��ľ�����������
		if (birdRect.containsPoint(point))
		{
//			CCLOG("point");
			//�Ƴ�С��
			bird->removeFromParent();
			//��������
			//������ʧЧ
			//�����µĵ�����
			birdIter= birdVec.erase(birdIter);
			//�������ֵ
			score++;
			char scoreArr[10];
			sprintf(scoreArr,"score:%d",score);
			scoreLabel->setString(scoreArr);
			//�����Ч
			SimpleAudioEngine::sharedEngine()->playEffect("pew-pew-lei.wav");
		}
		else
		{
			birdIter++;
		}
	}
	
}
void HelloWorld::menuCloseCallback(CCObject* pSender)
{
	//�ж���Ϸ�Ƿ�����ͣ״̬
	if (CCDirector::sharedDirector()->isPaused())
	{
		//�ָ���Ϸ
		CCDirector::sharedDirector()->resume();

		//�ر�С�����ɶ�ʱ��
		unschedule(schedule_selector(HelloWorld::update));
		//��ͣ����С��
		
		vector<CCSprite*>::iterator birdIter;
		for (birdIter=birdVec.begin();birdIter!=birdVec.end();birdIter++)
		{
			CCSprite *bird=*birdIter;
			//��ͣС����
			bird->pauseSchedulerAndActions();
		}
		//���嵹��ʱ��ʱ��
		schedule(schedule_selector(HelloWorld::reTimeCallBack),1.0f);
	}
	else
	{
	//��ͣ��Ϸ
	//CCDirector����
	//sharedDirector:�ǻ�ȡCCDirectorʵ��
	CCDirector::sharedDirector()->pause();
	//�ر������
	setTouchEnabled(false);
	}
	//�ر�
   //CCDirector::sharedDirector()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
//�ص�����ʱ����
void HelloWorld::reTimeCallBack(float dt)
{
	//����ʱû����ʱ���㵹��ʱ�����ı���ֵ
	if (reTime>=0)
	{
		reTimeLable->setVisible(true);
		char reTimeArr[10];
		sprintf(reTimeArr,"%d",reTime);
		reTimeLable->setString(reTimeArr);
		reTime--;
		menu->setVisible(false);
	} 
	else
	{
		//��ʼ������ʱ
		reTime=5;
 		//���ص���ʱ�ı�
		reTimeLable->setVisible(false);
		//ѭ���������С�񣬲��һָ�ÿһֻС����
		vector <CCSprite*>::iterator birdIter;
		for (birdIter=birdVec.begin();birdIter!=birdVec.end();birdIter++)
		{
			CCSprite *bird=*birdIter;
			//�ָ�С����
			bird->resumeSchedulerAndActions();
		}
		//��������С��ʱ��
		schedule(schedule_selector(HelloWorld::update));
		//�رյ���ʱ��ʱ��
		unschedule(schedule_selector(HelloWorld::reTimeCallBack));
		//��ʾ��ͣ��ť
		menu->setVisible(true);
		//���������
		setTouchEnabled(true);
	}
}
void HelloWorld::backBtnCallBack(CCObject* pSender)
{
	score=0;
	life=5;
	//���ʵ��
	CCDirector* pDirector=CCDirector::sharedDirector();
	//���helloworld����
	CCScene* pScene=HomeLayer::scene();
	//�滻����
	pDirector->replaceScene(pScene);
}


