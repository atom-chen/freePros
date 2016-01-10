#pragma once
#include "cocos2d.h"
#include "Letters.h"
#include "cocos-ext.h"
USING_NS_CC;
USING_NS_CC_EXT;
class HomeLayer :
	public CCLayer,public CCScrollViewDelegate
{
public:
	HomeLayer(void);
	~HomeLayer(void);

	virtual bool init();
	static CCScene *scene();
	CREATE_FUNC(HomeLayer);

	CCScrollView *scroll;
	virtual void scrollViewDidScroll(CCScrollView* view);
	virtual void scrollViewDidZoom(CCScrollView* view);

	void playBtn(CCObject *pSender);
	void opBtn(CCObject *pSender);
	void moreBtn(CCObject *pSender);
};

