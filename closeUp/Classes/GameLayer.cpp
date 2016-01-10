#include "GameLayer.h"
#include "HomeLayer.h"

static int num=0; //已输入字母个数

GameLayer::GameLayer(void)
{

}

GameLayer::~GameLayer(void)
{
}

CCScene* GameLayer::scene()
{
	CCScene *scene=CCScene::create();
	CCLayer *layer=GameLayer::create();
	scene->addChild(layer);
	return scene;
}

bool GameLayer::init()
{
	if (!CCLayer::init())
	{
		return false;
	}
	level=CCUserDefault::sharedUserDefault()->getIntegerForKey("LEVEL");
	sumScore=CCUserDefault::sharedUserDefault()->getIntegerForKey("SCORE");
	kiptimes=CCUserDefault::sharedUserDefault()->getIntegerForKey("SKIPTIMES");
	zoomtimes=CCUserDefault::sharedUserDefault()->getIntegerForKey("ZOOMTIMES");
	removetimes=CCUserDefault::sharedUserDefault()->getIntegerForKey("REMOVETIMES");

	//添加自己的代码
	blocksprites=CCArray::create();
	blocksprites->retain();
	charsprites=CCArray::create();
	charsprites->retain();
	guessword=CCArray::create();
	guessword->retain();
	rightword=CCArray::create();
	rightword->retain();
	chars=CCArray::create();
	chars->retain();
	//读取plist文件
	imgs=CCArray::createWithContentsOfFile("imgs.plist");
	imgs->retain();
	dic = (CCDictionary *)imgs->objectAtIndex(level);
	imgFile=CCString::createWithFormat("%s",dic->valueForKey("imgFile")->getCString());
	imgName=CCString::createWithFormat("%s",dic->valueForKey("imgName")->getCString());
	imgName->retain();
	guessName=CCString::createWithFormat("%s",dic->valueForKey("guessName")->getCString());
	guessName->retain();

	imgname=imgName->getCString();	
	guessname=guessName->getCString();
	 
	//将字母放入数组
	charToarray();
	//添加猜的图片
	//0.135缩放刚好
	CCString *str= CCString::createWithFormat("images/%s",imgFile->getCString());
	bg=CCSprite::create(str->getCString());
	bg->setPosition(ccp(160,312));
	bg->setAnchorPoint(ccp(0.7,0.7));
	bg->setScale(0.35);
	addChild(bg);
	//添加边框
	CCSprite *masker=CCSprite::create("masker.png");
	masker->setPosition(ccp(160,240));
	addChild(masker);
	//添加输入框
	intoBlockSprites();
	//添加字符块
     intoCharSprites();
	 //添加按钮
	 intobuttons();

	 incorrect=CCSprite::create("incorrect.png");
	 incorrect->setPosition(ccp(160,240));
	 addChild(incorrect);
	 incorrect->setVisible(false);

	 setTouchEnabled(true);
	return true;
}
//赢的层
void GameLayer::winlayer()
{
	complete=CCSprite::create("incorrect.png");
	complete->setPosition(ccp(160,240));
	complete->setColor(ccc3(0,0,0));

	CCParticleSystemQuad *quad = CCParticleSystemQuad::create("xinxin.plist");
	complete->addChild(quad);

	CCSprite *well=Letters::create("grass.png","Well done!",40,ccc3(255,255,255));
	well->setPosition(ccp(160,445));
	well->setOpacity(150);
	complete->addChild(well);

	CCSprite *sco=Letters::create("score-box.png","",30,ccc3(255,255,255));
	score=CCLabelTTF::create("0","",30);
	score->setPosition(ccp(sco->getContentSize().width/2,sco->getContentSize().height/2));
	CCString *s=CCString::createWithFormat("%d",sumScore);
	score->setString(s->getCString());
	sco->addChild(score);
	sco->setPosition(ccp(160,230));
	complete->addChild(sco);

	CCSprite *continu=Letters::create("green-button.png","Continue",30,ccc3(255,255,255));
	CCMenuItemSprite *conItem=CCMenuItemSprite::create(continu,continu,this,menu_selector(GameLayer::continueBtn));
	CCMenu *continueMenu=CCMenu::create(conItem,NULL);
	continueMenu->setPosition(ccp(160,100));
	complete->addChild(continueMenu);
	addChild(complete);	
}
//购买层
void GameLayer::buylayer()
{
	buy=CCSprite::create("complete.png");
	buy->setPosition(ccp(160,240));
	addChild(buy);

	CCSprite *kon=CCSprite::create("background.jpg");
	kon->setScale(0.76);
	kon->setColor(ccc3(255,255,255));
	kon->setPosition(ccp(180,285));
    buy->addChild(kon);

	CCLabelTTF *re=CCLabelTTF::create("Remove Outs","",50);
	re->setPosition(ccp(180,500));
	kon->addChild(re);

	CCSprite *clo=CCSprite::create("close.png");
	CCMenuItemSprite *cloItem=CCMenuItemSprite::create(clo,clo,this,menu_selector(GameLayer::closeBtn));
	CCMenu *cloMenu=CCMenu::create(cloItem,NULL);
	cloMenu->setPosition(ccp(355,565));
	kon->addChild(cloMenu);

	CCSprite *one=Letters::create("green-button.png","1x-$3.0",30,ccc3(255,255,255));
	CCMenuItemSprite *oneItem=CCMenuItemSprite::create(one,one,this,menu_selector(GameLayer::oneBtn));
	CCSprite *two=Letters::create("green-button.png","2x-$5.0",30,ccc3(255,255,255));
	CCMenuItemSprite *twoItem=CCMenuItemSprite::create(two,two,this,menu_selector(GameLayer::twoBtn));
	CCSprite *three=Letters::create("green-button.png","3x-$7.0",30,ccc3(255,255,255));
	CCMenuItemSprite *threeItem=CCMenuItemSprite::create(three,three,this,menu_selector(GameLayer::threeBtn));
	CCSprite *four=Letters::create("green-button.png","4x-$9.0",30,ccc3(255,255,255));
	CCMenuItemSprite *fourItem=CCMenuItemSprite::create(four,four,this,menu_selector(GameLayer::fourBtn));
	CCMenu *menu=CCMenu::create(oneItem,twoItem,threeItem,fourItem,NULL);
	menu->setPosition(ccp(213,290));
	menu->alignItemsVerticallyWithPadding(20);
	menu->setScale(1.2);
	kon->addChild(menu);
}
//添加输入框
void GameLayer::intoBlockSprites()
{
	int m=imgName->length()-2;
	for (int i=0;i<imgName->length()+1;i++)
	{
		CCSprite *block=CCSprite::create("block.png");
		block->setPosition(ccp(145+i*30-15*m,166));
		addChild(block);
		blocksprites->addObject(block);
		//末尾另外添加一个，设置不可见
		if (i==imgName->length())
		{
			block->setVisible(false);
		}
	}
}
//将字母放入数组
void GameLayer::charToarray()
{
	for (int i=0;i<guessName->length();i++)
	{
		CCString *str=CCString::createWithFormat("%c",*(guessname+i));
		chars->addObject(str);
	}
	for (int j=0;j<imgName->length();j++)
	{
		CCString *str=CCString::createWithFormat("%c",*(imgname+j));
		rightword->addObject(str);
	}
}
//添加字符块
void GameLayer::intoCharSprites()
{
	for (int i=0;i<3;i++)
	{ 
		for (int j=0;j<6;j++)
		{
			const char *ch=((CCString *)chars->objectAtIndex(i*6+j))->getCString();
			CCSprite *c=Letters::create("letter.png",(char *)ch,25,ccc3(0,0,0));
			c->setPosition(ccp(57+j*40+4,120-i*43));
			c->setTag(i*6+j);
			addChild(c);
			charsprites->addObject(c);
			charspos[i*6+j]=c->getPosition();
		}
	}
}
//鼠标点击事件
void GameLayer::ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent)
{	
	CCTouch *touch= (CCTouch *)pTouches->anyObject();
	CCPoint point= touch->getLocation();
	for (int i=0;i<charsprites->count();i++)
	{
		touchChar=(CCSprite *)charsprites->objectAtIndex(i);
		CCRect wordRect=touchChar->boundingBox();		
		if (wordRect.containsPoint(point))
		{
			CCPoint wordposition=touchChar->getPosition();
			CCSprite *block=(CCSprite *)blocksprites->objectAtIndex(num);
			CCPoint p=block->getPosition();
			if ( wordposition.y==p.y && wordposition.x==p.x-30 )
			{		
				int tag=touchChar->getTag();
				CCMoveTo *back=CCMoveTo::create(0.5,ccp(charspos[tag].x,charspos[tag].y));
				touchChar->runAction(back);
				touchChar->setScale(1);
				guessword->removeLastObject(true);
				incorrect->setVisible(false);
				num--;
			}
			if(wordposition.y!=p.y)
			{
				if (num< rightword->count())
				{
					CCMoveTo *to=CCMoveTo::create(0.5,ccp(p.x,p.y));
					touchChar->runAction(to);
					touchChar->setScale(0.75);
					int tag=touchChar->getTag();
					CCString *str=CCString::createWithFormat("%c",*(guessname+tag));
					guessword->addObject(str);
					num++;
					if (judgewin())
					{
						saveDatas();
						winlayer();			
					}
				}
			}		
		}
	}	
}
//判断是否过关
bool GameLayer::judgewin()
{
	if (num==rightword->count())
	{		
		if (guessword->isEqualToArray(rightword))
		{
			level++;
			sumScore+=50;
			bg->setAnchorPoint(ccp(0.5,0.5));
			CCScaleTo *to=CCScaleTo::create(1,0.135);
			bg->runAction(to);
			return true;
		} 
		else
		{
			incorrect->setVisible(true);
		}
	}
	return false;
}
//保存游戏数据
void GameLayer::saveDatas()
{
	CCUserDefault::sharedUserDefault()->setIntegerForKey("LEVEL",level);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("SCORE",sumScore);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("SKIPTIMES",kiptimes);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("ZOOMTIMES",zoomtimes);
	CCUserDefault::sharedUserDefault()->setIntegerForKey("REMOVETIMES",removetimes);
	CCUserDefault::sharedUserDefault()->flush();
}

