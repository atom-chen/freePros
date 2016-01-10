#pragma once
#include "cocos2d.h"
USING_NS_CC;
class Letters
{
public:
	Letters(void);
	~Letters(void);
	static CCSprite *create(char *imag,char *c,int size,ccColor3B& color3);
};

