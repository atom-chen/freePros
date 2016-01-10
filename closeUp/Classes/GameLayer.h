#pragma once
#include "cocos2d.h"
#include "Letters.h"
USING_NS_CC;
class GameLayer :
	public CCLayer
{
public:
	GameLayer(void);
	~GameLayer(void);

	virtual bool init();
	static CCScene *scene();
	CREATE_FUNC(GameLayer);
	void ccTouchesBegan(CCSet *pTouches, CCEvent *pEvent);

	CCSprite *bg;
	CCSprite *touchChar;
	CCSprite *incorrect; //打错背景图
	CCSprite *complete;  //答对背景图
	CCSprite *buy;        //商店背景图

	CCArray *imgs;
	CCString *imgFile;
	CCString *imgName;
	CCString *guessName;
	CCDictionary *dic;

	CCArray *blocksprites;
	CCArray *guessword;
	CCArray *rightword;
	CCArray *charsprites; //字母精灵数组
	const char *guessname;
	const char *imgname;
	CCPoint charspos[18];
	CCArray *chars;

	CCLabelTTF *Level;
	int level;
	CCLabelTTF *kipTimes;
	int kiptimes;
	CCLabelTTF *score; 
	int sumScore;
	CCLabelTTF *zoomTimes; 
	int zoomtimes;
	CCLabelTTF *removeTimes;
	int removetimes;


	//赢的层
	void winlayer();
	//购买层
	void buylayer();
	//判断是否过关
	bool judgewin();
	//保存游戏数据
	void saveDatas();
	//将字母放入数组
	void charToarray();
	//添加输入框
	void intoBlockSprites();
	//添加字符块
	void intoCharSprites();
	//添加按钮
	void intobuttons();
	//按钮调用函数
	void backBtn(CCObject *pSender);
	void skipBtn(CCObject *pSender);
	void zoomBtn(CCObject *pSender);
	void removeBtn(CCObject *pSender);
	void freeBtn(CCObject *pSender);
	void facebookBtn(CCObject *pSender);
	void twitterBtn(CCObject *pSender);
	void continueBtn(CCObject *pSender);
	void closeBtn(CCObject *pSender);
	void oneBtn(CCObject *pSender);
	void twoBtn(CCObject *pSender);
	void threeBtn(CCObject *pSender);
	void fourBtn(CCObject *pSender);
};

