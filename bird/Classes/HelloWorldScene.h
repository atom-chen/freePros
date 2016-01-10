#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"

class HelloWorld : public cocos2d::CCLayer
{
public:
    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
	//��ʼ������
    virtual bool init();  

    // there's no 'id' in cpp, so we recommend returning the class instance pointer
	//��̬��������
    static cocos2d::CCScene* scene();
    
    // a selector callback
	//�˵���һ���ص�����
    void menuCloseCallback(CCObject* pSender);
    
    // implement the "static node()" method manually
    CREATE_FUNC(HelloWorld);
	//��������
	void update(float dt);
	//�������������
	void ccTouchesBegan(cocos2d::CCSet *pTouches,cocos2d::CCEvent *pEvent);
	//����
	void reTimeCallBack(float dt);
	void backBtnCallBack(CCObject* pSender);
};

#endif // __HELLOWORLD_SCENE_H__
