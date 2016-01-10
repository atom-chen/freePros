#pragma once
#include "cocos2d.h"
USING_NS_CC;
class Default :
	public CCLayer
{
public:
	Default(void);
	~Default(void);
	virtual bool init();
	static CCScene *scene();
	CREATE_FUNC(Default);
	void callFun();

};

