#pragma once
#include "cocos2d.h"
USING_NS_CC;
class Reset :
	public CCLayer
{
public:
	Reset(void);
	~Reset(void);
	virtual bool init();
	static CCScene *scene();
	CREATE_FUNC(Reset);
	void backBtn(CCObject *pSender);
	void reSet(CCObject *pSender);
};

