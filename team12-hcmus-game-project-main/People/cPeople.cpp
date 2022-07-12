#include "cPeople.hpp"

cPeople::cPeople()
{
	mX = Width / 2 - 10;
	mY = Height - 2;
};

cPeople::cPeople(int x, int y)
{
	mX = x;
	mY = y;
};

void cPeople::Up()
{
	if (mY > 1)
		mY--;
}
void cPeople::Left()
{
	if (mX > 1)
		mX--;
}

void cPeople::Right()
{
	if (mX  < Width - 1)
		mX++;
}

void cPeople::Down()
{
	if (mY < Height)
		mY++;
}


void cPeople::DrawPeople()
{
	ColorPrint(mX, mY,7,char(220));
	ColorPrint(mX, mY+1,7,char(94));
}

bool cPeople::isImpact(vector <Obstacle*> a){
	for(auto i: a){
		if(i->getX() >= mX && i->getX()<=mX+2 && i->getY()>=mY && i->getY()<= mY+1)
		{
			return true;
		}
	}
	return false;
}

bool cPeople::isFinish()
{
	if (mY == 1)
		return true;
	return false;
}

void cPeople::DrawImpact(){
	textcolor(4);
}

string cPeople::save(){
	string ss;
	ss = to_string(mX) + " " + to_string(mY);
	return ss;
}

void cPeople::setPosition(int x, int y)
{
	mX = x;
	mY = y;
}