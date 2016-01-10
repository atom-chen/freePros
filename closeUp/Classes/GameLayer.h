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
	CCSprite *incorrect; //�����ͼ
	CCSprite *complete;  //��Ա���ͼ
	CCSprite *buy;        //�̵걳��ͼ

	CCArray *imgs;
	CCString *imgFile;
	CCString *imgName;
	CCString *guessName;
	CCDictionary *dic;

	CCArray *blocksprites;
	CCArray *guessword;
	CCArray *rightword;
	CCArray *charsprites; //��ĸ��������
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


	//Ӯ�Ĳ�
	void winlayer();
	//�����
	void buylayer();
	//�ж��Ƿ����
	bool judgewin();
	//������Ϸ����
	void saveDatas();
	//����ĸ��������
	void charToarray();
	//��������
	void intoBlockSprites();
	//����ַ���
	void intoCharSprites();
	//��Ӱ�ť
	void intobuttons();
	//��ť���ú���
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

