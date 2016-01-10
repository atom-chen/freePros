#ifndef __HOMELAYER_SCENE_H__
#define __HOMELAYER_SCENE_H__
#pragma once
#include "cocos2d.h"
class HomeLayer :public cocos2d::CCLayer
{
public:
	
	HomeLayer(void);
	~HomeLayer(void);

	//初始化函数
	virtual bool init();
	//创建场景
	 static cocos2d::CCScene* scene();

	void easyBtnCallBack(CCObject* pSender);
	void norBtnCallBack(CCObject* pSender);
	void hardBtnCallBack(CCObject* pSender);

	//创建HomeLayer类
	CREATE_FUNC(HomeLayer);
};
#endif

