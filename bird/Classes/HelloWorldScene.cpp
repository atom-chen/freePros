#include "HelloWorldScene.h"
#include "iconv/iconv.h"
#include "SimpleAudioEngine.h"
#include "HomeLayer.h"

USING_NS_CC;
using namespace std;
using namespace CocosDenshion;
//计时器
float curTime= 0.0f;
//间隔时间
float oneSec= 2.0f;
//定义小鸟容器
vector <CCSprite*> birdVec;
//分数值
int score= 0;
//生命值
int life= 5;
//score文本
CCLabelTTF *scoreLabel;
//life文本
CCLabelTTF *lifeLabel;
//gameOver 文本
CCLabelTTF *gameOverLabel;
//倒计时
int reTime=5;
//倒计时文本
CCLabelTTF *reTimeLable;
//按钮
CCMenu *menu;


CCScene* HelloWorld::scene()
{
    // 'scene' is an autorelease object
	//创建场景对象
    CCScene *scene = CCScene::create();
    
    // 'layer' is an autorelease object
	//创建HelloWorld对象 layer层
    HelloWorld *layer = HelloWorld::create();

    // add layer as a child to scene
	//将层放进场景中
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
	//添加场景
	CCSprite *bg= CCSprite::create("background.png");
	//设置场景显示的坐标  CCSprite *bg=CCSprite::create("background.png") bg->setPosition(ccp(320,480))
	bg->setPosition(ccp(320,480));
	//将场景添加到窗体上
	this->addChild(bg);

	//定义生成小鸟定时器 schedule(schedule_selector(HelloWorld::update)); setTouchEnabled(true)
	schedule(schedule_selector(HelloWorld::update));
	//开启鼠标点击
	setTouchEnabled(true);

	//创建生命值文本 char lifeArr[10] sprintf(lifeArr,"life:%d",life) lifeLabel=CCLabelTTF::create(lifeArr,"Arial",50)  lifeLabel->setp
	//第一个参数：显示的文字内容
	//第二个参数：字体样式
	//第三个参数:字体的大小
	/*char lifeArr[10];
	sprintf(lifeArr,"life:%d",life);*/
	lifeLabel= CCLabelTTF::create("life:5","Arial",50);
	lifeLabel->setPosition(ccp(350,900));
	this->addChild(lifeLabel);
	
	//创建分数文本
	scoreLabel= CCLabelTTF::create("score:0","Arial",50);
	scoreLabel->setPosition(ccp(100,900));
	this->addChild(scoreLabel);

	//创建gameover文本
	gameOverLabel= CCLabelTTF::create("GAME OVER","Arial",100);
	gameOverLabel->setPosition(ccp(320,480));
	this->addChild(gameOverLabel);

	//隐藏gameOver文本
	gameOverLabel->setVisible(false);

	//添加背景音乐
	SimpleAudioEngine::sharedEngine()->playBackgroundMusic("music.mid",true);
	//添加暂停按钮
	//按钮菜单
	CCMenuItemImage *pauseImage= CCMenuItemImage::create("CloseNormal.png","CloseSelected.png",this,menu_selector(HelloWorld::menuCloseCallback));  /*理解*/
	//menu=CCMenu::create(pauseImage,NULL);
	//menu->setPosition(ccp(600,900));
	//this->addChild(menu);

	//创建返回按钮
	CCLabelTTF *backLable=CCLabelTTF::create("back","Arial",40);

	CCMenuItemLabel *backItem=CCMenuItemLabel::create(backLable,this,menu_selector(HelloWorld::backBtnCallBack)); /*理解*/
	menu=CCMenu::create(pauseImage,backItem,NULL);
	menu->alignItemsVerticallyWithPadding(30);
	menu->setPosition(ccp(500,900));
	this->addChild(menu);


	char reTimeArr[10];
	sprintf(reTimeArr,"%d",reTime);
   //创建倒计时文本
	reTimeLable=CCLabelTTF::create(reTimeArr,"Arial",80);
	reTimeLable->setPosition(ccp(320,480));
	this->addChild(reTimeLable);
   //隐藏倒计时文本
	reTimeLable->setVisible(false);
    return true;
	
}