//添加按钮
void GameLayer::intobuttons()
{
	//返回按钮
	CCMenuItemImage *back=CCMenuItemImage::create("back@2x.png","back-over@2x.png",this,menu_selector(GameLayer::backBtn));
	back->setScale(0.5);
	CCMenu *backMenu=CCMenu::create(back,NULL);
	backMenu->setPosition(ccp(44,459));
	addChild(backMenu);

	//下一关菜单
	CCMenuItemImage *skip=CCMenuItemImage::create("skip-btn.png","skip-btn-over.png",this,menu_selector(GameLayer::skipBtn));
	//缩放菜单
	CCMenuItemImage *zoom=CCMenuItemImage::create("zoom.png","zoom-over.png",this,menu_selector(GameLayer::zoomBtn));
	//去除菜单
	CCMenuItemImage *remove=CCMenuItemImage::create("remove-btn.png","remove-btn-over.png",this,menu_selector(GameLayer::removeBtn));	
	//右边的按钮
	CCMenu *rightMenu=CCMenu::create(skip,zoom,remove,NULL);
	rightMenu->alignItemsVerticallyWithPadding(4);
	rightMenu->setPosition(ccp(300,262));
	addChild(rightMenu);

	//添加跳过次数文本
	kipTimes=CCLabelTTF::create("","",10);
	kipTimes->setPosition(ccp(312,316));
	CCString *k=CCString::createWithFormat("%d",kiptimes);
	kipTimes->setString(k->getCString());
	addChild(kipTimes);
	//添加可缩放次数文本
	zoomTimes=CCLabelTTF::create("","",10);
	zoomTimes->setPosition(ccp(312,272));
	CCString *z=CCString::createWithFormat("%d",zoomtimes);
	zoomTimes->setString(z->getCString());
	addChild(zoomTimes);
	//添加可移除次数文本
	removeTimes=CCLabelTTF::create("","",10);
	removeTimes->setPosition(ccp(312,228));
	CCString *r=CCString::createWithFormat("%d",removetimes);
	removeTimes->setString(r->getCString());
	addChild(removeTimes);

	//五角星菜单
	CCMenuItemImage *free=CCMenuItemImage::create("free.png","free-over.png",this,menu_selector(GameLayer::freeBtn));
	// facebook 菜单
	CCMenuItemImage *facebook=CCMenuItemImage::create("facebookBtn.png","facebookBtn-over.png",this,menu_selector(GameLayer::facebookBtn));
	//小鸟菜单
	CCMenuItemImage *twitter=CCMenuItemImage::create("twitterBtn.png","twitterBtn-over.png",this,menu_selector(GameLayer::twitterBtn));
	//左边按钮
	CCMenu *leftMenu=CCMenu::create(free,facebook,twitter,NULL);
	leftMenu->alignItemsVerticallyWithPadding(4);
	leftMenu->setPosition(ccp(20,262));
	addChild(leftMenu);
	//关卡文本和进度条
	Level=CCLabelTTF::create("level","",15);
	Level->setPosition(ccp(160,465));
	CCString *lev=CCString::createWithFormat("level %d",level+1);
	Level->setString(lev->getCString());
	addChild(Level);
	CCSprite *levelBar=CCSprite::create("level-bar.png");
	levelBar->setPosition(ccp(160,445));
	addChild(levelBar);
	CCSprite *bar=CCSprite::create("Box.png");
	bar->setScaleY(16.0/29);
	bar->setScaleX(12.5*level/293);
	bar->setPosition(ccp(103.75+level*6.25,445));
	bar->setColor(ccc3(0,255,0));
	addChild(bar);
	//分数文本
	score=CCLabelTTF::create("","",20);
	score->setPosition(ccp(300,460));
	CCString *sco=CCString::createWithFormat("%d",sumScore);
	score->setString(sco->getCString());
	addChild(score);
}
//按钮调用函数
void GameLayer::backBtn(CCObject *pSender)
{
	num=0;
	CCScene *scene=HomeLayer::scene();
	CCTransitionCrossFade *co=CCTransitionCrossFade::create(0.1,scene);
	CCDirector::sharedDirector()->replaceScene(co);
}
void GameLayer::skipBtn(CCObject *pSender)
{
	if (kiptimes>0)
	{
		level++;
		kiptimes--;
		saveDatas();
		CCScene *scene=GameLayer::scene();
		CCTransitionFadeUp *co=CCTransitionFadeUp::create(1,scene);
		CCDirector::sharedDirector()->replaceScene(co);
	}
}
void GameLayer::zoomBtn(CCObject *pSender)
{
	static int n=1;
	if (zoomtimes>0)
	{
		zoomtimes--;
		CCString *str=CCString::createWithFormat("%d",zoomtimes);
		zoomTimes->setString(str->getCString());
		bg->setScale(0.35-0.04*n++);
	}
}
void GameLayer::removeBtn(CCObject *pSender)
{
	if (removetimes>0)
	{
		removetimes--;
		int tag[18]={0};
		int tg;
		int n=0;
		srand((unsigned int)time(NULL));
		unsigned ran;
		bool fla=0;
		//获得在下面所有字符的标号
		for (int i=0;i<chars->count();i++)
		{
			CCSprite *ch=(CCSprite *)charsprites->objectAtIndex(i);
			CCPoint p=ch->getPosition();
			if (p.y!=166)
			{
				tag[n++]=ch->getTag();
			}
		}
		CCLOG("%d",n);
		do 
		{
			fla=0;
			srand((unsigned int)time(NULL)+rand());
			ran=rand()%n;
			tg=tag[ran];
			//判断字符是否是正确单词里的
			CCString *charRand=CCString::createWithFormat("%c",*(guessname+tg));
			for (int j=0;j<rightword->count();j++)
			{
				CCString *rightchar=CCString::createWithFormat("%c",*(imgname+j));
				if (charRand->isEqual(rightchar)) {fla=1;CCLOG("%c %c",*(guessname+tg),*(imgname+j));break;}			
			}
		} while (fla);
		
		CCSprite *sp=(CCSprite *)charsprites->objectAtIndex(tg);
		sp->setVisible(false);
		sp->setPositionY(166);
		CCString *str=CCString::createWithFormat("%d",removetimes);
		removeTimes->setString(str->getCString());
	}
	else
	{
		buylayer();
	}
}
void GameLayer::freeBtn(CCObject *pSender)
{

}
void GameLayer::facebookBtn(CCObject *pSender)
{

}
void GameLayer::twitterBtn(CCObject *pSender)
{

}
void GameLayer::continueBtn(CCObject *pSender)
{
	num=0;
	CCScene *scene=GameLayer::scene();
	CCTransitionCrossFade *c=CCTransitionCrossFade::create(1,scene);
	CCDirector::sharedDirector()->replaceScene(c);
}
void GameLayer::closeBtn(CCObject *pSender)
{
	buy->setVisible(false);
}
void GameLayer::oneBtn(CCObject *pSender)
{
	removetimes++;
	CCString *str=CCString::createWithFormat("%d",removetimes);
	removeTimes->setString(str->getCString());
}
void GameLayer::twoBtn(CCObject *pSender)
{
	removetimes+=2;
	CCString *str=CCString::createWithFormat("%d",removetimes);
	removeTimes->setString(str->getCString());
}
void GameLayer::threeBtn(CCObject *pSender)
{
	removetimes+=3;
	CCString *str=CCString::createWithFormat("%d",removetimes);
	removeTimes->setString(str->getCString());
}
void GameLayer::fourBtn(CCObject *pSender)
{
	removetimes+=4;
	CCString *str=CCString::createWithFormat("%d",removetimes);
	removeTimes->setString(str->getCString());
}