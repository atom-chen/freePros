#include "Letters.h"


Letters::Letters(void)
{
}

Letters::~Letters(void)
{
}
CCSprite *Letters::create(char *imag,char *c,int size,ccColor3B& color3)
{
	CCSprite *bg=CCSprite::create(imag);
	CCLabelTTF *word=CCLabelTTF::create(c,"",size);
	word->setPosition(ccp(bg->getContentSize().width/2,bg->getContentSize().height/2));
	word->setColor(color3);

	bg->addChild(word);

	return bg;
}