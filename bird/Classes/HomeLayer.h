#ifndef __HOMELAYER_SCENE_H__
#define __HOMELAYER_SCENE_H__
#pragma once
#include "cocos2d.h"
class HomeLayer :public cocos2d::CCLayer
{
public:
	
	HomeLayer(void);
	~HomeLayer(void);

	//��ʼ������
	virtual bool init();
	//��������
	 static cocos2d::CCScene* scene();

	void easyBtnCallBack(CCObject* pSender);
	void norBtnCallBack(CCObject* pSender);
	void hardBtnCallBack(CCObject* pSender);

	//����HomeLayer��
	CREATE_FUNC(HomeLayer);
};
#endif