//回调生成小鸟定时器方法
void HelloWorld::update(float dt)
{
	// 游戏结束 gameOverLabel->setVisible(true) menu->setVisible(false) vector <CCSprite*>::iterator birdIter for (birdIter=birdVec.begin();birdIter1=birdVec.end())
	//计时时间
	curTime+=dt;
	//CCLOG("curTime=%f",curTime);

	if(curTime>oneSec){
		//添加小鸟
		CCSprite *bird= CCSprite::create("bird.png");
		//设置坐标
		int rH=rand()%960;
		bird->setPosition(ccp(-60,rH));
		//添加到窗体上
		this->addChild(bird);
		//将小鸟添加到容器里
		birdVec.push_back(bird);

		//让小鸟动起来
		//第一个参数：小鸟运动的速度
		//第二个参数:小鸟运动后的终点坐标
		int yH=rand()%960;
		CCMoveTo *moveTo= CCMoveTo::create(3.0f,ccp(700,yH));
		bird->runAction(moveTo);
		curTime-= oneSec;
		//生成小鸟的速度越来越快
		if(oneSec>0.2)
		{
			oneSec-= dt;
		}
	}

	if(life==0)
	{
		//关闭定时器
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
	
	//迭代器
	vector <CCSprite*>::iterator birdIter;
	//循环容器里面的小鸟
	for (birdIter= birdVec.begin();birdIter!=birdVec.end();)
	{
		//取出每一只小鸟
		CCSprite *bird= *birdIter;
		//获得小鸟的X轴坐标，并判断小鸟的X轴坐标是否超出窗体X轴的最大值
		if(bird->getPositionX()>640)
		{
			//超出窗体范围的时候消除小鸟
			bird->removeFromParent();
			//销毁容器
			//迭代器失效
			//返回新的迭代器
			birdIter= birdVec.erase(birdIter);
			//计算生命值
			life--;
			char lifeArr[10];
			sprintf(lifeArr,"life:%d",life);
			lifeLabel->setString(lifeArr);

			//添加音效
			SimpleAudioEngine::sharedEngine()->playEffect("1270.mp3");
		}
		else
		{
			birdIter++;
		}
	}
	
}
//回调鼠标点击事件
void HelloWorld::ccTouchesBegan(cocos2d::CCSet *pTouches, cocos2d::CCEvent *pEvent)
{
	//游戏结束后点击窗体重新开始游戏
	if(life==0)
	{
		gameOverLabel->setVisible(false);
		menu->setVisible(true);
		//初始化生命值
		life= 5;
		char lifeArr[10];
		sprintf(lifeArr,"life:%d",life);
		lifeLabel->setString(lifeArr);
		//初始化分数值
		score= 0;
		char scoreArr[10];
		sprintf(scoreArr,"score:%d",score);
		scoreLabel->setString(scoreArr);
		//初始化间隔时间
		oneSec= 2.0f;

		schedule(schedule_selector(HelloWorld::update));
	}
	//获得鼠标点击的坐标
	CCTouch *touch= (CCTouch *)pTouches->anyObject();
	CCPoint point= touch->getLocation();
	//鼠标点击的X轴和Y轴
	//CCLOG("x=%f",point.x);
	//CCLOG("y=%f",point.y);

	vector <CCSprite*>::iterator birdIter;
	for (birdIter=birdVec.begin();birdIter!=birdVec.end();)
	{
		//取出每一只小鸟
		CCSprite *bird= *birdIter;
		//获得小鸟的矩形区域
		CCRect birdRect= bird->boundingBox();
		//判断鼠标点击的位置是否包含在小鸟的矩形区域里面
		if (birdRect.containsPoint(point))
		{
//			CCLOG("point");
			//移除小鸟
			bird->removeFromParent();
			//销毁容器
			//迭代器失效
			//返回新的迭代器
			birdIter= birdVec.erase(birdIter);
			//计算分数值
			score++;
			char scoreArr[10];
			sprintf(scoreArr,"score:%d",score);
			scoreLabel->setString(scoreArr);
			//添加音效
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
	//判断游戏是否是暂停状态
	if (CCDirector::sharedDirector()->isPaused())
	{
		//恢复游戏
		CCDirector::sharedDirector()->resume();

		//关闭小鸟生成定时器
		unschedule(schedule_selector(HelloWorld::update));
		//暂停所有小鸟
		
		vector<CCSprite*>::iterator birdIter;
		for (birdIter=birdVec.begin();birdIter!=birdVec.end();birdIter++)
		{
			CCSprite *bird=*birdIter;
			//暂停小鸟动作
			bird->pauseSchedulerAndActions();
		}
		//定义倒计时定时器
		schedule(schedule_selector(HelloWorld::reTimeCallBack),1.0f);
	}
	else
	{
	//暂停游戏
	//CCDirector导演
	//sharedDirector:是获取CCDirector实例
	CCDirector::sharedDirector()->pause();
	//关闭鼠标点击
	setTouchEnabled(false);
	}
	//关闭
   //CCDirector::sharedDirector()->end();

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    exit(0);
#endif
}
//回调倒计时函数
void HelloWorld::reTimeCallBack(float dt)
{
	//倒计时没结束时计算倒计时，给文本赋值
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
		//初始化倒计时
		reTime=5;
 		//隐藏倒计时文本
		reTimeLable->setVisible(false);
		//循坏容器里的小鸟，并且恢复每一只小鸟动作
		vector <CCSprite*>::iterator birdIter;
		for (birdIter=birdVec.begin();birdIter!=birdVec.end();birdIter++)
		{
			CCSprite *bird=*birdIter;
			//恢复小鸟动作
			bird->resumeSchedulerAndActions();
		}
		//开启生成小鸟定时器
		schedule(schedule_selector(HelloWorld::update));
		//关闭倒计时定时器
		unschedule(schedule_selector(HelloWorld::reTimeCallBack));
		//显示暂停按钮
		menu->setVisible(true);
		//开启鼠标点击
		setTouchEnabled(true);
	}
}
void HelloWorld::backBtnCallBack(CCObject* pSender)
{
	score=0;
	life=5;
	//获得实例
	CCDirector* pDirector=CCDirector::sharedDirector();
	//获得helloworld场景
	CCScene* pScene=HomeLayer::scene();
	//替换场景
	pDirector->replaceScene(pScene);
}


