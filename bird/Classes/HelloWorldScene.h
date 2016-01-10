#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"

class HelloWorld : public cocos2d::CCLayer
{
public:
    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
	//初始化函数
    virtual bool init();  

    // there's no 'id' in cpp, so we recommend returning the class instance pointer
	//静态创建函数
    static cocos2d::CCScene* scene();
    
    // a selector callback
	//菜单的一个回调函数
    void menuCloseCallback(CCObject* pSender);
    
    // implement the "static node()" method manually
    CREATE_FUNC(HelloWorld);
	//声明方法
	void update(float dt);
	//声明鼠标点击函数
	void ccTouchesBegan(cocos2d::CCSet *pTouches,cocos2d::CCEvent *pEvent);
	//声明
	void reTimeCallBack(float dt);
	void backBtnCallBack(CCObject* pSender);
};

#endif // __HELLOWORLD_SCENE_H__
