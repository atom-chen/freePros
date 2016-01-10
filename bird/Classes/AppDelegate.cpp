#include "AppDelegate.h"
#include "HelloWorldScene.h"
#include "HomeLayer.h"
USING_NS_CC;

AppDelegate::AppDelegate() {

}

AppDelegate::~AppDelegate() 
{
}

bool AppDelegate::applicationDidFinishLaunching() {
    // initialize director
    CCDirector* pDirector = CCDirector::sharedDirector();
    CCEGLView* pEGLView = CCEGLView::sharedOpenGLView();

    pDirector->setOpenGLView(pEGLView);
	
    // turn on display FPS
	//开关显示帧率
    pDirector->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
	//设置帧率（每1秒60次）
    pDirector->setAnimationInterval(1.0 / 60);

    // create a scene. it's an autorelease object
	//获得场景
   // CCScene *pScene = HelloWorld::scene();
	  CCScene *pScene = HomeLayer::scene();

    // run
	//运行场景
    pDirector->runWithScene(pScene);

	//设置分辨率
	pDirector->getOpenGLView()->setDesignResolutionSize(640,960,kResolutionNoBorder);

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground() {
    CCDirector::sharedDirector()->stopAnimation();

    // if you use SimpleAudioEngine, it must be pause
    // SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground() {
    CCDirector::sharedDirector()->startAnimation();

    // if you use SimpleAudioEngine, it must resume here
    // SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}
